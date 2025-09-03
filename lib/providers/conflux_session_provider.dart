import 'package:rift/models/conflux_session.dart';
import 'package:rift/providers/supabase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'conflux_session_provider.g.dart';

@riverpod
Stream<List<ConfluxSession>> confluxSession(Ref ref) {
  final supabase = ref.watch(supabaseProvider);
  final stream = supabase
      .from('conflux_sessions')
      .stream(primaryKey: ['id'])
      .map((event) => event.map((r) => ConfluxSession.fromJson(r)).toList());
  return stream;
}
