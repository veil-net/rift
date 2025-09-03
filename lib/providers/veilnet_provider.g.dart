// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'veilnet_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(ShouldVeilNetConnect)
const shouldVeilNetConnectProvider = ShouldVeilNetConnectProvider._();

final class ShouldVeilNetConnectProvider
    extends $NotifierProvider<ShouldVeilNetConnect, bool> {
  const ShouldVeilNetConnectProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shouldVeilNetConnectProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shouldVeilNetConnectHash();

  @$internal
  @override
  ShouldVeilNetConnect create() => ShouldVeilNetConnect();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$shouldVeilNetConnectHash() =>
    r'7eac307f27526f8b29c1ef49274af12c9b4a7398';

abstract class _$ShouldVeilNetConnect extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(ConfluxInstanceName)
const confluxInstanceNameProvider = ConfluxInstanceNameProvider._();

final class ConfluxInstanceNameProvider
    extends $AsyncNotifierProvider<ConfluxInstanceName, String?> {
  const ConfluxInstanceNameProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'confluxInstanceNameProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$confluxInstanceNameHash();

  @$internal
  @override
  ConfluxInstanceName create() => ConfluxInstanceName();
}

String _$confluxInstanceNameHash() =>
    r'7d3c469c0bfd8bf3c2cb62385d3f7ed1a6f9d059';

abstract class _$ConfluxInstanceName extends $AsyncNotifier<String?> {
  FutureOr<String?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<String?>, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String?>, String?>,
              AsyncValue<String?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(ConfluxInstance)
const confluxInstanceProvider = ConfluxInstanceProvider._();

final class ConfluxInstanceProvider
    extends $AsyncNotifierProvider<ConfluxInstance, Conflux?> {
  const ConfluxInstanceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'confluxInstanceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$confluxInstanceHash();

  @$internal
  @override
  ConfluxInstance create() => ConfluxInstance();
}

String _$confluxInstanceHash() => r'91871f30cafc019febc3b81512fd512891525903';

abstract class _$ConfluxInstance extends $AsyncNotifier<Conflux?> {
  FutureOr<Conflux?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<Conflux?>, Conflux?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Conflux?>, Conflux?>,
              AsyncValue<Conflux?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(ConfluxInstanceSession)
const confluxInstanceSessionProvider = ConfluxInstanceSessionProvider._();

final class ConfluxInstanceSessionProvider
    extends $AsyncNotifierProvider<ConfluxInstanceSession, ConfluxSession?> {
  const ConfluxInstanceSessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'confluxInstanceSessionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$confluxInstanceSessionHash();

  @$internal
  @override
  ConfluxInstanceSession create() => ConfluxInstanceSession();
}

String _$confluxInstanceSessionHash() =>
    r'1dd53dc493d52b69c74e01da33b67bee4bd65ea7';

abstract class _$ConfluxInstanceSession
    extends $AsyncNotifier<ConfluxSession?> {
  FutureOr<ConfluxSession?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<ConfluxSession?>, ConfluxSession?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ConfluxSession?>, ConfluxSession?>,
              AsyncValue<ConfluxSession?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(ConfluxInstanceIpLease)
const confluxInstanceIpLeaseProvider = ConfluxInstanceIpLeaseProvider._();

final class ConfluxInstanceIpLeaseProvider
    extends $AsyncNotifierProvider<ConfluxInstanceIpLease, IpLease?> {
  const ConfluxInstanceIpLeaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'confluxInstanceIpLeaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$confluxInstanceIpLeaseHash();

  @$internal
  @override
  ConfluxInstanceIpLease create() => ConfluxInstanceIpLease();
}

String _$confluxInstanceIpLeaseHash() =>
    r'9c70e4ea5bb6b4e811170a8c15d71bdab502f0e2';

abstract class _$ConfluxInstanceIpLease extends $AsyncNotifier<IpLease?> {
  FutureOr<IpLease?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<IpLease?>, IpLease?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<IpLease?>, IpLease?>,
              AsyncValue<IpLease?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(ConfluxProcess)
const confluxProcessProvider = ConfluxProcessProvider._();

final class ConfluxProcessProvider
    extends $NotifierProvider<ConfluxProcess, Process?> {
  const ConfluxProcessProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'confluxProcessProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$confluxProcessHash();

  @$internal
  @override
  ConfluxProcess create() => ConfluxProcess();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Process? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Process?>(value),
    );
  }
}

String _$confluxProcessHash() => r'5deda0b23c59bf1924927edcb05bd70e0b299ab2';

abstract class _$ConfluxProcess extends $Notifier<Process?> {
  Process? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Process?, Process?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Process?, Process?>,
              Process?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(VeilnetNotifer)
const veilnetNotiferProvider = VeilnetNotiferProvider._();

final class VeilnetNotiferProvider
    extends $AsyncNotifierProvider<VeilnetNotifer, Veilnet> {
  const VeilnetNotiferProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'veilnetNotiferProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$veilnetNotiferHash();

  @$internal
  @override
  VeilnetNotifer create() => VeilnetNotifer();
}

String _$veilnetNotiferHash() => r'd34a632f58efa01d7928177fb1450d93976b5413';

abstract class _$VeilnetNotifer extends $AsyncNotifier<Veilnet> {
  FutureOr<Veilnet> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<Veilnet>, Veilnet>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Veilnet>, Veilnet>,
              AsyncValue<Veilnet>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
