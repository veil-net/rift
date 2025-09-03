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

@ProviderFor(confluxByName)
const confluxByNameProvider = ConfluxByNameFamily._();

final class ConfluxByNameProvider
    extends
        $FunctionalProvider<AsyncValue<Conflux?>, Conflux?, Stream<Conflux?>>
    with $FutureModifier<Conflux?>, $StreamProvider<Conflux?> {
  const ConfluxByNameProvider._({
    required ConfluxByNameFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'confluxByNameProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$confluxByNameHash();

  @override
  String toString() {
    return r'confluxByNameProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Conflux?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Conflux?> create(Ref ref) {
    final argument = this.argument as String;
    return confluxByName(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ConfluxByNameProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$confluxByNameHash() => r'8bbe371606a6ffe97a9669de0d1995fd105be992';

final class ConfluxByNameFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Conflux?>, String> {
  const ConfluxByNameFamily._()
    : super(
        retry: null,
        name: r'confluxByNameProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ConfluxByNameProvider call(String name) =>
      ConfluxByNameProvider._(argument: name, from: this);

  @override
  String toString() => r'confluxByNameProvider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
