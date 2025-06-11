import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../main.dart';

class Rift {
  final String id;
  final DateTime createdAt;
  final String userId;
  final String domainId;
  final String name;
  final String? tag;

  Rift({
    required this.id,
    required this.createdAt,
    required this.userId,
    required this.domainId,
    required this.name,
    this.tag,
  });

  factory Rift.fromJson(Map<String, dynamic> json) {
    return Rift(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      userId: json['user_id'],
      domainId: json['domain_id'],
      name: json['name'],
      tag: json['tag'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'user_id': userId,
      'domain_id': domainId,
      'name': name,
      'tag': tag,
    };
  }
}

final publicRiftProvider = FutureProvider<List<Rift>>((ref) async {
  final response = await supabase.from('public_rifts').select('*');
  return response.map((json) => Rift.fromJson(json)).toList();
});

final publicRiftByDomainProvider = FutureProvider.family<List<Rift>, String>((
  ref,
  domainId,
) async {
  final publicRifts = await ref.watch(publicRiftProvider.future);
  return publicRifts.where((rift) => rift.domainId == domainId).toList();
});

final privateRiftProvider = FutureProvider<List<Rift>>((ref) async {
  final response = await supabase.from('private_rifts').select('*');
  return response.map((json) => Rift.fromJson(json)).toList();
});

final privateRiftByDomainProvider = FutureProvider.family<List<Rift>, String>((
  ref,
  domainId,
) async {
  final privateRifts = await ref.watch(privateRiftProvider.future);
  return privateRifts.where((rift) => rift.domainId == domainId).toList();
});

class RiftSession {
  final String id;
  final DateTime updatedAt;
  final String userId;
  final String veilId;
  final String domainId;
  final String cidr;
  final String signature;

  RiftSession({
    required this.id,
    required this.updatedAt,
    required this.userId,
    required this.veilId,
    required this.domainId,
    required this.cidr,
    required this.signature,
  });

  factory RiftSession.fromJson(Map<String, dynamic> json) {
    return RiftSession(
      id: json['id'],
      updatedAt: DateTime.parse(json['updated_at']),
      userId: json['user_id'],
      veilId: json['veil_id'],
      domainId: json['domain_id'],
      cidr: json['cidr'],
      signature: json['signature'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'updated_at': updatedAt.toIso8601String(),
      'user_id': userId,
      'veil_id': veilId,
      'domain_id': domainId,
      'cidr': cidr,
      'signature': signature,
    };
  }
}

final publicRiftSessionProvider = FutureProvider<List<RiftSession>>((
  ref,
) async {
  final response = await supabase.from('public_rift_sessions').select('*');
  return response.map((json) => RiftSession.fromJson(json)).toList();
});

final publicRiftSessionByDomainProvider =
    FutureProvider.family<List<RiftSession>, String>((ref, domainId) async {
      final publicRiftSessions = await ref.watch(
        publicRiftSessionProvider.future,
      );
      return publicRiftSessions
          .where((session) => session.domainId == domainId)
          .toList();
    });

final privateRiftSessionProvider = FutureProvider<List<RiftSession>>((
  ref,
) async {
  final response = await supabase.from('private_rift_sessions').select('*');
  return response.map((json) => RiftSession.fromJson(json)).toList();
});

final privateRiftSessionByDomainProvider =
    FutureProvider.family<List<RiftSession>, String>((ref, domainId) async {
      final privateRiftSessions = await ref.watch(
        privateRiftSessionProvider.future,
      );
      return privateRiftSessions
          .where((session) => session.domainId == domainId)
          .toList();
    });