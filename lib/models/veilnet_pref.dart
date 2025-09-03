import 'package:freezed_annotation/freezed_annotation.dart';

part 'veilnet_pref.freezed.dart';
part 'veilnet_pref.g.dart';

@freezed
abstract class VeilnetPref with _$VeilnetPref {
  factory VeilnetPref({
    String? name,
    String? planeID,
  }) = _VeilnetPref;

  factory VeilnetPref.fromJson(Map<String, dynamic> json) => _$VeilnetPrefFromJson(json);
}