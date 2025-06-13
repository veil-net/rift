// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../main.dart';

class Domain {
  final String id;
  final DateTime created_at;
  final String veil_id;
  final String name;
  final String subnet;
  final String region;
  final String veil_host;
  final int veil_port;
  Domain({
    required this.id,
    required this.created_at,
    required this.veil_id,
    required this.name,
    required this.subnet,
    required this.region,
    required this.veil_host,
    required this.veil_port,
  });

  Domain copyWith({
    String? id,
    DateTime? created_at,
    String? veil_id,
    String? name,
    String? subnet,
    String? region,
    String? veil_host,
    int? veil_port,
  }) {
    return Domain(
      id: id ?? this.id,
      created_at: created_at ?? this.created_at,
      veil_id: veil_id ?? this.veil_id,
      name: name ?? this.name,
      subnet: subnet ?? this.subnet,
      region: region ?? this.region,
      veil_host: veil_host ?? this.veil_host,
      veil_port: veil_port ?? this.veil_port,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': created_at.toUtc().toIso8601String(),
      'veil_id': veil_id,
      'name': name,
      'subnet': subnet,
      'region': region,
      'veil_host': veil_host,
      'veil_port': veil_port,
    };
  }

  factory Domain.fromMap(Map<String, dynamic> map) {
    return Domain(
      id: map['id'] as String,
      created_at: DateTime.parse(map['created_at'] as String),
      veil_id: map['veil_id'] as String,
      name: map['name'] as String,
      subnet: map['subnet'] as String,
      region: map['region'] as String,
      veil_host: map['veil_host'] as String,
      veil_port: map['veil_port'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Domain.fromJson(String source) =>
      Domain.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Domain(id: $id, created_at: $created_at, veil_id: $veil_id, name: $name, subnet: $subnet, region: $region, veil_host: $veil_host, veil_port: $veil_port)';
  }

  @override
  bool operator ==(covariant Domain other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.created_at == created_at &&
        other.veil_id == veil_id &&
        other.name == name &&
        other.subnet == subnet &&
        other.region == region &&
        other.veil_host == veil_host &&
        other.veil_port == veil_port;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        created_at.hashCode ^
        veil_id.hashCode ^
        name.hashCode ^
        subnet.hashCode ^
        region.hashCode ^
        veil_host.hashCode ^
        veil_port.hashCode;
  }
}

final domainProvider = FutureProvider.family<List<Domain>, bool>((
  ref,
  public,
) async {
  final domains =
      public
          ? await supabase.from('public_domains').select('*')
          : await supabase.from('private_domains').select('*');
  return domains.map((json) => Domain.fromMap(json)).toList();
});

final domainByRegionProvider =
    FutureProvider.family<List<Domain>, (bool public, String region)>((
      ref,
      params,
    ) async {
      final domains = await ref.watch(domainProvider(params.$1).future);
      return domains.where((domain) => domain.region == params.$2).toList();
    });
