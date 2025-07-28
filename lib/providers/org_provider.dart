// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:rift/main.dart';
import 'package:rift/providers/api_provider.dart';
import 'package:rift/providers/user_provider.dart';

class OrgMember {
  final String organisation_id;
  final String organisation_name;
  final String? organisation_website;
  final String? organisation_email;
  final bool organisation_owner;
  final String team_id;
  final String team_name;
  final String team_email;
  final bool team_owner;
  final String user_id;
  final String username;
  final String? plane_id;
  OrgMember({
    required this.organisation_id,
    required this.organisation_name,
    this.organisation_website,
    this.organisation_email,
    required this.organisation_owner,
    required this.team_id,
    required this.team_name,
    required this.team_email,
    required this.team_owner,
    required this.user_id,
    required this.username,
    this.plane_id,
  });

  OrgMember copyWith({
    String? organisation_id,
    String? organisation_name,
    String? organisation_website,
    String? organisation_email,
    bool? organisation_owner,
    String? team_id,
    String? team_name,
    String? team_email,
    bool? team_owner,
    String? user_id,
    String? username,
    String? plane_id,
  }) {
    return OrgMember(
      organisation_id: organisation_id ?? this.organisation_id,
      organisation_name: organisation_name ?? this.organisation_name,
      organisation_website: organisation_website ?? this.organisation_website,
      organisation_email: organisation_email ?? this.organisation_email,
      organisation_owner: organisation_owner ?? this.organisation_owner,
      team_id: team_id ?? this.team_id,
      team_name: team_name ?? this.team_name,
      team_email: team_email ?? this.team_email,
      team_owner: team_owner ?? this.team_owner,
      user_id: user_id ?? this.user_id,
      username: username ?? this.username,
      plane_id: plane_id ?? this.plane_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'organisation_id': organisation_id,
      'organisation_name': organisation_name,
      'organisation_website': organisation_website,
      'organisation_email': organisation_email,
      'organisation_owner': organisation_owner,
      'team_id': team_id,
      'team_name': team_name,
      'team_email': team_email,
      'team_owner': team_owner,
      'user_id': user_id,
      'username': username,
      'plane_id': plane_id,
    };
  }

  factory OrgMember.fromMap(Map<String, dynamic> map) {
    return OrgMember(
      organisation_id: map['organisation_id'] as String,
      organisation_name: map['organisation_name'] as String,
      organisation_website:
          map['organisation_website'] != null
              ? map['organisation_website'] as String
              : null,
      organisation_email:
          map['organisation_email'] != null
              ? map['organisation_email'] as String
              : null,
      organisation_owner: map['organisation_owner'] as bool,
      team_id: map['team_id'] as String,
      team_name: map['team_name'] as String,
      team_email: map['team_email'] as String,
      team_owner: map['team_owner'] as bool,
      user_id: map['user_id'] as String,
      username: map['username'] as String,
      plane_id: map['plane_id'] != null ? map['plane_id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrgMember.fromJson(String source) =>
      OrgMember.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrgMember(organisation_id: $organisation_id, organisation_name: $organisation_name, organisation_website: $organisation_website, organisation_email: $organisation_email, organisation_owner: $organisation_owner, team_id: $team_id, team_name: $team_name, team_email: $team_email, team_owner: $team_owner, user_id: $user_id, username: $username, plane_id: $plane_id)';
  }

  @override
  bool operator ==(covariant OrgMember other) {
    if (identical(this, other)) return true;

    return other.organisation_id == organisation_id &&
        other.organisation_name == organisation_name &&
        other.organisation_website == organisation_website &&
        other.organisation_email == organisation_email &&
        other.organisation_owner == organisation_owner &&
        other.team_id == team_id &&
        other.team_name == team_name &&
        other.team_email == team_email &&
        other.team_owner == team_owner &&
        other.user_id == user_id &&
        other.username == username &&
        other.plane_id == plane_id;
  }

  @override
  int get hashCode {
    return organisation_id.hashCode ^
        organisation_name.hashCode ^
        organisation_website.hashCode ^
        organisation_email.hashCode ^
        organisation_owner.hashCode ^
        team_id.hashCode ^
        team_name.hashCode ^
        team_email.hashCode ^
        team_owner.hashCode ^
        user_id.hashCode ^
        username.hashCode ^
        plane_id.hashCode;
  }
}

final orgMemberProvider = FutureProvider<List<OrgMember>>((ref) async {
  ref.watch(userProvider);
  final associations = await supabase.from('organisation_members').select('*');
  return associations.map((e) => OrgMember.fromMap(e)).toList();
});

class Org {
  final String id;
  final DateTime created_at;
  final String user_id;
  final String name;
  final String? website;
  final String? email;
  Org({
    required this.id,
    required this.created_at,
    required this.user_id,
    required this.name,
    this.website,
    this.email,
  });

  Org copyWith({
    String? id,
    DateTime? created_at,
    String? user_id,
    String? name,
    String? website,
    String? email,
  }) {
    return Org(
      id: id ?? this.id,
      created_at: created_at ?? this.created_at,
      user_id: user_id ?? this.user_id,
      name: name ?? this.name,
      website: website ?? this.website,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': created_at.toUtc().toIso8601String(),
      'user_id': user_id,
      'name': name,
      'website': website,
      'email': email,
    };
  }

  factory Org.fromMap(Map<String, dynamic> map) {
    return Org(
      id: map['id'] as String,
      created_at: DateTime.parse(map['created_at'] as String),
      user_id: map['user_id'] as String,
      name: map['name'] as String,
      website: map['website'] != null ? map['website'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Org.fromJson(String source) =>
      Org.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Org(id: $id, created_at: $created_at, user_id: $user_id, name: $name, website: $website, email: $email)';
  }

  @override
  bool operator ==(covariant Org other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.created_at == created_at &&
        other.user_id == user_id &&
        other.name == name &&
        other.website == website &&
        other.email == email;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        created_at.hashCode ^
        user_id.hashCode ^
        name.hashCode ^
        website.hashCode ^
        email.hashCode;
  }

  bool get owner => user_id == supabase.auth.currentUser?.id;
}

final orgProvider = FutureProvider<List<Org>>((ref) async {
  ref.watch(userProvider);
  final orgs = await supabase.from('organisations').select('*');
  return orgs.map((e) => Org.fromMap(e)).toList();
});

class Team {
  final String id;
  final DateTime created_at;
  final String user_id;
  final String organisation_id;
  final String name;
  final String? email;
  final String? plane_id;
  Team({
    required this.id,
    required this.created_at,
    required this.user_id,
    required this.organisation_id,
    required this.name,
    this.email,
    this.plane_id,
  });

  Team copyWith({
    String? id,
    DateTime? created_at,
    String? user_id,
    String? organisation_id,
    String? name,
    String? email,
    String? plane_id,
  }) {
    return Team(
      id: id ?? this.id,
      created_at: created_at ?? this.created_at,
      user_id: user_id ?? this.user_id,
      organisation_id: organisation_id ?? this.organisation_id,
      name: name ?? this.name,
      email: email ?? this.email,
      plane_id: plane_id ?? this.plane_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': created_at.toUtc().toIso8601String(),
      'user_id': user_id,
      'organisation_id': organisation_id,
      'name': name,
      'email': email,
      'plane_id': plane_id,
    };
  }

  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
      id: map['id'] as String,
      created_at: DateTime.parse(map['created_at'] as String),
      user_id: map['user_id'] as String,
      organisation_id: map['organisation_id'] as String,
      name: map['name'] as String,
      email: map['email'] != null ? map['email'] as String : null,
      plane_id: map['plane_id'] != null ? map['plane_id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Team.fromJson(String source) =>
      Team.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Team(id: $id, created_at: $created_at, user_id: $user_id, organisation_id: $organisation_id, name: $name, email: $email, plane_id: $plane_id)';
  }

  @override
  bool operator ==(covariant Team other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.created_at == created_at &&
        other.user_id == user_id &&
        other.organisation_id == organisation_id &&
        other.name == name &&
        other.email == email &&
        other.plane_id == plane_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        created_at.hashCode ^
        user_id.hashCode ^
        organisation_id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        plane_id.hashCode;
  }

  bool get owner => user_id == supabase.auth.currentUser?.id;
}

final teamProvider = FutureProvider<List<Team>>((ref) async {
  ref.watch(userProvider);
  final teams = await supabase.from('teams').select('*');
  return teams.map((e) => Team.fromMap(e)).toList();
});

class TeamInvitation {
  final String id;
  final DateTime created_at;
  final String username;
  final String organisation_name;
  final String team_name;
  final String invited_username;
  final String status;
  TeamInvitation({
    required this.id,
    required this.created_at,
    required this.username,
    required this.organisation_name,
    required this.team_name,
    required this.invited_username,
    required this.status,
  });

  TeamInvitation copyWith({
    String? id,
    DateTime? created_at,
    String? username,
    String? organisation_name,
    String? team_name,
    String? invited_username,
    String? status,
  }) {
    return TeamInvitation(
      id: id ?? this.id,
      created_at: created_at ?? this.created_at,
      username: username ?? this.username,
      organisation_name: organisation_name ?? this.organisation_name,
      team_name: team_name ?? this.team_name,
      invited_username: invited_username ?? this.invited_username,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': created_at.toUtc().toIso8601String(),
      'username': username,
      'organisation_name': organisation_name,
      'team_name': team_name,
      'invited_username': invited_username,
      'status': status,
    };
  }

  factory TeamInvitation.fromMap(Map<String, dynamic> map) {
    return TeamInvitation(
      id: map['id'] as String,
      created_at: DateTime.parse(map['created_at'] as String),
      username: map['username'] as String,
      organisation_name: map['organisation_name'] as String,
      team_name: map['team_name'] as String,
      invited_username: map['invited_username'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TeamInvitation.fromJson(String source) =>
      TeamInvitation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TeamInvitation(id: $id, created_at: $created_at, username: $username, organisation_name: $organisation_name, team_name: $team_name, invited_username: $invited_username, status: $status)';
  }

  @override
  bool operator ==(covariant TeamInvitation other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.created_at == created_at &&
        other.username == username &&
        other.organisation_name == organisation_name &&
        other.team_name == team_name &&
        other.invited_username == invited_username &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        created_at.hashCode ^
        username.hashCode ^
        organisation_name.hashCode ^
        team_name.hashCode ^
        invited_username.hashCode ^
        status.hashCode;
  }
}

final receivedTeamInvitationProvider = FutureProvider<List<TeamInvitation>>((
  ref,
) async {
  final api = ref.watch(apiProvider);
  final response = await api.get('/org/team/invite/received');
  final data = response.data as List<dynamic>;
  return data.map((e) => TeamInvitation.fromMap(e)).toList();
});

final sentTeamInvitationProvider = FutureProvider<List<TeamInvitation>>((
  ref,
) async {
  final api = ref.watch(apiProvider);
  final response = await api.get('/org/team/invite/sent');
  final data = response.data as List<dynamic>;
  return data.map((e) => TeamInvitation.fromMap(e)).toList();
});

class TeamMember {
  final String id;
  final DateTime created_at;
  final String team_id;
  final String username;
  TeamMember({
    required this.id,
    required this.created_at,
    required this.team_id,
    required this.username,
  });

  TeamMember copyWith({
    String? id,
    DateTime? created_at,
    String? team_id,
    String? username,
  }) {
    return TeamMember(
      id: id ?? this.id,
      created_at: created_at ?? this.created_at,
      team_id: team_id ?? this.team_id,
      username: username ?? this.username,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': created_at.toUtc().toIso8601String(),
      'team_id': team_id,
      'username': username,
    };
  }

  factory TeamMember.fromMap(Map<String, dynamic> map) {
    return TeamMember(
      id: map['id'] as String,
      created_at: DateTime.parse(map['created_at'] as String),
      team_id: map['team_id'] as String,
      username: map['username'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TeamMember.fromJson(String source) =>
      TeamMember.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TeamMember(id: $id, created_at: $created_at, team_id: $team_id, username: $username)';
  }

  @override
  bool operator ==(covariant TeamMember other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.created_at == created_at &&
        other.team_id == team_id &&
        other.username == username;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        created_at.hashCode ^
        team_id.hashCode ^
        username.hashCode;
  }
}

final teamMemberProvider = FutureProvider.family<List<TeamMember>, String>((
  ref,
  team_id,
) async {
  final api = ref.watch(apiProvider);
  final response = await api.get('/org/team/member?team_id=$team_id');
  final data = response.data as List<dynamic>;
  return data.map((e) => TeamMember.fromMap(e)).toList();
});
