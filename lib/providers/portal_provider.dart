import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../main.dart';

class Portal {
  final String id;
  final DateTime createdAt;
  final String userId;
  final String domainId;
  final String name;
  final String? tag;

  Portal({
    required this.id,
    required this.createdAt,
    required this.userId,
    required this.domainId,
    required this.name,
    this.tag,
  });

  factory Portal.fromJson(Map<String, dynamic> json) {
    return Portal(
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

final publicPortalProvider = FutureProvider<List<Portal>>((ref) async {
  final response = await supabase.from('public_portals').select('*');
  return response.map((json) => Portal.fromJson(json)).toList();
});

final publicPortalCountProvider = FutureProvider<int>((ref) async {
  final portals = await ref.watch(publicPortalProvider.future);
  return portals.length;
});

final publicPortalByDomainProvider =
    FutureProvider.family<List<Portal>, String>((ref, domainId) async {
      final publicPortals = await ref.watch(publicPortalProvider.future);
      return publicPortals
          .where((portal) => portal.domainId == domainId)
          .toList();
    });

final publicPortalCountByDomainProvider = FutureProvider.family<int, String>((
  ref,
  domainId,
) async {
  final publicPortals = await ref.watch(
    publicPortalByDomainProvider(domainId).future,
  );
  return publicPortals.length;
});

final privatePortalProvider = FutureProvider<List<Portal>>((ref) async {
  final response = await supabase.from('private_portals').select('*');
  return response.map((json) => Portal.fromJson(json)).toList();
});

final privatePortalCountProvider = FutureProvider<int>((ref) async {
  final portals = await ref.watch(privatePortalProvider.future);
  return portals.length;
});

final privatePortalByDomainProvider =
    FutureProvider.family<List<Portal>, String>((ref, domainId) async {
      final privatePortals = await ref.watch(privatePortalProvider.future);
      return privatePortals
          .where((portal) => portal.domainId == domainId)
          .toList();
    });

final privatePortalCountByDomainProvider = FutureProvider.family<int, String>((
  ref,
  domainId,
) async {
  final privatePortals = await ref.watch(
    privatePortalByDomainProvider(domainId).future,
  );
  return privatePortals.length;
});

class PortalSession {
  final String id;
  final DateTime updatedAt;
  final String userId;
  final String veilId;
  final String domainId;
  final String cidr;
  final String signature;

  PortalSession({
    required this.id,
    required this.updatedAt,
    required this.userId,
    required this.veilId,
    required this.domainId,
    required this.cidr,
    required this.signature,
  });

  factory PortalSession.fromJson(Map<String, dynamic> json) {
    return PortalSession(
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

final publicPortalSessionsProvider = FutureProvider<List<PortalSession>>((
  ref,
) async {
  final response = await supabase.from('public_portal_sessions').select('*');
  return response.map((json) => PortalSession.fromJson(json)).toList();
});

final publicPortalSessionsByIdProvider =
    FutureProvider.family<PortalSession, String>((ref, id) async {
      final sessions = await ref.watch(publicPortalSessionsProvider.future);
      return sessions.firstWhere((session) => session.id == id);
    });

final publicPortalSessionsCountProvider = FutureProvider<int>((ref) async {
  final sessions = await ref.watch(publicPortalSessionsProvider.future);
  return sessions.length;
});

final publicPortalSessionsByDomainProvider =
    FutureProvider.family<List<PortalSession>, String>((ref, domainId) async {
      final sessions = await ref.watch(publicPortalSessionsProvider.future);
      return sessions.where((session) => session.domainId == domainId).toList();
    });

final publicPortalSessionsCountByDomainProvider =
    FutureProvider.family<int, String>((ref, domainId) async {
      final sessions = await ref.watch(
        publicPortalSessionsByDomainProvider(domainId).future,
      );
      return sessions.length;
    });

final privatePortalSessionsProvider = FutureProvider<List<PortalSession>>((
  ref,
) async {
  final response = await supabase.from('private_portal_sessions').select('*');
  return response.map((json) => PortalSession.fromJson(json)).toList();
});

final privatePortalSessionsByIdProvider =
    FutureProvider.family<PortalSession, String>((ref, id) async {
      final sessions = await ref.watch(privatePortalSessionsProvider.future);
      return sessions.firstWhere((session) => session.id == id);
    });

final privatePortalSessionsCountProvider = FutureProvider<int>((ref) async {
  final sessions = await ref.watch(privatePortalSessionsProvider.future);
  return sessions.length;
});

final privatePortalSessionsByDomainProvider =
    FutureProvider.family<List<PortalSession>, String>((ref, domainId) async {
      final sessions = await ref.watch(privatePortalSessionsProvider.future);
      return sessions.where((session) => session.domainId == domainId).toList();
    });

final privatePortalSessionsCountByDomainProvider =
    FutureProvider.family<int, String>((ref, domainId) async {
      final sessions = await ref.watch(
        privatePortalSessionsByDomainProvider(domainId).future,
      );
      return sessions.length;
    });

final publicPortalVsSessionsProvider = FutureProvider<List<int>>((ref) async {
  final publicPortalCount = await ref.watch(publicPortalCountProvider.future);
  final publicPortalSessionsCount = await ref.watch(
    publicPortalSessionsCountProvider.future,
  );
  return [publicPortalCount, publicPortalSessionsCount];
});

final publicPortalVsSessionsByDomainProvider =
    FutureProvider.family<List<int>, String>((ref, domainId) async {
      final publicPortalCount = await ref.watch(
        publicPortalCountByDomainProvider(domainId).future,
      );
      final publicPortalSessionsCount = await ref.watch(
        publicPortalSessionsCountByDomainProvider(domainId).future,
      );
      return [publicPortalCount, publicPortalSessionsCount];
    });

final privatePortalVsSessionsProvider = FutureProvider<List<int>>((ref) async {
  final privatePortalCount = await ref.watch(privatePortalCountProvider.future);
  final privatePortalSessionsCount = await ref.watch(
    privatePortalSessionsCountProvider.future,
  );
  return [privatePortalCount, privatePortalSessionsCount];
});

final privatePortalVsSessionsByDomainProvider =
    FutureProvider.family<List<int>, String>((ref, domainId) async {
      final privatePortalCount = await ref.watch(
        privatePortalCountByDomainProvider(domainId).future,
      );
      final privatePortalSessionsCount = await ref.watch(
        privatePortalSessionsCountByDomainProvider(domainId).future,
      );
      return [privatePortalCount, privatePortalSessionsCount];
    });
