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

@ProviderFor(planeByName)
const planeByNameProvider = PlaneByNameFamily._();

final class PlaneByNameProvider
    extends $FunctionalProvider<AsyncValue<Plane?>, Plane?, Stream<Plane?>>
    with $FutureModifier<Plane?>, $StreamProvider<Plane?> {
  const PlaneByNameProvider._({
    required PlaneByNameFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'planeByNameProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$planeByNameHash();

  @override
  String toString() {
    return r'planeByNameProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Plane?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Plane?> create(Ref ref) {
    final argument = this.argument as String;
    return planeByName(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PlaneByNameProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$planeByNameHash() => r'415e25b7935705278bf925e0bb0f7f2f08b3a5b2';

final class PlaneByNameFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Plane?>, String> {
  const PlaneByNameFamily._()
    : super(
        retry: null,
        name: r'planeByNameProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PlaneByNameProvider call(String id) =>
      PlaneByNameProvider._(argument: id, from: this);

  @override
  String toString() => r'planeByNameProvider';
}

@ProviderFor(PlaneQuery)
const planeQueryProvider = PlaneQueryProvider._();

final class PlaneQueryProvider extends $NotifierProvider<PlaneQuery, String> {
  const PlaneQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'planeQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$planeQueryHash();

  @$internal
  @override
  PlaneQuery create() => PlaneQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$planeQueryHash() => r'f2860a58574d679759ac668d7014e3bff7dcbbdb';

abstract class _$PlaneQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
