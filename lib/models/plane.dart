import 'package:freezed_annotation/freezed_annotation.dart';

part 'plane.freezed.dart';
part 'plane.g.dart';

@freezed
abstract class Plane with _$Plane {
  factory Plane({
    required String id,
    required DateTime created_at,
    required String user_id,
    required String veil_id,
    required String name,
    required String subnet,
    required bool public,
    required String region,
    required String veil_host,
    required int veil_port,
    required int portals,
  }) = _Plane;

  factory Plane.fromJson(Map<String, dynamic> json) => _$PlaneFromJson(json);
}
