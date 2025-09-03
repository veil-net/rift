// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(session)
const sessionProvider = SessionProvider._();

final class SessionProvider
    extends
        $FunctionalProvider<AsyncValue<Session?>, Session?, Stream<Session?>>
    with $FutureModifier<Session?>, $StreamProvider<Session?> {
  const SessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionHash();

  @$internal
  @override
  $StreamProviderElement<Session?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Session?> create(Ref ref) {
    return session(ref);
  }
}

String _$sessionHash() => r'647ef664d36c4b10f9d252a061d92d6d83895121';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
