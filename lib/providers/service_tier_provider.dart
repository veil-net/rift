import 'package:rift/providers/api_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'service_tier_provider.g.dart';

@riverpod
class ServiceTier extends _$ServiceTier {
  @override
  Future<int> build() async {
    final api = await ref.watch(apiProvider.future);
    final response = await api.get('/stripe/service-tier');
    return response.data as int;
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}
