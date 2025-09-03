import 'package:freezed_annotation/freezed_annotation.dart';

part 'ip_lease.freezed.dart';
part 'ip_lease.g.dart';

@freezed
abstract class IpLease with _$IpLease {
  factory IpLease({
    required String id,
    required DateTime created_at,
    required String user_id,
    required String plane_id,
    required String conflux_id,
    required String cidr,
    required DateTime renewed_at,
  }) = _IpLease;

  factory IpLease.fromJson(Map<String, dynamic> json) => _$IpLeaseFromJson(json);
}