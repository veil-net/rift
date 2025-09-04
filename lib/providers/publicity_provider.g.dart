// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publicity_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(Publicity)
const publicityProvider = PublicityProvider._();

final class PublicityProvider extends $NotifierProvider<Publicity, bool> {
  const PublicityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'publicityProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$publicityHash();

  @$internal
  @override
  Publicity create() => Publicity();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$publicityHash() => r'9bc005cce4d74ab452e38de8a3db27ccbe1c7603';

abstract class _$Publicity extends $Notifier<bool> {
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

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
