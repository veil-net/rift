// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/main.dart';

class Plane {
  final String id;
  final DateTime created_at;
  final String name;
  final String subnet;
  final bool public;
  final String region;
  final String veil_host;
  final int veil_port;
  final int portals;
  Plane({
    required this.id,
    required this.created_at,
    required this.name,
    required this.subnet,
    required this.public,
    required this.region,
    required this.veil_host,
    required this.veil_port,
    required this.portals,
  });

  Plane copyWith({
    String? id,
    DateTime? created_at,
    String? name,
    String? subnet,
    bool? public,
    String? region,
    String? veil_host,
    int? veil_port,
    int? portals,
  }) {
    return Plane(
      id: id ?? this.id,
      created_at: created_at ?? this.created_at,
      name: name ?? this.name,
      subnet: subnet ?? this.subnet,
      public: public ?? this.public,
      region: region ?? this.region,
      veil_host: veil_host ?? this.veil_host,
      veil_port: veil_port ?? this.veil_port,
      portals: portals ?? this.portals,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': created_at.toUtc().toIso8601String(),
      'name': name,
      'subnet': subnet,
      'public': public,
      'region': region,
      'veil_host': veil_host,
      'veil_port': veil_port,
      'portals': portals,
    };
  }

  factory Plane.fromMap(Map<String, dynamic> map) {
    return Plane(
      id: map['id'] as String,
      created_at: DateTime.parse(map['created_at'] as String),
      name: map['name'] as String,
      subnet: map['subnet'] as String,
      public: map['public'] as bool,
      region: map['region'] as String,
      veil_host: map['veil_host'] as String,
      veil_port: map['veil_port'] as int,
      portals: map['portals'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Plane.fromJson(String source) =>
      Plane.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Plane(id: $id, created_at: $created_at, name: $name, subnet: $subnet, public: $public, region: $region, veil_host: $veil_host, veil_port: $veil_port, portals: $portals)';
  }

  @override
  bool operator ==(covariant Plane other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.created_at == created_at &&
        other.name == name &&
        other.subnet == subnet &&
        other.public == public &&
        other.region == region &&
        other.veil_host == veil_host &&
        other.veil_port == veil_port &&
        other.portals == portals;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        created_at.hashCode ^
        name.hashCode ^
        subnet.hashCode ^
        public.hashCode ^
        region.hashCode ^
        veil_host.hashCode ^
        veil_port.hashCode ^
        portals.hashCode;
  }
}

final planesProvider = FutureProvider<List<Plane>>((ref) async {
  final planes = await supabase.from('planes').select('*');
  return planes.map((json) => Plane.fromMap(json)).toList();
});

final publicPlanesProvider = FutureProvider<List<Plane>>((ref) async {
  final planes = await ref.watch(planesProvider.future);
  return planes.where((plane) => plane.public).toList();
});

final privatePlanesProvider = FutureProvider<List<Plane>>((ref) async {
  final planes = await ref.watch(planesProvider.future);
  return planes.where((plane) => !plane.public).toList();
});

final regionProvider = FutureProvider<List<String>>((ref) async {
  final planes = await ref.watch(planesProvider.future);
  return planes.map((plane) => plane.region).toSet().toList();
});

final regionFilterProvider = StateProvider<List<String>>((ref) {
  final planes = ref.watch(planesProvider);
  return planes.when(
    data:
        (planesList) =>
            planesList.map((plane) => plane.region).toSet().toList(),
    loading: () => [],
    error: (error, stack) => [],
  );
});

final planeNameFilterProvider = StateProvider<String>((ref) {
  return '';
});

final planeVisibilityProvider = StateProvider<bool>((ref) {
  return false;
});