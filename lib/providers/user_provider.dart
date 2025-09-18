// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:rift/providers/api_provider.dart';
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
  final Ref ref;
  UserNotifier(this.ref) : super(UserState()) {
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
  return UserNotifier(ref);
});

class UserProfile {
  final String id;
  final DateTime created_at;
  final String email;
  final bool is_superuser;
  final int mp;
  final String? username;
  UserProfile({
    required this.id,
    required this.created_at,
    required this.email,
    required this.is_superuser,
    required this.mp,
    this.username,
  });

  UserProfile copyWith({
    String? id,
    DateTime? created_at,
    String? email,
    bool? is_superuser,
    int? mp,
    String? username,
  }) {
    return UserProfile(
      id: id ?? this.id,
      created_at: created_at ?? this.created_at,
      email: email ?? this.email,
      is_superuser: is_superuser ?? this.is_superuser,
      mp: mp ?? this.mp,
      username: username ?? this.username,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': created_at.toUtc().toIso8601String(),
      'email': email,
      'is_superuser': is_superuser,
      'mp': mp,
      'username': username,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'] as String,
      created_at: DateTime.parse(map['created_at'] as String),
      email: map['email'] as String,
      is_superuser: map['is_superuser'] as bool,
      mp: map['mp'] as int,
      username: map['username'] != null ? map['username'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfile.fromJson(String source) =>
      UserProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserProfile(id: $id, created_at: $created_at, email: $email, is_superuser: $is_superuser, mp: $mp, username: $username)';
  }

  @override
  bool operator ==(covariant UserProfile other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.created_at == created_at &&
        other.email == email &&
        other.is_superuser == is_superuser &&
        other.mp == mp &&
        other.username == username;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        created_at.hashCode ^
        email.hashCode ^
        is_superuser.hashCode ^
        mp.hashCode ^
        username.hashCode;
  }
}

final userProfileProvider = FutureProvider<UserProfile>((ref) async {
  final userState = ref.watch(userProvider);
  final response = await supabase
      .from('profiles')
      .select('*')
      .eq('id', userState.user!.id)
      .single();
  return UserProfile.fromMap(response);
});

class ServiceTierFeatures {
  final bool allowed;
  final String feature;

  ServiceTierFeatures({required this.allowed, required this.feature});
}

final serviceFeatureProvider = Provider.family<List<ServiceTierFeatures>, int>((
  ref,
  serviceTier,
) {
  switch (serviceTier) {
    case 0:
      return [
        ServiceTierFeatures(allowed: true, feature: 'Earn MP via Self-hosting'),
        ServiceTierFeatures(
          allowed: true,
          feature: 'Self-hosting Portals in Public Domains',
        ),
        ServiceTierFeatures(
          allowed: false,
          feature: 'Unlimited Rift access to Public Domains',
        ),
        ServiceTierFeatures(allowed: false, feature: 'Create Private Domains'),
        ServiceTierFeatures(
          allowed: false,
          feature: 'Self-hosting Portals in Private Domains',
        ),
        ServiceTierFeatures(
          allowed: false,
          feature: 'Unlimited Rift access to Private Domains',
        ),
      ];
    case 1:
      return [
        ServiceTierFeatures(allowed: true, feature: 'Earn MP via Self-hosting'),
        ServiceTierFeatures(
          allowed: true,
          feature: 'Self-hosting Portals in Public Domains',
        ),
        ServiceTierFeatures(
          allowed: true,
          feature: 'Unlimited Rift access to Public Domains',
        ),
        ServiceTierFeatures(allowed: false, feature: 'Create Private Domains'),
        ServiceTierFeatures(
          allowed: false,
          feature: 'Self-hosting Portals in Private Domains',
        ),
        ServiceTierFeatures(
          allowed: false,
          feature: 'Unlimited Rift access to Private Domains',
        ),
      ];
    case 2:
      return [
        ServiceTierFeatures(allowed: true, feature: 'Earn MP via Self-hosting'),
        ServiceTierFeatures(
          allowed: true,
          feature: 'Self-hosting Portals in Public Domains',
        ),
        ServiceTierFeatures(
          allowed: true,
          feature: 'Unlimited Rift access to Public Domains',
        ),
        ServiceTierFeatures(allowed: true, feature: 'Create Private Domains'),
        ServiceTierFeatures(
          allowed: true,
          feature: 'Self-hosting Portals in Private Domains',
        ),
        ServiceTierFeatures(
          allowed: true,
          feature: 'Unlimited Rift access to Private Domains',
        ),
      ];
    default:
      return [
        ServiceTierFeatures(allowed: true, feature: 'Earn MP via Self-hosting'),
        ServiceTierFeatures(
          allowed: true,
          feature: 'Self-hosting Portals in Public Domains',
        ),
        ServiceTierFeatures(
          allowed: false,
          feature: 'Unlimited Rift access to Public Domains',
        ),
        ServiceTierFeatures(allowed: false, feature: 'Create Private Domains'),
        ServiceTierFeatures(
          allowed: false,
          feature: 'Self-hosting Portals in Private Domains',
        ),
        ServiceTierFeatures(
          allowed: false,
          feature: 'Unlimited Rift access to Private Domains',
        ),
      ];
  }
});

class UserSubscription {
  final String id;
  final String user_id;
  final int service_tier;
  final String customer;
  final DateTime created_at;
  final DateTime? ended_at;
  final DateTime? cancel_at;
  final DateTime? current_period_start;
  final DateTime? current_period_end;
  final DateTime? trial_start;
  final DateTime? trial_end;
  final String status;
  UserSubscription({
    required this.id,
    required this.user_id,
    required this.service_tier,
    required this.customer,
    required this.created_at,
    this.ended_at,
    this.cancel_at,
    this.current_period_start,
    this.current_period_end,
    this.trial_start,
    this.trial_end,
    required this.status,
  });

  UserSubscription copyWith({
    String? id,
    String? user_id,
    int? service_tier,
    String? customer,
    DateTime? created_at,
    DateTime? ended_at,
    DateTime? cancel_at,
    DateTime? current_period_start,
    DateTime? current_period_end,
    DateTime? trial_start,
    DateTime? trial_end,
    String? status,
  }) {
    return UserSubscription(
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      service_tier: service_tier ?? this.service_tier,
      customer: customer ?? this.customer,
      created_at: created_at ?? this.created_at,
      ended_at: ended_at ?? this.ended_at,
      cancel_at: cancel_at ?? this.cancel_at,
      current_period_start: current_period_start ?? this.current_period_start,
      current_period_end: current_period_end ?? this.current_period_end,
      trial_start: trial_start ?? this.trial_start,
      trial_end: trial_end ?? this.trial_end,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': user_id,
      'service_tier': service_tier,
      'customer': customer,
      'created_at': created_at.toUtc().toIso8601String(),
      'ended_at': ended_at?.toUtc().toIso8601String(),
      'cancel_at': cancel_at?.toUtc().toIso8601String(),
      'current_period_start': current_period_start?.toUtc().toIso8601String(),
      'current_period_end': current_period_end?.toUtc().toIso8601String(),
      'trial_start': trial_start?.toUtc().toIso8601String(),
      'trial_end': trial_end?.toUtc().toIso8601String(),
      'status': status,
    };
  }

  factory UserSubscription.fromMap(Map<String, dynamic> map) {
    return UserSubscription(
      id: map['id'] as String,
      user_id: map['user_id'] as String,
      service_tier: map['service_tier'] as int,
      customer: map['customer'] as String,
      created_at: DateTime.parse(map['created_at'] as String),
      ended_at: map['ended_at'] != null
          ? DateTime.parse(map['ended_at'] as String)
          : null,
      cancel_at: map['cancel_at'] != null
          ? DateTime.parse(map['cancel_at'] as String)
          : null,
      current_period_start: map['current_period_start'] != null
          ? DateTime.parse(map['current_period_start'] as String)
          : null,
      current_period_end: map['current_period_end'] != null
          ? DateTime.parse(map['current_period_end'] as String)
          : null,
      trial_start: map['trial_start'] != null
          ? DateTime.parse(map['trial_start'] as String)
          : null,
      trial_end: map['trial_end'] != null
          ? DateTime.parse(map['trial_end'] as String)
          : null,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserSubscription.fromJson(String source) =>
      UserSubscription.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserSubscription(id: $id, user_id: $user_id, service_tier: $service_tier, customer: $customer, created_at: $created_at, ended_at: $ended_at, cancel_at: $cancel_at, current_period_start: $current_period_start, current_period_end: $current_period_end, trial_start: $trial_start, trial_end: $trial_end, status: $status)';
  }

  @override
  bool operator ==(covariant UserSubscription other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.user_id == user_id &&
        other.service_tier == service_tier &&
        other.customer == customer &&
        other.created_at == created_at &&
        other.ended_at == ended_at &&
        other.cancel_at == cancel_at &&
        other.current_period_start == current_period_start &&
        other.current_period_end == current_period_end &&
        other.trial_start == trial_start &&
        other.trial_end == trial_end &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user_id.hashCode ^
        service_tier.hashCode ^
        customer.hashCode ^
        created_at.hashCode ^
        ended_at.hashCode ^
        cancel_at.hashCode ^
        current_period_start.hashCode ^
        current_period_end.hashCode ^
        trial_start.hashCode ^
        trial_end.hashCode ^
        status.hashCode;
  }
}

final userSubscriptionProvider = FutureProvider<List<UserSubscription>>((
  ref,
) async {
  final userState = ref.watch(userProvider);
  try {
    final response = await supabase
        .from('subscriptions')
        .select('*')
        .eq('user_id', userState.user!.id);
    return response.map((e) => UserSubscription.fromMap(e)).toList();
  } catch (e) {
    return [];
  }
});

final userServiceTierProvider = FutureProvider<int>((ref) async {
  final api = ref.watch(apiProvider);
  final response = await api.get('/stripe/service-tier');
  return response.data as int;
});
