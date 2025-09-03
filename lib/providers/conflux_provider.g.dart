// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conflux_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(conflux)
const confluxProvider = ConfluxProvider._();

final class ConfluxProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Conflux>>,
          List<Conflux>,
          Stream<List<Conflux>>
        >
    with $FutureModifier<List<Conflux>>, $StreamProvider<List<Conflux>> {
  const ConfluxProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'confluxProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$confluxHash();

  @$internal
  @override
  $StreamProviderElement<List<Conflux>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Conflux>> create(Ref ref) {
    return conflux(ref);
  }
}

String _$confluxHash() => r'377684fa87143c1f4c65145557854ad644a788d3';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
