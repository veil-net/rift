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

@ProviderFor(SavedVeilnetPref)
const savedVeilnetPrefProvider = SavedVeilnetPrefProvider._();

final class SavedVeilnetPrefProvider
    extends $AsyncNotifierProvider<SavedVeilnetPref, VeilnetPref> {
  const SavedVeilnetPrefProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'savedVeilnetPrefProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$savedVeilnetPrefHash();

  @$internal
  @override
  SavedVeilnetPref create() => SavedVeilnetPref();
}

String _$savedVeilnetPrefHash() => r'957aea2afcf02ee7911dc7174653c7234cc1d60d';

abstract class _$SavedVeilnetPref extends $AsyncNotifier<VeilnetPref> {
  FutureOr<VeilnetPref> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<VeilnetPref>, VeilnetPref>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<VeilnetPref>, VeilnetPref>,
              AsyncValue<VeilnetPref>,
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
    extends $AsyncNotifierProvider<VeilnetNotifer, ConfluxDetails?> {
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

String _$veilnetNotiferHash() => r'feb9dfed75aa4efba61812ac3d6007180397d426';

abstract class _$VeilnetNotifer extends $AsyncNotifier<ConfluxDetails?> {
  FutureOr<ConfluxDetails?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<ConfluxDetails?>, ConfluxDetails?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ConfluxDetails?>, ConfluxDetails?>,
              AsyncValue<ConfluxDetails?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
