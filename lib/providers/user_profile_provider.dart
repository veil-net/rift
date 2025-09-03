import 'dart:async';

import 'package:rift/models/user_profile.dart';
import 'package:rift/providers/supabase_provider.dart';
import 'package:rift/providers/user_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_profile_provider.g.dart';

@riverpod
Future<UserProfile> userProfile(Ref ref) async {
  final supabase = ref.watch(supabaseProvider);
  final user = ref.watch(userProvider);

  if (user.value == null) {
    throw Exception('User not found');
  }

  final profile = await supabase
      .from('profiles')
      .select('*')
      .eq('id', user.value!.id)
      .single();

  return UserProfile.fromJson(profile);
}
