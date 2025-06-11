import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../veilnet.pb.dart';
import '../main.dart';

String stripAnsiColors(String text) =>
    text.replaceAll(RegExp(r'\x1B\[[0-9;]*[a-zA-Z]'), '');

const _vpnChannel = MethodChannel('veilnet/channel');

class IpcResult {
  final Header header;
  final IpcResponse response;

  IpcResult(this.header, this.response);
}

class VeilNetState {
  final bool isRunning;
  final bool isConnected;
  final bool isBusy;
  final List<String> logs;
  final Process? process;
  final String? anchorName;
  final String? domain;
  final String? region;
  final bool? public;

  VeilNetState({
    this.isRunning = false,
    this.isConnected = false,
    this.isBusy = false,
    this.logs = const [],
    this.process,
    this.anchorName,
    this.domain,
    this.region,
    this.public,
  });

  VeilNetState copyWith({
    bool? isRunning,
    bool? isConnected,
    bool? isBusy,
    List<String>? logs,
    Process? process,
    String? anchorName,
    String? domain,
    String? region,
    bool? public,
  }) {
    return VeilNetState(
      isRunning: isRunning ?? this.isRunning,
      isConnected: isConnected ?? this.isConnected,
      isBusy: isBusy ?? this.isBusy,
      logs: logs ?? this.logs,
      process: process ?? this.process,
      anchorName: anchorName ?? this.anchorName,
      domain: domain ?? this.domain,
      region: region ?? this.region,
      public: public ?? this.public,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'anchorName': anchorName,
      'domain': domain,
      'region': region,
      'public': public,
    };
  }

  factory VeilNetState.fromJson(Map<String, dynamic> json) {
    return VeilNetState(
      anchorName: json['anchorName'],
      domain: json['domainName'],
      region: json['region'],
      public: json['public'],
    );
  }
}

class VeilNetNotifier extends StateNotifier<VeilNetState> {
  VeilNetNotifier() : super(VeilNetState()) {
    _loadState();
  }

  Future<bool> _fetchRiftSession() async {
    // Check if the user is logged in
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return false;

    // Check if the domain, anchor name, region, and public are set
    if (state.domain == null ||
        state.anchorName == null ||
        state.region == null ||
        state.public == null) {
      return false;
    }

    final domain =
        state.public!
            ? await supabase
                .from('public_domains')
                .select('id')
                .eq('name', state.domain!)
                .eq('region', state.region!)
            : await supabase
                .from('private_domains')
                .select('id')
                .eq('name', state.domain!)
                .eq('region', state.region!)
                .eq('user_id', userId);

    final rift =
        state.public!
            ? await supabase
                .from('public_rifts')
                .select('*')
                .eq('domain_id', domain.first['id'])
                .eq('name', state.anchorName!)
                .eq('user_id', userId)
            : await supabase
                .from('private_rifts')
                .select('*')
                .eq('domain_id', domain.first['id'])
                .eq('name', state.anchorName!)
                .eq('user_id', userId);

    if (rift.isEmpty) return false;

    return true;
  }

  Future<void> _loadState() async {
    try {
      // Load the saved state from the shared preferences
      final prefs = await SharedPreferences.getInstance();
      final savedState = prefs.getString('veilnet_state');

      // If there is no saved state, set the state to the default values
      if (savedState == null) {
        state = state.copyWith(
          isConnected: false,
          anchorName: null,
          domain: null,
          region: null,
          public: null,
        );
        return;
      }

      // If there is a saved state, set the state to the saved values
      final savedStateJson = json.decode(savedState);
      state = state.copyWith(
        anchorName: savedStateJson['anchorName'],
        domain: savedStateJson['domain'],
        region: savedStateJson['region'],
        public: savedStateJson['public'],
      );

      // If the rift session exists, set the state to connected
      final riftSessionExists = await _fetchRiftSession();
      if (riftSessionExists) {
        state = state.copyWith(isConnected: true);
        return;
      } else {
        // If the rift session does not exist, set the state to disconnected
        state = state.copyWith(
          isConnected: false,
          anchorName: null,
          domain: null,
          region: null,
          public: null,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isConnected: false,
        anchorName: null,
        domain: null,
        region: null,
        public: null,
      );
    } finally {
      await _saveState();
    }
  }

  Future<void> _saveState() async {
    final prefs = await SharedPreferences.getInstance();
    // Create a copy of the state without isRunning and isBusy
    final stateToSave = {
      'anchorName': state.anchorName,
      'domain': state.domain,
      'region': state.region,
      'public': state.public,
    };
    await prefs.setString('veilnet_state', json.encode(stateToSave));
  }

  @override
  set state(VeilNetState newState) {
    super.state = newState;
    _saveState();
  }

  Future<void> startDaemon() async {
    if (state.isRunning) return;

    try {
      switch (Platform.operatingSystem) {
        case "windows":
          final byteData = await rootBundle.load(
            'assets/bin/veilnet-daemon-windows',
          );
          final tempDir = await getTemporaryDirectory();
          final file = File('${tempDir.path}/veilnet-daemon');
          await file.writeAsBytes(byteData.buffer.asUint8List());
          final process = await Process.start(file.path, []);
          process.stdout
              .transform(utf8.decoder)
              .listen(
                (line) =>
                    state = state.copyWith(
                      logs: [...state.logs, stripAnsiColors(line)],
                    ),
              );
          process.stderr
              .transform(utf8.decoder)
              .listen(
                (line) =>
                    state = state.copyWith(
                      logs: [...state.logs, stripAnsiColors(line)],
                    ),
              );
          state = state.copyWith(isRunning: true, process: process);
          break;
        case "linux":
        case "macos":
        case "android":
          state = state.copyWith(isRunning: true);
          break;
        default:
          throw Exception('Unsupported platform: ${Platform.operatingSystem}');
      }
    } catch (e) {
      throw Exception('Failed to start daemon: $e');
    }
  }

  Future<void> stopDaemon() async {
    if (!state.isRunning) return;
    try {
      state.process?.kill();
      state = state.copyWith(
        isRunning: false,
        process: null,
        isConnected: false,
        anchorName: null,
        domain: null,
        region: null,
        public: null,
      );
    } catch (e) {
      throw Exception('Failed to stop daemon: $e');
    }
  }

  void clearLogs() => state = state.copyWith(logs: []);

  Future<IpcResult> sendIpcRequest(MessageType type, Uint8List body) async {
    final socket = await Socket.connect('127.0.0.1', 3000);
    final completer = Completer<IpcResult>();
    final buffer = BytesBuilder();

    final header = Header(type: type, version: 1, length: body.length);
    final headerBytes = header.writeToBuffer();
    final preHeader = ByteData(4)..setUint32(0, headerBytes.length);
    final payload = preHeader.buffer.asUint8List() + headerBytes + body;
    socket.add(payload);

    socket.listen(
      (chunk) {
        buffer.add(chunk);
        final data = buffer.toBytes();
        if (data.length < 4) return;
        final headerLen = ByteData.sublistView(data, 0, 4).getUint32(0);
        if (data.length < 4 + headerLen) return;
        final responseHeader = Header.fromBuffer(
          data.sublist(4, 4 + headerLen),
        );
        final totalLen = 4 + headerLen + responseHeader.length;
        if (data.length < totalLen) return;
        final bodyBytes = data.sublist(4 + headerLen, totalLen);
        completer.complete(
          IpcResult(responseHeader, IpcResponse.fromBuffer(bodyBytes)),
        );
        socket.destroy();
      },
      onError: (err) {
        socket.destroy();
        completer.completeError(Exception('Socket error: $err'));
      },
      onDone: () {
        if (!completer.isCompleted) {
          completer.completeError(Exception('Socket closed prematurely'));
        }
      },
    );

    return completer.future.timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        socket.destroy();
        throw Exception('IPC response timeout');
      },
    );
  }

  Future<void> connect(
    String apiBaseUrl,
    String anchorToken,
    String anchorName,
    String domainName,
    String region,
    bool public,
  ) async {
    try {
      if (state.isBusy) {
        throw Exception('Daemon is busy, please wait for it to finish');
      }
      state = state.copyWith(isBusy: true);
      switch (Platform.operatingSystem) {
        case "windows":
          if (!state.isRunning || state.isConnected) {
            throw Exception('Daemon is not running, or already connected');
          }
          final request = IpcStart(
            apiBaseUrl: apiBaseUrl,
            anchorToken: anchorToken,
            anchorName: anchorName,
            domainName: domainName,
            region: region,
            public: public,
          );
          final result = await sendIpcRequest(
            MessageType.IPC_START,
            request.writeToBuffer(),
          );
          if (result.header.type != MessageType.IPC_ACK) {
            throw Exception(result.response.response);
          }
          break;

        case "android":
          // Request VPN permission first
          final granted = await _vpnChannel.invokeMethod<bool>(
            'requestVpnPermission',
          );
          if (granted != true) {
            throw Exception('VPN permission was not granted by the user');
          }

          // Then start the VPN service
          final success = await _vpnChannel.invokeMethod<bool>(
            'startVpnService',
            {
              'config': {
                'api_base_url': apiBaseUrl,
                'anchor_token': anchorToken,
                'anchor_name': anchorName,
                'domain': domainName,
                'region': region,
                'public': public,
              },
            },
          );

          if (success != true) {
            throw Exception('Failed to start the VPN service');
          }
          break;

        case "linux":
        case "macos":
        case "ios":
          // TODO: Implement logic for Linux/macOS if needed
          break;
      }

      state = state.copyWith(
        anchorName: anchorName,
        domain: domainName,
        region: region,
        public: public,
      );

      if (await _fetchRiftSession()) {
        state = state.copyWith(isConnected: true);
      } else {
        state = state.copyWith(
          isConnected: false,
          anchorName: null,
          domain: null,
          region: null,
          public: null,
        );
        throw Exception('Failed to find rift session');
      }
    } catch (e) {
      throw Exception('Failed to connect: $e');
    } finally {
      state = state.copyWith(isBusy: false);
    }
  }

  Future<void> disconnect() async {
    if (state.isBusy) {
      throw Exception('Daemon is busy, please wait for it to finish');
    }
    try {
      state = state.copyWith(isBusy: true);
      switch (Platform.operatingSystem) {
        case "windows":
          if (!state.isRunning || !state.isConnected) {
            throw Exception('Daemon is not running, or not connected');
          }
          final result = await sendIpcRequest(
            MessageType.IPC_STOP,
            IpcStop().writeToBuffer(),
          );
          if (result.header.type != MessageType.IPC_ACK) {
            throw Exception(
              'Failed to disconnect: ${result.response.response}',
            );
          }
          break;

        case "android":
          // if (!state.isConnected || state.isBusy) {
          //   throw Exception('Invalid daemon state');
          // }
          final success = await _vpnChannel.invokeMethod<bool>("shutdownVpn");
          if (success != true) {
            throw Exception("Failed to shutdown VPN on Android");
          }
          break;

        case "linux":
        case "macos":
        case "ios":
          // TODO: implement shutdown logic if needed
          break;
      }

      state = state.copyWith(
        anchorName: null,
        domain: null,
        region: null,
        public: null,
        isConnected: false,
      );
    } catch (e) {
      throw Exception('Failed to disconnect: $e');
    } finally {
      state = state.copyWith(isBusy: false);
    }
  }
}

final veilnetNotifierProvider =
    StateNotifierProvider<VeilNetNotifier, VeilNetState>((ref) {
      return VeilNetNotifier();
    });
