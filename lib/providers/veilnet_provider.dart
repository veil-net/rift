import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rift/models/conflux_details.dart';
import 'package:rift/models/plane.dart';
import 'package:rift/models/veilnet_pref.dart';
import 'package:rift/providers/api_provider.dart';
import 'package:rift/providers/conflux_session_provider.dart';
import 'package:rift/providers/ip_lease_provider.dart';
import 'package:rift/providers/pref_provider.dart';
import 'package:rift/providers/supabase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'veilnet_provider.g.dart';

final _vpnChannel = MethodChannel('veilnet/service');

@riverpod
class ShouldVeilNetConnect extends _$ShouldVeilNetConnect {
  @override
  bool build() {
    return false;
  }

  void setShouldConnect(bool shouldConnect) {
    state = shouldConnect;
  }
}

@riverpod
class SavedVeilnetPref extends _$SavedVeilnetPref {
  @override
  Future<VeilnetPref> build() async {
    final pref = await ref.watch(prefProvider.future);
    final name = pref.getString('name');
    final planeID = pref.getString('plane_id');
    return VeilnetPref(name: name, planeID: planeID);
  }

  Future<void> setVeilnetPref(String name, String planeID) async {
    final pref = await ref.watch(prefProvider.future);
    await pref.setString('name', name);
    await pref.setString('plane_id', planeID);
    ref.invalidateSelf();
  }

  Future<void> clearVeilnetPref() async {
    final pref = await ref.watch(prefProvider.future);
    await pref.remove('name');
    await pref.remove('plane_id');
    ref.invalidateSelf();
  }
}

@riverpod
class ConfluxProcess extends _$ConfluxProcess {
  @override
  Process? build() {
    return null;
  }

  Future<void> startConfluxProcess(String anchorToken) async {
    final byteData = await rootBundle.load('assets/bin/windows/conflux.exe');
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/conflux.exe');
    await file.writeAsBytes(byteData.buffer.asUint8List());
    final arguments = ['up', '-t', anchorToken.toString()];

    final process = await Process.start(file.path, arguments);
    state = process;
  }

  void stopConfluxProcess() {
    state?.kill();
    state = null;
  }
}

@riverpod
class VeilnetNotifer extends _$VeilnetNotifer {
  @override
  Future<ConfluxDetails?> build() async {
    ref.watch(confluxSessionProvider);
    ref.watch(ipLeaseProvider);
    final supabase = ref.watch(supabaseProvider);
    final savedPref = await ref.watch(savedVeilnetPrefProvider.future);

    if (savedPref.name == null || savedPref.planeID == null) {
      return null;
    }

    final details =
        await supabase
            .from('conflux_details')
            .select('*')
            .eq('name', savedPref.name!)
            .eq('plane_id', savedPref.planeID!)
            .single();

    return ConfluxDetails.fromJson(details);
  }

  bool isConnected() {
    return state.when(
      data: (veilnet) => veilnet?.signature != null,
      loading: () => false,
      error: (_, __) => false,
    );
  }

  bool isBusy() {
    final shouldConnect = ref.watch(shouldVeilNetConnectProvider);
    if (shouldConnect == isConnected()) {
      return false;
    }
    return true;
  }

  Future<void> connect(String name, Plane plane) async {
    if (isBusy()) {
      throw Exception('Veilnet is busy');
    }

    if (isConnected()) {
      throw Exception('Veilnet is already connected');
    }

    ref.read(shouldVeilNetConnectProvider.notifier).setShouldConnect(true);
    try {
      final api = await ref.watch(apiProvider.future);
      final response = await api.post(
        '/conflux?conflux_name=$name&plane_name=${plane.name}&public=${plane.public}',
      );
      final anchorToken = response.data;
      switch (Platform.operatingSystem) {
        case "windows":
          await ref
              .read(confluxProcessProvider.notifier)
              .startConfluxProcess(anchorToken);
          break;
        case "android":
          final success = await _vpnChannel.invokeMethod<bool>('start', {
            "guardian": api.options.baseUrl,
            "token": anchorToken,
          });

          if (success != true) {
            throw Exception('Failed to start the VPN service');
          }
          break;
      }
      await ref.read(savedVeilnetPrefProvider.notifier).setVeilnetPref(name, plane.id);
    } on Exception catch (e) {
      log('Exception: $e');
      ref.read(shouldVeilNetConnectProvider.notifier).setShouldConnect(false);
      rethrow;
    } finally {
      Future.delayed(const Duration(seconds: 30), () {
        if (isBusy()) {
          ref
              .read(shouldVeilNetConnectProvider.notifier)
              .setShouldConnect(isConnected());
        }
      });
    }
  }

  Future<void> disconnect() async {
    try {
      ref.read(shouldVeilNetConnectProvider.notifier).setShouldConnect(false);
      switch (Platform.operatingSystem) {
        case "windows":
          ref.read(confluxProcessProvider.notifier).stopConfluxProcess();
          break;
        case "android":
          await _vpnChannel.invokeMethod<bool>('stop');
      }
      // await ref.read(savedVeilnetPrefProvider.notifier).clearVeilnetPref();
    } on Exception catch (e) {
      log('Exception: $e');
      ref.read(shouldVeilNetConnectProvider.notifier).setShouldConnect(true);
      rethrow;
    } finally {
      Future.delayed(const Duration(seconds: 30), () {
        if (isBusy()) {
          ref
              .read(shouldVeilNetConnectProvider.notifier)
              .setShouldConnect(isConnected());
        }
      });
    }
  }
}
