import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'api_provider.dart';

class Veil {
  final String id;
  final DateTime createdAt;
  final String name;
  final String region;

  Veil({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.region,
  });

  factory Veil.fromJson(Map<String, dynamic> json) {
    return Veil(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      name: json['name'],
      region: json['region'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'name': name,
      'region': region,
    };
  }
}

final veilProvider = FutureProvider<List<Veil>>((ref) async {
  final api = ref.watch(apiProvider);
  final response = await api.get('/veil/list/info');
  final data = response.data as List<dynamic>;
  return data.map((e) => Veil.fromJson(e)).toList();
});
