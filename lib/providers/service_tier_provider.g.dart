// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_tier_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(ServiceTier)
const serviceTierProvider = ServiceTierProvider._();

final class ServiceTierProvider
    extends $AsyncNotifierProvider<ServiceTier, int> {
  const ServiceTierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serviceTierProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$serviceTierHash();

  @$internal
  @override
  ServiceTier create() => ServiceTier();
}

String _$serviceTierHash() => r'8cb6c032294fdf3c47afdce6a85768f3e7a2a4a3';

abstract class _$ServiceTier extends $AsyncNotifier<int> {
  FutureOr<int> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<int>, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<int>, int>,
              AsyncValue<int>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
