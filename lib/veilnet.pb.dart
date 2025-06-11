//
//  Generated code. Do not modify.
//  source: veilnet.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'veilnet.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'veilnet.pbenum.dart';

class Header extends $pb.GeneratedMessage {
  factory Header({
    MessageType? type,
    $core.int? version,
    $core.int? length,
  }) {
    final result = create();
    if (type != null) result.type = type;
    if (version != null) result.version = version;
    if (length != null) result.length = length;
    return result;
  }

  Header._();

  factory Header.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory Header.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Header', package: const $pb.PackageName(_omitMessageNames ? '' : 'veilnet'), createEmptyInstance: create)
    ..e<MessageType>(1, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: MessageType.RTC_OFFER, valueOf: MessageType.valueOf, enumValues: MessageType.values)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'version', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'length', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Header clone() => Header()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Header copyWith(void Function(Header) updates) => super.copyWith((message) => updates(message as Header)) as Header;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Header create() => Header._();
  @$core.override
  Header createEmptyInstance() => create();
  static $pb.PbList<Header> createRepeated() => $pb.PbList<Header>();
  @$core.pragma('dart2js:noInline')
  static Header getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Header>(create);
  static Header? _defaultInstance;

  @$pb.TagNumber(1)
  MessageType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(MessageType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get version => $_getIZ(1);
  @$pb.TagNumber(2)
  set version($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearVersion() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get length => $_getIZ(2);
  @$pb.TagNumber(3)
  set length($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLength() => $_has(2);
  @$pb.TagNumber(3)
  void clearLength() => $_clearField(3);
}

class RTC_Offer extends $pb.GeneratedMessage {
  factory RTC_Offer({
    $core.String? signature,
    $core.String? label,
    $core.List<$core.int>? offer,
  }) {
    final result = create();
    if (signature != null) result.signature = signature;
    if (label != null) result.label = label;
    if (offer != null) result.offer = offer;
    return result;
  }

  RTC_Offer._();

  factory RTC_Offer.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory RTC_Offer.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RTC_Offer', package: const $pb.PackageName(_omitMessageNames ? '' : 'veilnet'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'signature')
    ..aOS(2, _omitFieldNames ? '' : 'label')
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'offer', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RTC_Offer clone() => RTC_Offer()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RTC_Offer copyWith(void Function(RTC_Offer) updates) => super.copyWith((message) => updates(message as RTC_Offer)) as RTC_Offer;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RTC_Offer create() => RTC_Offer._();
  @$core.override
  RTC_Offer createEmptyInstance() => create();
  static $pb.PbList<RTC_Offer> createRepeated() => $pb.PbList<RTC_Offer>();
  @$core.pragma('dart2js:noInline')
  static RTC_Offer getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RTC_Offer>(create);
  static RTC_Offer? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get signature => $_getSZ(0);
  @$pb.TagNumber(1)
  set signature($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSignature() => $_has(0);
  @$pb.TagNumber(1)
  void clearSignature() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get label => $_getSZ(1);
  @$pb.TagNumber(2)
  set label($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLabel() => $_has(1);
  @$pb.TagNumber(2)
  void clearLabel() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get offer => $_getN(2);
  @$pb.TagNumber(3)
  set offer($core.List<$core.int> value) => $_setBytes(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOffer() => $_has(2);
  @$pb.TagNumber(3)
  void clearOffer() => $_clearField(3);
}

class RTC_Answer extends $pb.GeneratedMessage {
  factory RTC_Answer({
    $core.String? signature,
    $core.String? label,
    $core.List<$core.int>? answer,
  }) {
    final result = create();
    if (signature != null) result.signature = signature;
    if (label != null) result.label = label;
    if (answer != null) result.answer = answer;
    return result;
  }

  RTC_Answer._();

  factory RTC_Answer.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory RTC_Answer.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RTC_Answer', package: const $pb.PackageName(_omitMessageNames ? '' : 'veilnet'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'signature')
    ..aOS(2, _omitFieldNames ? '' : 'label')
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'answer', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RTC_Answer clone() => RTC_Answer()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RTC_Answer copyWith(void Function(RTC_Answer) updates) => super.copyWith((message) => updates(message as RTC_Answer)) as RTC_Answer;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RTC_Answer create() => RTC_Answer._();
  @$core.override
  RTC_Answer createEmptyInstance() => create();
  static $pb.PbList<RTC_Answer> createRepeated() => $pb.PbList<RTC_Answer>();
  @$core.pragma('dart2js:noInline')
  static RTC_Answer getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RTC_Answer>(create);
  static RTC_Answer? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get signature => $_getSZ(0);
  @$pb.TagNumber(1)
  set signature($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSignature() => $_has(0);
  @$pb.TagNumber(1)
  void clearSignature() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get label => $_getSZ(1);
  @$pb.TagNumber(2)
  set label($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLabel() => $_has(1);
  @$pb.TagNumber(2)
  void clearLabel() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get answer => $_getN(2);
  @$pb.TagNumber(3)
  set answer($core.List<$core.int> value) => $_setBytes(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAnswer() => $_has(2);
  @$pb.TagNumber(3)
  void clearAnswer() => $_clearField(3);
}

class RTC_Sync extends $pb.GeneratedMessage {
  factory RTC_Sync({
    $core.String? signature,
    $core.String? label,
  }) {
    final result = create();
    if (signature != null) result.signature = signature;
    if (label != null) result.label = label;
    return result;
  }

  RTC_Sync._();

  factory RTC_Sync.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory RTC_Sync.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RTC_Sync', package: const $pb.PackageName(_omitMessageNames ? '' : 'veilnet'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'signature')
    ..aOS(2, _omitFieldNames ? '' : 'label')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RTC_Sync clone() => RTC_Sync()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RTC_Sync copyWith(void Function(RTC_Sync) updates) => super.copyWith((message) => updates(message as RTC_Sync)) as RTC_Sync;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RTC_Sync create() => RTC_Sync._();
  @$core.override
  RTC_Sync createEmptyInstance() => create();
  static $pb.PbList<RTC_Sync> createRepeated() => $pb.PbList<RTC_Sync>();
  @$core.pragma('dart2js:noInline')
  static RTC_Sync getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RTC_Sync>(create);
  static RTC_Sync? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get signature => $_getSZ(0);
  @$pb.TagNumber(1)
  set signature($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSignature() => $_has(0);
  @$pb.TagNumber(1)
  void clearSignature() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get label => $_getSZ(1);
  @$pb.TagNumber(2)
  set label($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLabel() => $_has(1);
  @$pb.TagNumber(2)
  void clearLabel() => $_clearField(2);
}

class CandidateOffer extends $pb.GeneratedMessage {
  factory CandidateOffer({
    $core.String? signature,
    $core.String? candidate,
  }) {
    final result = create();
    if (signature != null) result.signature = signature;
    if (candidate != null) result.candidate = candidate;
    return result;
  }

  CandidateOffer._();

  factory CandidateOffer.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory CandidateOffer.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CandidateOffer', package: const $pb.PackageName(_omitMessageNames ? '' : 'veilnet'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'signature')
    ..aOS(2, _omitFieldNames ? '' : 'candidate')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CandidateOffer clone() => CandidateOffer()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CandidateOffer copyWith(void Function(CandidateOffer) updates) => super.copyWith((message) => updates(message as CandidateOffer)) as CandidateOffer;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CandidateOffer create() => CandidateOffer._();
  @$core.override
  CandidateOffer createEmptyInstance() => create();
  static $pb.PbList<CandidateOffer> createRepeated() => $pb.PbList<CandidateOffer>();
  @$core.pragma('dart2js:noInline')
  static CandidateOffer getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CandidateOffer>(create);
  static CandidateOffer? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get signature => $_getSZ(0);
  @$pb.TagNumber(1)
  set signature($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSignature() => $_has(0);
  @$pb.TagNumber(1)
  void clearSignature() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get candidate => $_getSZ(1);
  @$pb.TagNumber(2)
  set candidate($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCandidate() => $_has(1);
  @$pb.TagNumber(2)
  void clearCandidate() => $_clearField(2);
}

class CandidateAnswer extends $pb.GeneratedMessage {
  factory CandidateAnswer() => create();

  CandidateAnswer._();

  factory CandidateAnswer.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory CandidateAnswer.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CandidateAnswer', package: const $pb.PackageName(_omitMessageNames ? '' : 'veilnet'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CandidateAnswer clone() => CandidateAnswer()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CandidateAnswer copyWith(void Function(CandidateAnswer) updates) => super.copyWith((message) => updates(message as CandidateAnswer)) as CandidateAnswer;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CandidateAnswer create() => CandidateAnswer._();
  @$core.override
  CandidateAnswer createEmptyInstance() => create();
  static $pb.PbList<CandidateAnswer> createRepeated() => $pb.PbList<CandidateAnswer>();
  @$core.pragma('dart2js:noInline')
  static CandidateAnswer getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CandidateAnswer>(create);
  static CandidateAnswer? _defaultInstance;
}

class ArpRequest extends $pb.GeneratedMessage {
  factory ArpRequest({
    $core.String? signature,
  }) {
    final result = create();
    if (signature != null) result.signature = signature;
    return result;
  }

  ArpRequest._();

  factory ArpRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ArpRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ArpRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'veilnet'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'signature')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ArpRequest clone() => ArpRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ArpRequest copyWith(void Function(ArpRequest) updates) => super.copyWith((message) => updates(message as ArpRequest)) as ArpRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ArpRequest create() => ArpRequest._();
  @$core.override
  ArpRequest createEmptyInstance() => create();
  static $pb.PbList<ArpRequest> createRepeated() => $pb.PbList<ArpRequest>();
  @$core.pragma('dart2js:noInline')
  static ArpRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ArpRequest>(create);
  static ArpRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get signature => $_getSZ(0);
  @$pb.TagNumber(1)
  set signature($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSignature() => $_has(0);
  @$pb.TagNumber(1)
  void clearSignature() => $_clearField(1);
}

class ArpResponse extends $pb.GeneratedMessage {
  factory ArpResponse({
    $core.String? signature,
  }) {
    final result = create();
    if (signature != null) result.signature = signature;
    return result;
  }

  ArpResponse._();

  factory ArpResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ArpResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ArpResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'veilnet'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'signature')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ArpResponse clone() => ArpResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ArpResponse copyWith(void Function(ArpResponse) updates) => super.copyWith((message) => updates(message as ArpResponse)) as ArpResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ArpResponse create() => ArpResponse._();
  @$core.override
  ArpResponse createEmptyInstance() => create();
  static $pb.PbList<ArpResponse> createRepeated() => $pb.PbList<ArpResponse>();
  @$core.pragma('dart2js:noInline')
  static ArpResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ArpResponse>(create);
  static ArpResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get signature => $_getSZ(0);
  @$pb.TagNumber(1)
  set signature($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSignature() => $_has(0);
  @$pb.TagNumber(1)
  void clearSignature() => $_clearField(1);
}

class ArpUpdate extends $pb.GeneratedMessage {
  factory ArpUpdate({
    $core.String? dst,
    $core.String? nextHop,
  }) {
    final result = create();
    if (dst != null) result.dst = dst;
    if (nextHop != null) result.nextHop = nextHop;
    return result;
  }

  ArpUpdate._();

  factory ArpUpdate.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ArpUpdate.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ArpUpdate', package: const $pb.PackageName(_omitMessageNames ? '' : 'veilnet'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'dst')
    ..aOS(2, _omitFieldNames ? '' : 'nextHop')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ArpUpdate clone() => ArpUpdate()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ArpUpdate copyWith(void Function(ArpUpdate) updates) => super.copyWith((message) => updates(message as ArpUpdate)) as ArpUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ArpUpdate create() => ArpUpdate._();
  @$core.override
  ArpUpdate createEmptyInstance() => create();
  static $pb.PbList<ArpUpdate> createRepeated() => $pb.PbList<ArpUpdate>();
  @$core.pragma('dart2js:noInline')
  static ArpUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ArpUpdate>(create);
  static ArpUpdate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get dst => $_getSZ(0);
  @$pb.TagNumber(1)
  set dst($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDst() => $_has(0);
  @$pb.TagNumber(1)
  void clearDst() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get nextHop => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextHop($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNextHop() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextHop() => $_clearField(2);
}

class StreamRequest extends $pb.GeneratedMessage {
  factory StreamRequest({
    $core.String? ip,
    $core.String? uid,
    $core.String? preferedRegion,
    $core.List<$core.int>? publicKey,
  }) {
    final result = create();
    if (ip != null) result.ip = ip;
    if (uid != null) result.uid = uid;
    if (preferedRegion != null) result.preferedRegion = preferedRegion;
    if (publicKey != null) result.publicKey = publicKey;
    return result;
  }

  StreamRequest._();

  factory StreamRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory StreamRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StreamRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'veilnet'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ip')
    ..aOS(2, _omitFieldNames ? '' : 'uid')
    ..aOS(3, _omitFieldNames ? '' : 'preferedRegion')
    ..a<$core.List<$core.int>>(4, _omitFieldNames ? '' : 'publicKey', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamRequest clone() => StreamRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamRequest copyWith(void Function(StreamRequest) updates) => super.copyWith((message) => updates(message as StreamRequest)) as StreamRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StreamRequest create() => StreamRequest._();
  @$core.override
  StreamRequest createEmptyInstance() => create();
  static $pb.PbList<StreamRequest> createRepeated() => $pb.PbList<StreamRequest>();
  @$core.pragma('dart2js:noInline')
  static StreamRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StreamRequest>(create);
  static StreamRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ip => $_getSZ(0);
  @$pb.TagNumber(1)
  set ip($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIp() => $_has(0);
  @$pb.TagNumber(1)
  void clearIp() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get uid => $_getSZ(1);
  @$pb.TagNumber(2)
  set uid($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUid() => $_has(1);
  @$pb.TagNumber(2)
  void clearUid() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get preferedRegion => $_getSZ(2);
  @$pb.TagNumber(3)
  set preferedRegion($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPreferedRegion() => $_has(2);
  @$pb.TagNumber(3)
  void clearPreferedRegion() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get publicKey => $_getN(3);
  @$pb.TagNumber(4)
  set publicKey($core.List<$core.int> value) => $_setBytes(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPublicKey() => $_has(3);
  @$pb.TagNumber(4)
  void clearPublicKey() => $_clearField(4);
}

class StreamResponse extends $pb.GeneratedMessage {
  factory StreamResponse({
    $core.String? signature,
    $core.List<$core.int>? cipher,
    $core.List<$core.int>? encryptedStreamId,
  }) {
    final result = create();
    if (signature != null) result.signature = signature;
    if (cipher != null) result.cipher = cipher;
    if (encryptedStreamId != null) result.encryptedStreamId = encryptedStreamId;
    return result;
  }

  StreamResponse._();

  factory StreamResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory StreamResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StreamResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'veilnet'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'signature')
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'cipher', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'encryptedStreamId', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamResponse clone() => StreamResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamResponse copyWith(void Function(StreamResponse) updates) => super.copyWith((message) => updates(message as StreamResponse)) as StreamResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StreamResponse create() => StreamResponse._();
  @$core.override
  StreamResponse createEmptyInstance() => create();
  static $pb.PbList<StreamResponse> createRepeated() => $pb.PbList<StreamResponse>();
  @$core.pragma('dart2js:noInline')
  static StreamResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StreamResponse>(create);
  static StreamResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get signature => $_getSZ(0);
  @$pb.TagNumber(1)
  set signature($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSignature() => $_has(0);
  @$pb.TagNumber(1)
  void clearSignature() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get cipher => $_getN(1);
  @$pb.TagNumber(2)
  set cipher($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCipher() => $_has(1);
  @$pb.TagNumber(2)
  void clearCipher() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get encryptedStreamId => $_getN(2);
  @$pb.TagNumber(3)
  set encryptedStreamId($core.List<$core.int> value) => $_setBytes(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEncryptedStreamId() => $_has(2);
  @$pb.TagNumber(3)
  void clearEncryptedStreamId() => $_clearField(3);
}

class StreamUpdate extends $pb.GeneratedMessage {
  factory StreamUpdate({
    $core.String? streamId,
  }) {
    final result = create();
    if (streamId != null) result.streamId = streamId;
    return result;
  }

  StreamUpdate._();

  factory StreamUpdate.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory StreamUpdate.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StreamUpdate', package: const $pb.PackageName(_omitMessageNames ? '' : 'veilnet'), createEmptyInstance: create)
    ..aOS(2, _omitFieldNames ? '' : 'streamId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamUpdate clone() => StreamUpdate()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamUpdate copyWith(void Function(StreamUpdate) updates) => super.copyWith((message) => updates(message as StreamUpdate)) as StreamUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StreamUpdate create() => StreamUpdate._();
  @$core.override
  StreamUpdate createEmptyInstance() => create();
  static $pb.PbList<StreamUpdate> createRepeated() => $pb.PbList<StreamUpdate>();
  @$core.pragma('dart2js:noInline')
  static StreamUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StreamUpdate>(create);
  static StreamUpdate? _defaultInstance;

  @$pb.TagNumber(2)
  $core.String get streamId => $_getSZ(0);
  @$pb.TagNumber(2)
  set streamId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(2)
  $core.bool hasStreamId() => $_has(0);
  @$pb.TagNumber(2)
  void clearStreamId() => $_clearField(2);
}

class Data extends $pb.GeneratedMessage {
  factory Data({
    $core.String? dst,
    $core.String? streamId,
    $core.List<$core.int>? encryptedData,
  }) {
    final result = create();
    if (dst != null) result.dst = dst;
    if (streamId != null) result.streamId = streamId;
    if (encryptedData != null) result.encryptedData = encryptedData;
    return result;
  }

  Data._();

  factory Data.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory Data.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Data', package: const $pb.PackageName(_omitMessageNames ? '' : 'veilnet'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'dst')
    ..aOS(2, _omitFieldNames ? '' : 'streamId')
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'encryptedData', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Data clone() => Data()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Data copyWith(void Function(Data) updates) => super.copyWith((message) => updates(message as Data)) as Data;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Data create() => Data._();
  @$core.override
  Data createEmptyInstance() => create();
  static $pb.PbList<Data> createRepeated() => $pb.PbList<Data>();
  @$core.pragma('dart2js:noInline')
  static Data getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Data>(create);
  static Data? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get dst => $_getSZ(0);
  @$pb.TagNumber(1)
  set dst($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDst() => $_has(0);
  @$pb.TagNumber(1)
  void clearDst() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get streamId => $_getSZ(1);
  @$pb.TagNumber(2)
  set streamId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStreamId() => $_has(1);
  @$pb.TagNumber(2)
  void clearStreamId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get encryptedData => $_getN(2);
  @$pb.TagNumber(3)
  set encryptedData($core.List<$core.int> value) => $_setBytes(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEncryptedData() => $_has(2);
  @$pb.TagNumber(3)
  void clearEncryptedData() => $_clearField(3);
}

class CmdResponse extends $pb.GeneratedMessage {
  factory CmdResponse({
    $core.String? response,
  }) {
    final result = create();
    if (response != null) result.response = response;
    return result;
  }

  CmdResponse._();

  factory CmdResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory CmdResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CmdResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'veilnet'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'response')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CmdResponse clone() => CmdResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CmdResponse copyWith(void Function(CmdResponse) updates) => super.copyWith((message) => updates(message as CmdResponse)) as CmdResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CmdResponse create() => CmdResponse._();
  @$core.override
  CmdResponse createEmptyInstance() => create();
  static $pb.PbList<CmdResponse> createRepeated() => $pb.PbList<CmdResponse>();
  @$core.pragma('dart2js:noInline')
  static CmdResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CmdResponse>(create);
  static CmdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get response => $_getSZ(0);
  @$pb.TagNumber(1)
  set response($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasResponse() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponse() => $_clearField(1);
}

class CmdLocalNetwork extends $pb.GeneratedMessage {
  factory CmdLocalNetwork({
    $core.String? subnet,
    $core.String? userId,
  }) {
    final result = create();
    if (subnet != null) result.subnet = subnet;
    if (userId != null) result.userId = userId;
    return result;
  }

  CmdLocalNetwork._();

  factory CmdLocalNetwork.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory CmdLocalNetwork.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CmdLocalNetwork', package: const $pb.PackageName(_omitMessageNames ? '' : 'veilnet'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'subnet')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CmdLocalNetwork clone() => CmdLocalNetwork()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CmdLocalNetwork copyWith(void Function(CmdLocalNetwork) updates) => super.copyWith((message) => updates(message as CmdLocalNetwork)) as CmdLocalNetwork;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CmdLocalNetwork create() => CmdLocalNetwork._();
  @$core.override
  CmdLocalNetwork createEmptyInstance() => create();
  static $pb.PbList<CmdLocalNetwork> createRepeated() => $pb.PbList<CmdLocalNetwork>();
  @$core.pragma('dart2js:noInline')
  static CmdLocalNetwork getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CmdLocalNetwork>(create);
  static CmdLocalNetwork? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get subnet => $_getSZ(0);
  @$pb.TagNumber(1)
  set subnet($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSubnet() => $_has(0);
  @$pb.TagNumber(1)
  void clearSubnet() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);
}

class IpcStart extends $pb.GeneratedMessage {
  factory IpcStart({
    $core.String? apiBaseUrl,
    $core.String? anchorToken,
    $core.String? anchorName,
    $core.String? domainName,
    $core.String? region,
    $core.bool? public,
  }) {
    final result = create();
    if (apiBaseUrl != null) result.apiBaseUrl = apiBaseUrl;
    if (anchorToken != null) result.anchorToken = anchorToken;
    if (anchorName != null) result.anchorName = anchorName;
    if (domainName != null) result.domainName = domainName;
    if (region != null) result.region = region;
    if (public != null) result.public = public;
    return result;
  }

  IpcStart._();

  factory IpcStart.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory IpcStart.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'IpcStart', package: const $pb.PackageName(_omitMessageNames ? '' : 'veilnet'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'apiBaseUrl')
    ..aOS(2, _omitFieldNames ? '' : 'anchorToken')
    ..aOS(3, _omitFieldNames ? '' : 'anchorName')
    ..aOS(4, _omitFieldNames ? '' : 'domainName')
    ..aOS(5, _omitFieldNames ? '' : 'region')
    ..aOB(6, _omitFieldNames ? '' : 'public')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IpcStart clone() => IpcStart()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IpcStart copyWith(void Function(IpcStart) updates) => super.copyWith((message) => updates(message as IpcStart)) as IpcStart;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IpcStart create() => IpcStart._();
  @$core.override
  IpcStart createEmptyInstance() => create();
  static $pb.PbList<IpcStart> createRepeated() => $pb.PbList<IpcStart>();
  @$core.pragma('dart2js:noInline')
  static IpcStart getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<IpcStart>(create);
  static IpcStart? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get apiBaseUrl => $_getSZ(0);
  @$pb.TagNumber(1)
  set apiBaseUrl($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasApiBaseUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearApiBaseUrl() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get anchorToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set anchorToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAnchorToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearAnchorToken() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get anchorName => $_getSZ(2);
  @$pb.TagNumber(3)
  set anchorName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAnchorName() => $_has(2);
  @$pb.TagNumber(3)
  void clearAnchorName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get domainName => $_getSZ(3);
  @$pb.TagNumber(4)
  set domainName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDomainName() => $_has(3);
  @$pb.TagNumber(4)
  void clearDomainName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get region => $_getSZ(4);
  @$pb.TagNumber(5)
  set region($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRegion() => $_has(4);
  @$pb.TagNumber(5)
  void clearRegion() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get public => $_getBF(5);
  @$pb.TagNumber(6)
  set public($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPublic() => $_has(5);
  @$pb.TagNumber(6)
  void clearPublic() => $_clearField(6);
}

class IpcStop extends $pb.GeneratedMessage {
  factory IpcStop() => create();

  IpcStop._();

  factory IpcStop.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory IpcStop.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'IpcStop', package: const $pb.PackageName(_omitMessageNames ? '' : 'veilnet'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IpcStop clone() => IpcStop()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IpcStop copyWith(void Function(IpcStop) updates) => super.copyWith((message) => updates(message as IpcStop)) as IpcStop;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IpcStop create() => IpcStop._();
  @$core.override
  IpcStop createEmptyInstance() => create();
  static $pb.PbList<IpcStop> createRepeated() => $pb.PbList<IpcStop>();
  @$core.pragma('dart2js:noInline')
  static IpcStop getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<IpcStop>(create);
  static IpcStop? _defaultInstance;
}

class IpcResponse extends $pb.GeneratedMessage {
  factory IpcResponse({
    $core.String? response,
  }) {
    final result = create();
    if (response != null) result.response = response;
    return result;
  }

  IpcResponse._();

  factory IpcResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory IpcResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'IpcResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'veilnet'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'response')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IpcResponse clone() => IpcResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IpcResponse copyWith(void Function(IpcResponse) updates) => super.copyWith((message) => updates(message as IpcResponse)) as IpcResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IpcResponse create() => IpcResponse._();
  @$core.override
  IpcResponse createEmptyInstance() => create();
  static $pb.PbList<IpcResponse> createRepeated() => $pb.PbList<IpcResponse>();
  @$core.pragma('dart2js:noInline')
  static IpcResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<IpcResponse>(create);
  static IpcResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get response => $_getSZ(0);
  @$pb.TagNumber(1)
  set response($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasResponse() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponse() => $_clearField(1);
}


const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
