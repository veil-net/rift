// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conflux_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConfluxDetails _$ConfluxDetailsFromJson(Map<String, dynamic> json) =>
    _ConfluxDetails(
      id: json['id'] as String,
      created_at: DateTime.parse(json['created_at'] as String),
      last_seen: DateTime.parse(json['last_seen'] as String),
      user_id: json['user_id'] as String,
      name: json['name'] as String,
      tag: json['tag'] as String?,
      signature: json['signature'] as String?,
      cidr: json['cidr'] as String?,
      subnet: json['subnet'] as String?,
      plane: json['plane'] as String,
      plane_id: json['plane_id'] as String,
      public: json['public'] as bool,
      portal: json['portal'] as bool,
      region: json['region'] as String,
    );

Map<String, dynamic> _$ConfluxDetailsToJson(_ConfluxDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.created_at.toIso8601String(),
      'last_seen': instance.last_seen.toIso8601String(),
      'user_id': instance.user_id,
      'name': instance.name,
      'tag': instance.tag,
      'signature': instance.signature,
      'cidr': instance.cidr,
      'subnet': instance.subnet,
      'plane': instance.plane,
      'plane_id': instance.plane_id,
      'public': instance.public,
      'portal': instance.portal,
      'region': instance.region,
    };
