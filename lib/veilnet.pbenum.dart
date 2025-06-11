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

class MessageType extends $pb.ProtobufEnum {
  static const MessageType RTC_OFFER = MessageType._(0, _omitEnumNames ? '' : 'RTC_OFFER');
  static const MessageType RTC_ANSWER = MessageType._(1, _omitEnumNames ? '' : 'RTC_ANSWER');
  static const MessageType RTC_SYNC = MessageType._(2, _omitEnumNames ? '' : 'RTC_SYNC');
  static const MessageType CANDIDATE_OFFER = MessageType._(3, _omitEnumNames ? '' : 'CANDIDATE_OFFER');
  static const MessageType CANDIDATE_ANSWER = MessageType._(4, _omitEnumNames ? '' : 'CANDIDATE_ANSWER');
  static const MessageType ARP_REQUEST = MessageType._(5, _omitEnumNames ? '' : 'ARP_REQUEST');
  static const MessageType ARP_RESPONSE = MessageType._(6, _omitEnumNames ? '' : 'ARP_RESPONSE');
  static const MessageType ARP_UPDATE = MessageType._(7, _omitEnumNames ? '' : 'ARP_UPDATE');
  static const MessageType STREAM_REQUEST = MessageType._(8, _omitEnumNames ? '' : 'STREAM_REQUEST');
  static const MessageType STREAM_RESPONSE = MessageType._(9, _omitEnumNames ? '' : 'STREAM_RESPONSE');
  static const MessageType STREAM_UPDATE = MessageType._(10, _omitEnumNames ? '' : 'STREAM_UPDATE');
  static const MessageType DATA = MessageType._(11, _omitEnumNames ? '' : 'DATA');
  static const MessageType CMD_ADD_LOCAL_NETWORK = MessageType._(12, _omitEnumNames ? '' : 'CMD_ADD_LOCAL_NETWORK');
  static const MessageType CMD_REMOVE_LOCAL_NETWORK = MessageType._(13, _omitEnumNames ? '' : 'CMD_REMOVE_LOCAL_NETWORK');
  static const MessageType CMD_ACK = MessageType._(14, _omitEnumNames ? '' : 'CMD_ACK');
  static const MessageType CMD_NACK = MessageType._(15, _omitEnumNames ? '' : 'CMD_NACK');
  static const MessageType IPC_START = MessageType._(16, _omitEnumNames ? '' : 'IPC_START');
  static const MessageType IPC_STOP = MessageType._(17, _omitEnumNames ? '' : 'IPC_STOP');
  static const MessageType IPC_ACK = MessageType._(18, _omitEnumNames ? '' : 'IPC_ACK');
  static const MessageType IPC_NACK = MessageType._(19, _omitEnumNames ? '' : 'IPC_NACK');

  static const $core.List<MessageType> values = <MessageType> [
    RTC_OFFER,
    RTC_ANSWER,
    RTC_SYNC,
    CANDIDATE_OFFER,
    CANDIDATE_ANSWER,
    ARP_REQUEST,
    ARP_RESPONSE,
    ARP_UPDATE,
    STREAM_REQUEST,
    STREAM_RESPONSE,
    STREAM_UPDATE,
    DATA,
    CMD_ADD_LOCAL_NETWORK,
    CMD_REMOVE_LOCAL_NETWORK,
    CMD_ACK,
    CMD_NACK,
    IPC_START,
    IPC_STOP,
    IPC_ACK,
    IPC_NACK,
  ];

  static final $core.List<MessageType?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 19);
  static MessageType? valueOf($core.int value) =>  value < 0 || value >= _byValue.length ? null : _byValue[value];

  const MessageType._(super.value, super.name);
}


const $core.bool _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
