import 'package:rift/models/conflux.dart';
import 'package:rift/models/conflux_session.dart';
import 'package:rift/models/ip_lease.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'veilnet.freezed.dart';
part 'veilnet.g.dart';

@freezed
abstract class Veilnet with _$Veilnet {
  factory Veilnet({
    Conflux? conflux,
    ConfluxSession? session,
    IpLease? ipLease,
  }) = _Veilnet;

  factory Veilnet.fromJson(Map<String, dynamic> json) => _$VeilnetFromJson(json);
}