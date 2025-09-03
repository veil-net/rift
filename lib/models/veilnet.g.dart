// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'veilnet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Veilnet _$VeilnetFromJson(Map<String, dynamic> json) => _Veilnet(
  conflux: json['conflux'] == null
      ? null
      : Conflux.fromJson(json['conflux'] as Map<String, dynamic>),
  session: json['session'] == null
      ? null
      : ConfluxSession.fromJson(json['session'] as Map<String, dynamic>),
  ipLease: json['ipLease'] == null
      ? null
      : IpLease.fromJson(json['ipLease'] as Map<String, dynamic>),
);

Map<String, dynamic> _$VeilnetToJson(_Veilnet instance) => <String, dynamic>{
  'conflux': instance.conflux,
  'session': instance.session,
  'ipLease': instance.ipLease,
};
