import 'package:rift/providers/supabase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'session_provider.g.dart';

@riverpod
Stream<Session?> session(Ref ref) {
  final supabase = ref.watch(supabaseProvider);

  return supabase.auth.onAuthStateChange.map((event) => event.session);
}