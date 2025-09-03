import 'package:rift/models/ip_lease.dart';
import 'package:rift/providers/supabase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ip_lease_provider.g.dart';

@riverpod
Stream<List<IpLease>> ipLease(Ref ref) {
  final supabase = ref.watch(supabaseProvider);
  final stream = supabase
      .from('ip_leases')
      .stream(primaryKey: ['id'])
      .map((event) => event.map((r) => IpLease.fromJson(r)).toList());
  return stream;
}
