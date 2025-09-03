import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rift/models/conflux.dart';
import 'package:rift/models/conflux_session.dart';
import 'package:rift/models/ip_lease.dart';
import 'package:rift/models/veilnet.dart';
import 'package:rift/providers/api_provider.dart';
import 'package:rift/providers/conflux_provider.dart';
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
class ConfluxInstanceName extends _$ConfluxInstanceName {
  @override
  Future<String?> build() async {
    final pref = await ref.watch(prefProvider.future);
    final name = pref.getString('name');
    log('triggered name build');
    return name;
  }

  Future<void> setName(String name) async {
    final pref = await ref.watch(prefProvider.future);
    await pref.setString('name', name);
    ref.invalidateSelf();
  }

  Future<void> clearName() async {
    final pref = await ref.watch(prefProvider.future);
    await pref.remove('name');
    ref.invalidateSelf();
  }
}

@riverpod
class ConfluxInstance extends _$ConfluxInstance {
  @override
  Future<Conflux?> build() async {
    final name = await ref.watch(confluxInstanceNameProvider.future);
    final confluxes = ref.watch(confluxProvider);

    return confluxes.when(
      data: (data) {
        try {
          return data.firstWhere((element) => element.name == name);
        } catch (e) {
          return null;
        }
      },
      loading: () => null,
      error: (_, __) => null,
    );
  }
}

@riverpod
class ConfluxInstanceSession extends _$ConfluxInstanceSession {
  @override
  Future<ConfluxSession?> build() async {
    final supabase = ref.watch(supabaseProvider);
    final confluxInstance = await ref.watch(confluxInstanceProvider.future);

    if (confluxInstance == null) {
      return null;
    }

    return supabase
        .from('conflux_sessions')
        .select()
        .eq('conflux_id', confluxInstance.id)
        .then(
          (data) =>
              data.map((r) => ConfluxSession.fromJson(r)).toList().firstOrNull,
        );
  }
}

@riverpod
class ConfluxInstanceIpLease extends _$ConfluxInstanceIpLease {
  @override
  Future<IpLease?> build() async {
    final supabase = ref.watch(supabaseProvider);
    final confluxInstance = await ref.watch(confluxInstanceProvider.future);

    if (confluxInstance == null) {
      return null;
    }

    return supabase
        .from('ip_leases')
        .select()
        .eq('conflux_id', confluxInstance.id)
        .then(
          (data) =>
              data.map((r) => IpLease.fromJson(r)).toList().firstOrNull,
        );
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
  Future<Veilnet> build() async {
    ref.watch(shouldVeilNetConnectProvider);
    final confluxInstance = await ref.watch(confluxInstanceProvider.future);
    final confluxInstanceSession = await ref.watch(
      confluxInstanceSessionProvider.future,
    );
    final confluxInstanceIpLease = await ref.watch(
      confluxInstanceIpLeaseProvider.future,
    );
    log('veilnet build');
    log('confluxInstance: $confluxInstance');
    log('confluxInstanceSession: $confluxInstanceSession');
    log('confluxInstanceIpLease: $confluxInstanceIpLease');
    return Veilnet(
      conflux: confluxInstance,
      session: confluxInstanceSession,
      ipLease: confluxInstanceIpLease,
    );
  }

  bool isConnected() {
    return state.when(
      data: (veilnet) => veilnet.session != null,
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

  Future<void> connect(String name, String plane, bool public) async {
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
        '/conflux?conflux_name=$name&plane_name=$plane&public=$public',
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
      await ref.read(confluxInstanceNameProvider.notifier).setName(name);
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
      switch (Platform.operatingSystem) {
        case "windows":
          ref.read(confluxProcessProvider.notifier).stopConfluxProcess();
          break;
        case "android":
          await _vpnChannel.invokeMethod<bool>('stop');
      }
      await ref.read(confluxInstanceNameProvider.notifier).clearName();
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
}
