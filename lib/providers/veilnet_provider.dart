import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../veilnet.pb.dart';

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
  final String? anchorID;
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
    this.anchorID,
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
    String? anchorID,
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
      anchorID: anchorID ?? this.anchorID,
      domain: domain ?? this.domain,
      region: region ?? this.region,
      public: public ?? this.public,
    );
  }

  Map<String, dynamic> toJson() {
    return {'anchorName': anchorName};
  }

  factory VeilNetState.fromJson(Map<String, dynamic> json) {
    return VeilNetState(anchorName: json['anchorName']);
  }
}

class VeilNetNotifier extends StateNotifier<VeilNetState> {
  Timer? _stateCheckTimer;

  VeilNetNotifier() : super(VeilNetState()) {
    _loadState();
    _startPeriodicStateCheck();
  }

  void _startPeriodicStateCheck() {
    _stateCheckTimer?.cancel();
    _stateCheckTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _loadState();
    });
  }

  @override
  void dispose() {
    _stateCheckTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadState() async {

    // Load state from prefs
    final prefs = await SharedPreferences.getInstance();
    final anchorName = prefs.getString('anchorName');
    final public = prefs.getBool('public');

    // If anchorName or public is null, set state to disconnected
    if (anchorName == null || public == null) {
      state = state.copyWith(
        anchorName: null,
        anchorID: null,
        domain: null,
        region: null,
        public: null,
        isConnected: false,
        isBusy: false,
      );
      return;
    }

    // Start checking state from supabase
    state = state.copyWith(anchorName: anchorName, public: public);
    Timer.periodic(const Duration(seconds: 5), (timer) async {
      final riftDetails =
          public
              ? await supabase
                  .from('public_rift_details')
                  .select('*')
                  .eq('name', state.anchorName ?? '')
              : await supabase
                  .from('private_rift_details')
                  .select('*')
                  .eq('name', state.anchorName ?? '');

      if (riftDetails.isNotEmpty) {
        state = state.copyWith(
          isConnected: true,
          anchorID: riftDetails.first['id'],
          domain: riftDetails.first['domain'],
          region: riftDetails.first['region'],
        );
      } else {
        state = state.copyWith(isConnected: false);
      }
    });
  }

  Future<void> _saveState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('anchorName', state.anchorName ?? '');
    await prefs.setBool('public', state.public ?? false);
  }

  Future<void> _fetchStateAfterConnect() async {
    final startAt = DateTime.now();
    Timer.periodic(const Duration(seconds: 5), (timer) async {
      final riftDetails =
          state.public!
              ? await supabase
                  .from('public_rift_details')
                  .select('*')
                  .eq('name', state.anchorName ?? '')
              : await supabase
                  .from('private_rift_details')
                  .select('*')
                  .eq('name', state.anchorName ?? '');

      if (riftDetails.isNotEmpty) {
        state = state.copyWith(
          isConnected: true,
          isBusy: false,
          anchorID: riftDetails.first['id'],
          domain: riftDetails.first['domain'],
          region: riftDetails.first['region'],
        );
        timer.cancel();
      }

      if (DateTime.now().difference(startAt).inSeconds > 15) {
        state = state.copyWith(isBusy: false);
        timer.cancel();
      }
    });
  }

  Future<void> _fetchStateAfterDisconnect() async {
    final startAt = DateTime.now();
    Timer.periodic(const Duration(seconds: 5), (timer) async {
      final riftDetails =
          state.public!
              ? await supabase
                  .from('public_rift_details')
                  .select('*')
                  .eq('name', state.anchorName ?? '')
              : await supabase
                  .from('private_rift_details')
                  .select('*')
                  .eq('name', state.anchorName ?? '');

      if (riftDetails.isEmpty) {
        state = state.copyWith(
          isConnected: false,
          isBusy: false,
          anchorID: null,
          domain: null,
          region: null,
        );
        timer.cancel();
      }

      if (DateTime.now().difference(startAt).inSeconds > 15) {
        state = state.copyWith(isBusy: false);
        timer.cancel();
      }
    });
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
      log('Failed to start daemon', error: e);
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
      );
    } catch (e) {
      log('Failed to stop daemon', error: e);
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
      }

      state = state.copyWith(anchorName: anchorName, public: public);
    } catch (e) {
      throw Exception('Failed to connect: $e');
    } finally {
      await _saveState();
      await _fetchStateAfterConnect();
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
          if (!state.isConnected) {
            throw Exception('Invalid daemon state');
          }
          final success = await _vpnChannel.invokeMethod<bool>("shutdownVpn");
          if (success != true) {
            throw Exception("Failed to shutdown VPN on Android");
          }
          break;
      }
    } catch (e) {
      throw Exception('Failed to disconnect: $e');
    } finally {
      await _saveState();
      await _fetchStateAfterDisconnect();
    }
  }
}

final veilnetNotifierProvider =
    StateNotifierProvider<VeilNetNotifier, VeilNetState>((ref) {
      return VeilNetNotifier();
    });
