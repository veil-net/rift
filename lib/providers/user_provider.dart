import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../main.dart';

class UserState {
  final User? user;
  final Session? session;

  UserState({this.user, this.session});

  UserState copyWith({User? user, Session? session}) {
    return UserState(user: user ?? this.user, session: session ?? this.session);
  }
}

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier() : super(UserState()) {
    // Initialize with current session
    final currentSession = supabase.auth.currentSession;
    state = UserState(user: currentSession?.user, session: currentSession);

    // Listen for auth state changes
    supabase.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;

      switch (event) {
        case AuthChangeEvent.signedIn:
          state = UserState(user: session?.user, session: session);
          break;
        case AuthChangeEvent.tokenRefreshed:
          state = UserState(user: session?.user, session: session);
          break;
        case AuthChangeEvent.signedOut:
          state = UserState(user: null, session: null);
          break;
        case AuthChangeEvent.userUpdated:
          state = UserState(user: session?.user, session: session);
          break;
        default:
          break;
      }
    });
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  return UserNotifier();
});

final userServiceTierProvider = FutureProvider<int>((ref) async {
  final user = ref.watch(userProvider);
  if (user.user != null) {
    final userData = await supabase
        .from('subscriptions')
        .select('service_tier')
        .eq('user_id', user.user!.id)
        .order('service_tier', ascending: true);
    if (userData.isNotEmpty) {
      final serviceTier = userData[0]['service_tier'];
      log('Service tier: $serviceTier');
      return serviceTier;
    } else {
      log('No service tier found');
      return 0;
    }
  }
  return 0;
});

class UserProfile {
  final String id;
  final DateTime createdAt;
  final String email;
  final bool isSuperuser;
  final int mp;

  UserProfile({
    required this.id,
    required this.createdAt,
    required this.email,
    required this.isSuperuser,
    required this.mp,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      email: json['email'],
      isSuperuser: json['is_superuser'],
      mp: json['mp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'email': email,
      'is_superuser': isSuperuser,
      'mp': mp,
    };
  }
}

final userProfileProvider = FutureProvider<UserProfile>((ref) async {
  final user = ref.watch(userProvider);
  if (user.user != null) {
    final userData = await supabase
        .from('profiles')
        .select('*')
        .eq('id', user.user!.id);
    return UserProfile.fromJson(userData[0]);
  }
  return UserProfile(
    id: '',
    createdAt: DateTime.now(),
    email: '',
    isSuperuser: false,
    mp: 0,
  );
});
