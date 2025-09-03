import 'package:rift/providers/session_provider.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_provider.g.dart';

@riverpod
Future<Dio> api(Ref ref) async {
  final session = await ref.watch(sessionProvider.future);
  final accessToken = session?.accessToken;

  if (accessToken == null) {
    throw Exception('No access token found');
  }

  return Dio(
    BaseOptions(
      baseUrl: 'https://guardian.veilnet.org',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    ),
  );
}
