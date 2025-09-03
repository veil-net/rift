import 'package:rift/models/plane.dart';
import 'package:rift/providers/supabase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'plane_provider.g.dart';

@riverpod
Stream<List<Plane>> planes(Ref ref) {
  final supabase = ref.watch(supabaseProvider);
  final stream = supabase
      .from('planes')
      .stream(primaryKey: ['id'])
      .map((event) => event.map((r) => Plane.fromJson(r)).toList());
  return stream;
}

@riverpod
Stream<Plane?> planeByName(Ref ref, String id) {
  final supabase = ref.watch(supabaseProvider);
  final stream = supabase
      .from('planes')
      .stream(primaryKey: ['id'])
      .eq('id', id)
      .map((event) => event.map((r) => Plane.fromJson(r)).firstOrNull);
  return stream;
}