// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/main.dart';

class Portal {
  final String id;
  final String user_id;
  final String domain_id;
  final String name;
  final String? tag;
  final String domain;
  final String region;
  final String subnet;
  final String? cidr;
  final String? signature;
  final DateTime? updated_at;
  final bool online;
  Portal({
    required this.id,
    required this.user_id,
    required this.domain_id,
    required this.name,
    this.tag,
    required this.domain,
    required this.region,
    required this.subnet,
    this.cidr,
    this.signature,
    this.updated_at,
    required this.online,
  });

  Portal copyWith({
    String? id,
    String? user_id,
    String? domain_id,
    String? veil_id,
    String? name,
    String? tag,
    String? domain,
    String? region,
    String? subnet,
    String? cidr,
    String? signature,
    DateTime? updated_at,
    bool? online,
  }) {
    return Portal(
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      domain_id: domain_id ?? this.domain_id,
      name: name ?? this.name,
      tag: tag ?? this.tag,
      domain: domain ?? this.domain,
      region: region ?? this.region,
      subnet: subnet ?? this.subnet,
      cidr: cidr ?? this.cidr,
      signature: signature ?? this.signature,
      updated_at: updated_at ?? this.updated_at,
      online: online ?? this.online,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': user_id,
      'domain_id': domain_id,
      'name': name,
      'tag': tag,
      'domain': domain,
      'region': region,
      'subnet': subnet,
      'cidr': cidr,
      'signature': signature,
      'updated_at': updated_at?.toUtc().toIso8601String(),
      'online': online,
    };
  }

  factory Portal.fromMap(Map<String, dynamic> map) {
    return Portal(
      id: map['id'] as String,
      user_id: map['user_id'] as String,
      domain_id: map['domain_id'] as String,
      name: map['name'] as String,
      tag: map['tag'] != null ? map['tag'] as String : null,
      domain: map['domain'] as String,
      region: map['region'] as String,
      subnet: map['subnet'] as String,
      cidr: map['cidr'] != null ? map['cidr'] as String : null,
      signature: map['signature'] != null ? map['signature'] as String : null,
      updated_at:
          map['updated_at'] != null
              ? DateTime.parse(map['updated_at'] as String)
              : null,
      online: map['online'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Portal.fromJson(String source) =>
      Portal.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Portal(id: $id, user_id: $user_id, domain_id: $domain_id, name: $name, tag: $tag, domain: $domain, region: $region, subnet: $subnet, cidr: $cidr, signature: $signature, updated_at: $updated_at, online: $online)';
  }

  @override
  bool operator ==(covariant Portal other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.user_id == user_id &&
        other.domain_id == domain_id &&
        other.name == name &&
        other.tag == tag &&
        other.domain == domain &&
        other.region == region &&
        other.subnet == subnet &&
        other.cidr == cidr &&
        other.signature == signature &&
        other.updated_at == updated_at &&
        other.online == online;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user_id.hashCode ^
        domain_id.hashCode ^
        name.hashCode ^
        tag.hashCode ^
        domain.hashCode ^
        region.hashCode ^
        subnet.hashCode ^
        cidr.hashCode ^
        signature.hashCode ^
        updated_at.hashCode ^
        online.hashCode;
  }
}

final portalProvider = FutureProvider.family<List<Portal>, bool>((
  ref,
  public,
) async {
  try {
    final portalDetails =
        public
            ? await supabase.from('public_portal_details').select('*')
            : await supabase.from('private_portal_details').select('*');
    log('Fetched ${portalDetails.length} portal details');

    final portalSessions =
        public
            ? await supabase.from('public_portal_sessions').select('*')
            : await supabase.from('private_portal_sessions').select('*');
    log('Fetched ${portalSessions.length} portal sessions');

    return portalDetails.map((portalDetails) {
      final portalSession = portalSessions.firstWhere(
        (session) => session['id'] == portalDetails['id'],
        orElse: () => {},
      );
      final portal = Portal(
        id: portalDetails['id'],
        user_id: portalDetails['user_id'],
        domain_id: portalDetails['domain_id'],
        name: portalDetails['name'],
        tag: portalDetails['tag'],
        domain: portalDetails['domain'],
        region: portalDetails['region'],
        subnet: portalDetails['subnet'],
        online: false,
      );
      if (portalSession.isEmpty) {
        return portal;
      }
      return portal.copyWith(
        online: true,
        cidr: portalSession['cidr'],
        signature: portalSession['signature'],
        updated_at: DateTime.parse(portalSession['updated_at']),
      );
    }).toList();
  } catch (e, stackTrace) {
    log('Failed to fetch portal data', stackTrace: stackTrace, error: e);
    return [];
  }
});

