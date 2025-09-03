import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'pref_provider.g.dart';

@riverpod
Future<SharedPreferences> pref(Ref ref) async {
  return await SharedPreferences.getInstance();
}