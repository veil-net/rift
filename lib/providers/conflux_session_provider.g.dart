// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conflux_session_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(confluxSession)
const confluxSessionProvider = ConfluxSessionProvider._();

final class ConfluxSessionProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ConfluxSession>>,
          List<ConfluxSession>,
          Stream<List<ConfluxSession>>
        >
    with
        $FutureModifier<List<ConfluxSession>>,
        $StreamProvider<List<ConfluxSession>> {
  const ConfluxSessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'confluxSessionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$confluxSessionHash();

  @$internal
  @override
  $StreamProviderElement<List<ConfluxSession>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<ConfluxSession>> create(Ref ref) {
    return confluxSession(ref);
  }
}

String _$confluxSessionHash() => r'c984268cccc4e1b30f0251978e67aeffcd1be510';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
