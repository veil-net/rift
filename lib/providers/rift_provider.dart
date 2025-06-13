// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/providers/portal_provider.dart';

import '../main.dart';

class Rift {
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
  Rift({
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

  Rift copyWith({
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
    return Rift(
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

  factory Rift.fromMap(Map<String, dynamic> map) {
    return Rift(
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

  factory Rift.fromJson(String source) =>
      Rift.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Rift(id: $id, user_id: $user_id, domain_id: $domain_id, name: $name, tag: $tag, domain: $domain, region: $region, subnet: $subnet, cidr: $cidr, signature: $signature, updated_at: $updated_at, online: $online)';
  }

  @override
  bool operator ==(covariant Rift other) {
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

final riftProvider = FutureProvider.family<List<Rift>, bool>((
  ref,
  public,
) async {
  try {
    final riftDetails =
        public
            ? await supabase.from('public_rift_details').select('*')
            : await supabase.from('private_rift_details').select('*');
    log('Fetched ${riftDetails.length} rift details');
    final riftSessions =
        public
            ? await supabase.from('public_rift_sessions').select('*')
            : await supabase.from('private_rift_sessions').select('*');
    log('Fetched ${riftSessions.length} rift sessions');

    return riftDetails.map((riftDetails) {
      final riftSession = riftSessions.firstWhere(
        (session) => session['id'] == riftDetails['id'],
        orElse: () => {},
      );
      final rift = Rift(
        id: riftDetails['id'],
        user_id: riftDetails['user_id'],
        domain_id: riftDetails['domain_id'],
        name: riftDetails['name'],
        domain: riftDetails['domain'],
        region: riftDetails['region'],
        subnet: riftDetails['subnet'],
        online: false,
      );
      if (riftSession.isEmpty) {
        return rift;
      }
      return rift.copyWith(
        online: true,
        cidr: riftSession['cidr'],
        signature: riftSession['signature'],
        updated_at: DateTime.parse(riftSession['updated_at']),
      );
    }).toList();
  } catch (e, stackTrace) {
    log('Failed to fetch rift data', stackTrace: stackTrace, error: e);
    return [];
  }
});
