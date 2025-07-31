// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rift/main.dart';
import 'package:rift/providers/api_provider.dart';
import 'package:rift/providers/conflux_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _vpnChannel = MethodChannel('veilnet/channel');

final logProvider = StateProvider<List<String>>((ref) => []);

String stripAnsiCodes(String text) {
  // Remove ANSI color codes (ESC[ followed by numbers and ending with m)
  return text.replaceAll(RegExp(r'\x1B\[[0-9;]*[a-zA-Z]'), '');
}

class VeilNet {
  final String? name;
  final String? plane;
  final Conflux? conflux;
  final Process? process;
  final bool isBusy;
  final bool shouldConnect;
  VeilNet({
    this.name,
    this.plane,
    this.conflux,
    this.process,
    required this.isBusy,
    required this.shouldConnect,
  });

  VeilNet copyWith({
    String? name,
    String? plane,
    Conflux? conflux,
    Process? process,
    bool? isBusy,
    bool? shouldConnect,
  }) {
    return VeilNet(
      name: name ?? this.name,
      plane: plane ?? this.plane,
      conflux: conflux ?? this.conflux,
      process: process ?? this.process,
      isBusy: isBusy ?? this.isBusy,
      shouldConnect: shouldConnect ?? this.shouldConnect,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'plane': plane,
      'isBusy': isBusy,
      'shouldConnect': shouldConnect,
    };
  }

  factory VeilNet.fromMap(Map<String, dynamic> map) {
    return VeilNet(
      name: map['name'] != null ? map['name'] as String : null,
      plane: map['plane'] != null ? map['plane'] as String : null,
      isBusy: map['isBusy'] as bool,
      shouldConnect: map['shouldConnect'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory VeilNet.fromJson(String source) =>
      VeilNet.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VeilNet(name: $name, plane: $plane, isBusy: $isBusy, shouldConnect: $shouldConnect)';
  }

  @override
  bool operator ==(covariant VeilNet other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.plane == plane &&
        other.conflux == conflux;
  }

  @override
  int get hashCode {
    return name.hashCode ^ plane.hashCode ^ conflux.hashCode;
  }

  bool get isConnected => conflux != null && conflux!.signature != null;
}

class VeilNetNotifier extends StateNotifier<VeilNet> {
  final Ref ref;
  Timer? busyStateResetTimer;
  Timer? _timer;
  VeilNetNotifier(this.ref)
    : super(VeilNet(isBusy: false, shouldConnect: false)) {
    _loadState();
  }

  Future<void> _loadState() async {
    try {
      // Load name and plane from prefs
      final prefs = await SharedPreferences.getInstance();
      final name = prefs.getString('name');
      final plane = prefs.getString('plane');
      state = state.copyWith(name: name, plane: plane);
      final confluxJson = prefs.getString('conflux');
      if (confluxJson != null) {
        final confluxState = Conflux.fromJson(confluxJson);
        state = state.copyWith(conflux: confluxState);
      }

      // Load conflux from provider
      if (name != null && plane != null && confluxJson == null) {
        final conflux = await supabase
            .from('conflux_details')
            .select('*')
            .eq('name', name)
            .eq('plane', plane);
        state = state.copyWith(
          conflux: conflux.isNotEmpty ? Conflux.fromMap(conflux.first) : null,
        );
      }
    } catch (e) {
      log('Error loading state: $e');
    }

    // Start timer to refresh conflux every 5 seconds
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      try {
        final prefs = await SharedPreferences.getInstance();
        ref.invalidate(confluxesProvider);
        if (state.name != null && state.plane != null) {
          final conflux = await supabase
              .from('conflux_details')
              .select('*')
              .eq('name', state.name!)
              .eq('plane', state.plane!);
          if (conflux.isNotEmpty) {
            final confluxState = Conflux.fromMap(conflux.first);
            state = state.copyWith(conflux: confluxState);
            await prefs.setString('conflux', confluxState.toJson());
          } else {
            state = VeilNet(
              name: state.name,
              plane: state.plane,
              conflux: null,
              isBusy: state.isBusy,
              shouldConnect: state.shouldConnect,
            );
          }
        } else {
          state = VeilNet(
            name: state.name,
            plane: state.plane,
            conflux: null,
            isBusy: state.isBusy,
            shouldConnect: state.shouldConnect,
          );
        }
        if (!state.isBusy && state.shouldConnect != state.isConnected) {
          state = state.copyWith(isBusy: true);
          busyStateResetTimer?.cancel();
          busyStateResetTimer = Timer(const Duration(seconds: 30), () {
            if (state.isBusy) {
              state = state.copyWith(isBusy: false);
            }
          });
        }
        if (state.isBusy && state.shouldConnect == state.isConnected) {
          busyStateResetTimer?.cancel();
          state = state.copyWith(isBusy: false);
          if (!state.isConnected) {
            await prefs.remove('name');
            await prefs.remove('plane');
            await prefs.remove('conflux');
          }
        }
      } catch (e) {
        log('Error refreshing conflux: $e');
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    busyStateResetTimer?.cancel();
    super.dispose();
  }

  Future<void> connect(String name, String plane, bool public) async {
    if (state.isBusy) {
      throw Exception('Daemon is busy, please wait for it to finish');
    }

    if (state.isConnected) {
      state = state.copyWith(shouldConnect: true);
      throw Exception('Please disconnect first');
    }

    state = state.copyWith(isBusy: true, shouldConnect: true);

    try {
      // Get anchor token
      final api = ref.read(apiProvider);
      final response = await api.post(
        '/conflux?conflux_name=$name&plane_name=$plane&public=$public',
      );
      final anchorToken = response.data;

      switch (Platform.operatingSystem) {
        case "windows":
          final byteData = await rootBundle.load(
            'assets/bin/windows/veilnet-conflux.exe',
          );
          final tempDir = await getTemporaryDirectory();
          final file = File('${tempDir.path}/veilnet-conflux.exe');
          await file.writeAsBytes(byteData.buffer.asUint8List());
          final arguments = ['up', '-t', anchorToken.toString()];

          final process = await Process.start(file.path, arguments);
          process.stdout.listen((event) {
            final text = stripAnsiCodes(String.fromCharCodes(event));
            ref.read(logProvider.notifier).update((logs) => [...logs, text]);
          });
          process.stderr.listen((event) {
            final text = stripAnsiCodes(String.fromCharCodes(event));
            ref.read(logProvider.notifier).update((logs) => [...logs, text]);
          });
          state = state.copyWith(process: process);
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
                'guardian_url': api.options.baseUrl,
                'anchor_token': anchorToken,
              },
            },
          );

          if (success != true) {
            throw Exception('Failed to start the VPN service');
          }
          break;
      }
      state = state.copyWith(name: name, plane: plane);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', name);
      await prefs.setString('plane', plane);
    } catch (e) {
      state = state.copyWith(isBusy: false, shouldConnect: false);
      rethrow;
    } finally {
      busyStateResetTimer?.cancel();
      busyStateResetTimer = Timer(const Duration(seconds: 30), () {
        if (state.isBusy) {
          state = state.copyWith(isBusy: false);
        }
      });
    }
  }

  Future<void> disconnect() async {
    if (state.isBusy) {
      throw Exception('Daemon is busy, please wait for it to finish');
    }

    if (!state.isConnected) {
      state = state.copyWith(shouldConnect: false);
      throw Exception('Already disconnected');
    }

    state = state.copyWith(isBusy: true, shouldConnect: false);
    try {
      switch (Platform.operatingSystem) {
        case "windows":
          if (!state.isConnected) {
            throw Exception('Not connected');
          }
          state.process?.kill(ProcessSignal.sigterm);
          state = state.copyWith(process: null);
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
      ref.read(logProvider.notifier).update((logs) => []);
    } catch (e) {
      state = state.copyWith(isBusy: false, shouldConnect: true);
      rethrow;
    } finally {
      busyStateResetTimer?.cancel();
      busyStateResetTimer = Timer(const Duration(seconds: 30), () {
        if (state.isBusy) {
          state = state.copyWith(isBusy: false);
        }
      });
    }
  }
}

final veilnetProvider = StateNotifierProvider<VeilNetNotifier, VeilNet>((ref) {
  return VeilNetNotifier(ref);
});
