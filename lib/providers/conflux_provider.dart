// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/main.dart';

class Conflux {
  final String id;
  final DateTime created_at;
  final DateTime last_seen;
  final String name;
  final String? tag;
  final String? signature;
  final String? cidr;
  final String? subnet;
  final String? plane;
  final bool? public;
  final bool? portal;
  final String? ca_pem;
  final String? key_pem;
  final String? cert_pem;
  final String? veil_host;
  final int? veil_port;
  final String? region;
  Conflux({
    required this.id,
    required this.created_at,
    required this.last_seen,
    required this.name,
    this.tag,
    this.signature,
    this.cidr,
    this.subnet,
    this.plane,
    this.public,
    this.portal,
    this.ca_pem,
    this.key_pem,
    this.cert_pem,
    this.veil_host,
    this.veil_port,
    this.region,
  });

  Conflux copyWith({
    String? id,
    DateTime? created_at,
    DateTime? last_seen,
    String? name,
    String? tag,
    String? signature,
    String? cidr,
    String? subnet,
    String? plane,
    bool? public,
    bool? portal,
    String? ca_pem,
    String? key_pem,
    String? cert_pem,
    String? veil_host,
    int? veil_port,
    String? region,
  }) {
    return Conflux(
      id: id ?? this.id,
      created_at: created_at ?? this.created_at,
      last_seen: last_seen ?? this.last_seen,
      name: name ?? this.name,
      tag: tag ?? this.tag,
      signature: signature ?? this.signature,
      cidr: cidr ?? this.cidr,
      subnet: subnet ?? this.subnet,
      plane: plane ?? this.plane,
      public: public ?? this.public,
      portal: portal ?? this.portal,
      ca_pem: ca_pem ?? this.ca_pem,
      key_pem: key_pem ?? this.key_pem,
      cert_pem: cert_pem ?? this.cert_pem,
      veil_host: veil_host ?? this.veil_host,
      veil_port: veil_port ?? this.veil_port,
      region: region ?? this.region,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': created_at.toUtc().toIso8601String(),
      'last_seen': last_seen.toUtc().toIso8601String(),
      'name': name,
      'tag': tag,
      'signature': signature,
      'cidr': cidr,
      'subnet': subnet,
      'plane': plane,
      'public': public,
      'portal': portal,
      'ca_pem': ca_pem,
      'key_pem': key_pem,
      'cert_pem': cert_pem,
      'veil_host': veil_host,
      'veil_port': veil_port,
      'region': region,
    };
  }

  factory Conflux.fromMap(Map<String, dynamic> map) {
    return Conflux(
      id: map['id'] as String,
      created_at: DateTime.parse(map['created_at'] as String),
      last_seen: DateTime.parse(map['last_seen'] as String),
      name: map['name'] as String,
      tag: map['tag'] != null ? map['tag'] as String : null,
      signature: map['signature'] != null ? map['signature'] as String : null,
      cidr: map['cidr'] != null ? map['cidr'] as String : null,
      subnet: map['subnet'] as String?,
      plane: map['plane'] as String?,
      public: map['public'] != null ? map['public'] as bool : null,
      portal: map['portal'] != null ? map['portal'] as bool : null,
      ca_pem: map['ca_pem'] as String?,
      key_pem: map['key_pem'] as String?,
      cert_pem: map['cert_pem'] as String?,
      veil_host: map['veil_host'] as String?,
      veil_port: map['veil_port'] as int?,
      region: map['region'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory Conflux.fromJson(String source) =>
      Conflux.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Conflux(id: $id, created_at: $created_at, last_seen: $last_seen, name: $name, tag: $tag, signature: $signature, cidr: $cidr, subnet: $subnet, plane: $plane, public: $public, portal: $portal, ca_pem: $ca_pem, key_pem: $key_pem, cert_pem: $cert_pem, veil_host: $veil_host, veil_port: $veil_port, region: $region)';
  }

  @override
  bool operator ==(covariant Conflux other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.created_at == created_at &&
        other.last_seen == last_seen &&
        other.name == name &&
        other.tag == tag &&
        other.signature == signature &&
        other.cidr == cidr &&
        other.subnet == subnet &&
        other.plane == plane &&
        other.public == public &&
        other.portal == portal &&
        other.ca_pem == ca_pem &&
        other.key_pem == key_pem &&
        other.cert_pem == cert_pem &&
        other.veil_host == veil_host &&
        other.veil_port == veil_port &&
        other.region == region;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        created_at.hashCode ^
        last_seen.hashCode ^
        name.hashCode ^
        tag.hashCode ^
        signature.hashCode ^
        cidr.hashCode ^
        subnet.hashCode ^
        plane.hashCode ^
        public.hashCode ^
        portal.hashCode ^
        ca_pem.hashCode ^
        key_pem.hashCode ^
        cert_pem.hashCode ^
        veil_host.hashCode ^
        veil_port.hashCode ^
        region.hashCode;
  }
}

final confluxesProvider = FutureProvider<List<Conflux>>((ref) async {
  final confluxes = await supabase.from('conflux_details').select('*');
  return confluxes.map((json) => Conflux.fromMap(json)).toList();
});
