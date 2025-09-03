import 'package:rift/models/conflux.dart';
import 'package:rift/providers/supabase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'conflux_provider.g.dart';

@riverpod
Stream<List<Conflux>> conflux(Ref ref) {
  final supabase = ref.watch(supabaseProvider);
  final stream = supabase
      .from('confluxes')
      .stream(primaryKey: ['id'])
      .map((event) => event.map((r) => Conflux.fromJson(r)).toList());
  return stream;
}

@riverpod
Stream<Conflux?> confluxByName(Ref ref, String name) {
  final supabase = ref.watch(supabaseProvider);
  final stream = supabase
      .from('confluxes')
      .stream(primaryKey: ['id'])
      .eq('name', name)
      .map((event) => event.map((r) => Conflux.fromJson(r)).firstOrNull);
  return stream;
}
