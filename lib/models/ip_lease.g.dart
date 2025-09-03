// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ip_lease.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IpLease _$IpLeaseFromJson(Map<String, dynamic> json) => _IpLease(
  id: json['id'] as String,
  created_at: DateTime.parse(json['created_at'] as String),
  user_id: json['user_id'] as String,
  plane_id: json['plane_id'] as String,
  conflux_id: json['conflux_id'] as String,
  cidr: json['cidr'] as String,
  renewed_at: DateTime.parse(json['renewed_at'] as String),
);

Map<String, dynamic> _$IpLeaseToJson(_IpLease instance) => <String, dynamic>{
  'id': instance.id,
  'created_at': instance.created_at.toIso8601String(),
  'user_id': instance.user_id,
  'plane_id': instance.plane_id,
  'conflux_id': instance.conflux_id,
  'cidr': instance.cidr,
  'renewed_at': instance.renewed_at.toIso8601String(),
};
