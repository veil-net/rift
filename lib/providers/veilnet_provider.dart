// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rift/providers/api_provider.dart';
import 'package:rift/providers/conflux_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _vpnChannel = MethodChannel('veilnet/channel');

class VeilNet {
  final String? name;
  final String? plane;
  final Conflux? conflux;
  final Process? process;
  final bool isBusy;
  VeilNet({
    this.name,
    this.plane,
    this.conflux,
    this.process,
    required this.isBusy,
  });

  VeilNet copyWith({
    String? name,
    String? plane,
    Conflux? conflux,
    Process? process,
    bool? isBusy,
  }) {
    return VeilNet(
      name: name ?? this.name,
      plane: plane ?? this.plane,
      conflux: conflux ?? this.conflux,
      process: process ?? this.process,
      isBusy: isBusy ?? this.isBusy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'name': name, 'plane': plane, 'isBusy': isBusy};
  }

  factory VeilNet.fromMap(Map<String, dynamic> map) {
    return VeilNet(
      name: map['name'] != null ? map['name'] as String : null,
      plane: map['plane'] != null ? map['plane'] as String : null,
      isBusy: map['isBusy'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory VeilNet.fromJson(String source) =>
      VeilNet.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VeilNet(name: $name, plane: $plane, conflux: $conflux, process: $process, isBusy: $isBusy)';
  }

  @override
  bool operator ==(covariant VeilNet other) {
    if (identical(this, other)) return true;

    return other.name == name && other.plane == plane;
  }

  @override
  int get hashCode {
    return name.hashCode ^ plane.hashCode;
  }

  bool get isConnected => conflux != null && conflux!.signature != null;
}

class VeilNetNotifier extends StateNotifier<VeilNet> {
  final Ref ref;
  Timer? _timer;
  VeilNetNotifier(this.ref) : super(VeilNet(isBusy: false)) {
    _loadState();
  }

  Future<void> _loadState() async {
    // Load name and plane from prefs
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('name');
    final plane = prefs.getString('plane');
    state = state.copyWith(name: name, plane: plane);

    // Load conflux from provider
    if (name != null && plane != null) {
      ref.invalidate(confluxProvider((name, plane)));
      final conflux = await ref.read(confluxProvider((name, plane)).future);
      state = state.copyWith(conflux: conflux);
    }

    // Start timer to refresh conflux every 5 seconds
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      if (state.name != null && state.plane != null) {
        ref.invalidate(confluxProvider((state.name!, state.plane!)));
        final conflux = await ref.read(
          confluxProvider((state.name!, state.plane!)).future,
        );
        if (state.conflux != conflux) {
          state = state.copyWith(conflux: conflux);
          if (state.isBusy) {
            state = state.copyWith(isBusy: false);
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> connect(String name, String plane) async {
    if (state.isBusy) {
      throw Exception('Daemon is busy, please wait for it to finish');
    }

    if (state.isConnected) {
      throw Exception('Please disconnect first');
    }

    state = state.copyWith(isBusy: true);

    try {
      // Get anchor token
      final api = ref.read(apiProvider);
      final response = await api.post(
        '/conflux?conflux_name=$name&plane_name=$plane',
      );
      final anchorToken = response.data;
      log('Anchor token: $anchorToken');

      switch (Platform.operatingSystem) {
        case "windows":
          final byteData = await rootBundle.load(
            'assets/bin/windows/veilnet-daemon',
          );
          final tempDir = await getTemporaryDirectory();
          final file = File('${tempDir.path}/veilnet-daemon');
          await file.writeAsBytes(byteData.buffer.asUint8List());
          final arguments = ['-t', anchorToken];

          final process = await Process.start(
            file.path,
            arguments as List<String>,
          );
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
    } catch (e) {
      state = state.copyWith(isBusy: false);
      rethrow;
    }
  }

  Future<void> disconnect() async {
    if (state.isBusy) {
      throw Exception('Daemon is busy, please wait for it to finish');
    }

    if (!state.isConnected) {
      throw Exception('Already disconnected');
    }

    try {
      state = state.copyWith(isBusy: true);
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
    } catch (e) {
      state = state.copyWith(isBusy: false);
      rethrow;
    }
  }
}

final veilnetProvider = StateNotifierProvider<VeilNetNotifier, VeilNet>((ref) {
  return VeilNetNotifier(ref);
});
