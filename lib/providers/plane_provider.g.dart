// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plane_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(planes)
const planesProvider = PlanesProvider._();

final class PlanesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Plane>>,
          List<Plane>,
          Stream<List<Plane>>
        >
    with $FutureModifier<List<Plane>>, $StreamProvider<List<Plane>> {
  const PlanesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'planesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$planesHash();

  @$internal
  @override
  $StreamProviderElement<List<Plane>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Plane>> create(Ref ref) {
    return planes(ref);
  }
}

String _$planesHash() => r'cbd7c7392c3a2c7485244fef6009b276c5e13d8f';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
