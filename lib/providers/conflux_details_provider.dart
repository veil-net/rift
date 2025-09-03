import 'package:rift/models/conflux_details.dart';
import 'package:rift/providers/supabase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'conflux_details_provider.g.dart';

@riverpod
Future<ConfluxDetails> confluxDetails(Ref ref, String id) async {
  final supabase = ref.watch(supabaseProvider);
  final details = await supabase
      .from('conflux_details')
      .select('*')
      .eq('id', id)
      .single();

  return ConfluxDetails.fromJson(details);
}
