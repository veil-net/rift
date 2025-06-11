import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../main.dart';

class Domain {
  final String id;
  final DateTime createdAt;
  final String veilID;
  final String name;
  final String subnet;
  final String region;
  final String veilHost;
  final int veilPort;

  Domain({
    required this.id,
    required this.createdAt,
    required this.veilID,
    required this.name,
    required this.subnet,
    required this.region,
    required this.veilHost,
    required this.veilPort,
  });

  factory Domain.fromJson(Map<String, dynamic> json) {
    return Domain(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      veilID: json['veil_id'],
      name: json['name'],
      subnet: json['subnet'],
      region: json['region'],
      veilHost: json['veil_host'],
      veilPort: json['veil_port'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'veil_id': veilID,
      'name': name,
      'subnet': subnet,
      'region': region,
      'veil_host': veilHost,
      'veil_port': veilPort,
    };
  }
}

final publicDomainProvider = FutureProvider<List<Domain>>((ref) async {
  final response = await supabase.from('public_domains').select('*');
  return response.map((json) => Domain.fromJson(json)).toList();
});

final privateDomainProvider = FutureProvider<List<Domain>>((ref) async {
  final response = await supabase.from('private_domains').select('*');
  return response.map((json) => Domain.fromJson(json)).toList();
});
