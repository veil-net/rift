// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ip_lease_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(ipLease)
const ipLeaseProvider = IpLeaseProvider._();

final class IpLeaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<IpLease>>,
          List<IpLease>,
          Stream<List<IpLease>>
        >
    with $FutureModifier<List<IpLease>>, $StreamProvider<List<IpLease>> {
  const IpLeaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ipLeaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ipLeaseHash();

  @$internal
  @override
  $StreamProviderElement<List<IpLease>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<IpLease>> create(Ref ref) {
    return ipLease(ref);
  }
}

String _$ipLeaseHash() => r'c01037709e4aa9df41d40518fd9ab3da88f3f4c6';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
