import 'dart:developer';

import 'package:rift/models/conflux.dart';
import 'package:rift/models/conflux_session.dart';
import 'package:rift/models/ip_lease.dart';
import 'package:rift/models/veilnet.dart';
import 'package:rift/providers/api_provider.dart';
import 'package:rift/providers/pref_provider.dart';
import 'package:rift/providers/supabase_provider.dart'; 
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'veilnet_provider.g.dart';

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
  Stream<Conflux?> build() {
    final supabase = ref.watch(supabaseProvider);
    final name = ref.watch(confluxInstanceNameProvider);
    final stream = supabase
        .from('confluxes')
        .stream(primaryKey: ['id'])
        .eq('name', name)
        .map(
          (event) => event.map((r) => Conflux.fromJson(r)).toList().firstOrNull,
        );
    log('triggered conflux build');
    return stream;
  }
}

@riverpod
class ConfluxInstanceSession extends _$ConfluxInstanceSession {
  @override
  Stream<ConfluxSession?> build() {
    final supabase = ref.watch(supabaseProvider);
    final confluxInstance = ref.watch(confluxInstanceProvider);
    log('triggered session build');

    return confluxInstance.when(
      data: (data) {
        if (data == null) {
          return Stream.value(null);
        }

        return supabase
            .from('conflux_sessions')
            .stream(primaryKey: ['id'])
            .eq('conflux_id', data.id)
            .map(
              (event) => event
                  .map((r) => ConfluxSession.fromJson(r))
                  .toList()
                  .firstOrNull,
            );
      },
      error: (error, stackTrace) => Stream.value(null),
      loading: () => Stream.value(null),
    );
  }
}

@riverpod
class ConfluxInstanceIpLease extends _$ConfluxInstanceIpLease {
  @override
  Stream<IpLease?> build() {
    final supabase = ref.watch(supabaseProvider);
    final confluxInstance = ref.watch(confluxInstanceProvider);
    log('triggered ip lease build');
    return confluxInstance.when(
      data: (data) {
        if (data == null) {
          return Stream.value(null);
        }

        return supabase
            .from('ip_leases')
            .stream(primaryKey: ['id'])
            .eq('conflux_id', data.id)
            .map(
              (event) =>
                  event.map((r) => IpLease.fromJson(r)).toList().firstOrNull,
            );
      },
      error: (error, stackTrace) => Stream.value(null),
      loading: () => Stream.value(null),
    );
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
    return Veilnet(
      conflux: confluxInstance,
      session: confluxInstanceSession,
      ipLease: confluxInstanceIpLease,
    );
  }

  bool isConnected() {
    return state.when(
      data: (data) => data.session != null,
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
      await ref.read(confluxInstanceNameProvider.notifier).setName(name);
    } on DioException catch (e) {
      log('DioException: ${e.response?.data}');
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

  Future<void> disconnect() async {}
}
