import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'user_provider.dart';

final apiProvider = Provider<Dio>((ref) {
  final userState = ref.watch(userProvider);
  final dio = Dio(BaseOptions(baseUrl: 'https://guardian.veilnet.org'));
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        if (userState.session == null) {
          return handler.reject(
            DioException(requestOptions: options, error: 'Session not found'),
          );
        }
        options.headers['Authorization'] =
            'Bearer ${userState.session!.accessToken}';
        return handler.next(options);
      },
    ),
  );
  return dio;
});

final anchorTokenProvider = FutureProvider<String>((ref) async {
  final api = ref.watch(apiProvider);
  final response = await api.get('/auth/token');
  return response.data['access_token'];
});
