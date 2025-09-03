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
    extends $StreamNotifierProvider<ConfluxInstance, Conflux?> {
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

String _$confluxInstanceHash() => r'558b7f0acc22759e0b2178a531f428ee74018eb9';

abstract class _$ConfluxInstance extends $StreamNotifier<Conflux?> {
  Stream<Conflux?> build();
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
    extends $StreamNotifierProvider<ConfluxInstanceSession, ConfluxSession?> {
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
    r'5d1f5017a897c57489ee864ec8af4d13ceb76905';

abstract class _$ConfluxInstanceSession
    extends $StreamNotifier<ConfluxSession?> {
  Stream<ConfluxSession?> build();
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
    extends $StreamNotifierProvider<ConfluxInstanceIpLease, IpLease?> {
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
    r'46189c74876b4bc38ac1b7a484a4ae9de96a974c';

abstract class _$ConfluxInstanceIpLease extends $StreamNotifier<IpLease?> {
  Stream<IpLease?> build();
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

String _$veilnetNotiferHash() => r'fde9b716c52b164c816de2f60bd82355551e689b';

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
