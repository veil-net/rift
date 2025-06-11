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

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use messageTypeDescriptor instead')
const MessageType$json = {
  '1': 'MessageType',
  '2': [
    {'1': 'RTC_OFFER', '2': 0},
    {'1': 'RTC_ANSWER', '2': 1},
    {'1': 'RTC_SYNC', '2': 2},
    {'1': 'CANDIDATE_OFFER', '2': 3},
    {'1': 'CANDIDATE_ANSWER', '2': 4},
    {'1': 'ARP_REQUEST', '2': 5},
    {'1': 'ARP_RESPONSE', '2': 6},
    {'1': 'ARP_UPDATE', '2': 7},
    {'1': 'STREAM_REQUEST', '2': 8},
    {'1': 'STREAM_RESPONSE', '2': 9},
    {'1': 'STREAM_UPDATE', '2': 10},
    {'1': 'DATA', '2': 11},
    {'1': 'CMD_ADD_LOCAL_NETWORK', '2': 12},
    {'1': 'CMD_REMOVE_LOCAL_NETWORK', '2': 13},
    {'1': 'CMD_ACK', '2': 14},
    {'1': 'CMD_NACK', '2': 15},
    {'1': 'IPC_START', '2': 16},
    {'1': 'IPC_STOP', '2': 17},
    {'1': 'IPC_ACK', '2': 18},
    {'1': 'IPC_NACK', '2': 19},
  ],
};

/// Descriptor for `MessageType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List messageTypeDescriptor = $convert.base64Decode(
    'CgtNZXNzYWdlVHlwZRINCglSVENfT0ZGRVIQABIOCgpSVENfQU5TV0VSEAESDAoIUlRDX1NZTk'
    'MQAhITCg9DQU5ESURBVEVfT0ZGRVIQAxIUChBDQU5ESURBVEVfQU5TV0VSEAQSDwoLQVJQX1JF'
    'UVVFU1QQBRIQCgxBUlBfUkVTUE9OU0UQBhIOCgpBUlBfVVBEQVRFEAcSEgoOU1RSRUFNX1JFUV'
    'VFU1QQCBITCg9TVFJFQU1fUkVTUE9OU0UQCRIRCg1TVFJFQU1fVVBEQVRFEAoSCAoEREFUQRAL'
    'EhkKFUNNRF9BRERfTE9DQUxfTkVUV09SSxAMEhwKGENNRF9SRU1PVkVfTE9DQUxfTkVUV09SSx'
    'ANEgsKB0NNRF9BQ0sQDhIMCghDTURfTkFDSxAPEg0KCUlQQ19TVEFSVBAQEgwKCElQQ19TVE9Q'
    'EBESCwoHSVBDX0FDSxASEgwKCElQQ19OQUNLEBM=');

@$core.Deprecated('Use headerDescriptor instead')
const Header$json = {
  '1': 'Header',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.veilnet.MessageType', '10': 'type'},
    {'1': 'version', '3': 2, '4': 1, '5': 13, '10': 'version'},
    {'1': 'length', '3': 3, '4': 1, '5': 13, '10': 'length'},
  ],
};

/// Descriptor for `Header`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List headerDescriptor = $convert.base64Decode(
    'CgZIZWFkZXISKAoEdHlwZRgBIAEoDjIULnZlaWxuZXQuTWVzc2FnZVR5cGVSBHR5cGUSGAoHdm'
    'Vyc2lvbhgCIAEoDVIHdmVyc2lvbhIWCgZsZW5ndGgYAyABKA1SBmxlbmd0aA==');

@$core.Deprecated('Use rTC_OfferDescriptor instead')
const RTC_Offer$json = {
  '1': 'RTC_Offer',
  '2': [
    {'1': 'signature', '3': 1, '4': 1, '5': 9, '10': 'signature'},
    {'1': 'label', '3': 2, '4': 1, '5': 9, '10': 'label'},
    {'1': 'offer', '3': 3, '4': 1, '5': 12, '10': 'offer'},
  ],
};

/// Descriptor for `RTC_Offer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rTC_OfferDescriptor = $convert.base64Decode(
    'CglSVENfT2ZmZXISHAoJc2lnbmF0dXJlGAEgASgJUglzaWduYXR1cmUSFAoFbGFiZWwYAiABKA'
    'lSBWxhYmVsEhQKBW9mZmVyGAMgASgMUgVvZmZlcg==');

@$core.Deprecated('Use rTC_AnswerDescriptor instead')
const RTC_Answer$json = {
  '1': 'RTC_Answer',
  '2': [
    {'1': 'signature', '3': 1, '4': 1, '5': 9, '10': 'signature'},
    {'1': 'label', '3': 2, '4': 1, '5': 9, '10': 'label'},
    {'1': 'answer', '3': 3, '4': 1, '5': 12, '10': 'answer'},
  ],
};

/// Descriptor for `RTC_Answer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rTC_AnswerDescriptor = $convert.base64Decode(
    'CgpSVENfQW5zd2VyEhwKCXNpZ25hdHVyZRgBIAEoCVIJc2lnbmF0dXJlEhQKBWxhYmVsGAIgAS'
    'gJUgVsYWJlbBIWCgZhbnN3ZXIYAyABKAxSBmFuc3dlcg==');

@$core.Deprecated('Use rTC_SyncDescriptor instead')
const RTC_Sync$json = {
  '1': 'RTC_Sync',
  '2': [
    {'1': 'signature', '3': 1, '4': 1, '5': 9, '10': 'signature'},
    {'1': 'label', '3': 2, '4': 1, '5': 9, '10': 'label'},
  ],
};

/// Descriptor for `RTC_Sync`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rTC_SyncDescriptor = $convert.base64Decode(
    'CghSVENfU3luYxIcCglzaWduYXR1cmUYASABKAlSCXNpZ25hdHVyZRIUCgVsYWJlbBgCIAEoCV'
    'IFbGFiZWw=');

@$core.Deprecated('Use candidateOfferDescriptor instead')
const CandidateOffer$json = {
  '1': 'CandidateOffer',
  '2': [
    {'1': 'signature', '3': 1, '4': 1, '5': 9, '10': 'signature'},
    {'1': 'candidate', '3': 2, '4': 1, '5': 9, '10': 'candidate'},
  ],
};

/// Descriptor for `CandidateOffer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List candidateOfferDescriptor = $convert.base64Decode(
    'Cg5DYW5kaWRhdGVPZmZlchIcCglzaWduYXR1cmUYASABKAlSCXNpZ25hdHVyZRIcCgljYW5kaW'
    'RhdGUYAiABKAlSCWNhbmRpZGF0ZQ==');

@$core.Deprecated('Use candidateAnswerDescriptor instead')
const CandidateAnswer$json = {
  '1': 'CandidateAnswer',
};

/// Descriptor for `CandidateAnswer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List candidateAnswerDescriptor = $convert.base64Decode(
    'Cg9DYW5kaWRhdGVBbnN3ZXI=');

@$core.Deprecated('Use arpRequestDescriptor instead')
const ArpRequest$json = {
  '1': 'ArpRequest',
  '2': [
    {'1': 'signature', '3': 1, '4': 1, '5': 9, '10': 'signature'},
  ],
};

/// Descriptor for `ArpRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List arpRequestDescriptor = $convert.base64Decode(
    'CgpBcnBSZXF1ZXN0EhwKCXNpZ25hdHVyZRgBIAEoCVIJc2lnbmF0dXJl');

@$core.Deprecated('Use arpResponseDescriptor instead')
const ArpResponse$json = {
  '1': 'ArpResponse',
  '2': [
    {'1': 'signature', '3': 1, '4': 1, '5': 9, '10': 'signature'},
  ],
};

/// Descriptor for `ArpResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List arpResponseDescriptor = $convert.base64Decode(
    'CgtBcnBSZXNwb25zZRIcCglzaWduYXR1cmUYASABKAlSCXNpZ25hdHVyZQ==');

@$core.Deprecated('Use arpUpdateDescriptor instead')
const ArpUpdate$json = {
  '1': 'ArpUpdate',
  '2': [
    {'1': 'dst', '3': 1, '4': 1, '5': 9, '10': 'dst'},
    {'1': 'next_hop', '3': 2, '4': 1, '5': 9, '10': 'nextHop'},
  ],
};

/// Descriptor for `ArpUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List arpUpdateDescriptor = $convert.base64Decode(
    'CglBcnBVcGRhdGUSEAoDZHN0GAEgASgJUgNkc3QSGQoIbmV4dF9ob3AYAiABKAlSB25leHRIb3'
    'A=');

@$core.Deprecated('Use streamRequestDescriptor instead')
const StreamRequest$json = {
  '1': 'StreamRequest',
  '2': [
    {'1': 'ip', '3': 1, '4': 1, '5': 9, '10': 'ip'},
    {'1': 'uid', '3': 2, '4': 1, '5': 9, '10': 'uid'},
    {'1': 'prefered_region', '3': 3, '4': 1, '5': 9, '10': 'preferedRegion'},
    {'1': 'public_key', '3': 4, '4': 1, '5': 12, '10': 'publicKey'},
  ],
};

/// Descriptor for `StreamRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List streamRequestDescriptor = $convert.base64Decode(
    'Cg1TdHJlYW1SZXF1ZXN0Eg4KAmlwGAEgASgJUgJpcBIQCgN1aWQYAiABKAlSA3VpZBInCg9wcm'
    'VmZXJlZF9yZWdpb24YAyABKAlSDnByZWZlcmVkUmVnaW9uEh0KCnB1YmxpY19rZXkYBCABKAxS'
    'CXB1YmxpY0tleQ==');

@$core.Deprecated('Use streamResponseDescriptor instead')
const StreamResponse$json = {
  '1': 'StreamResponse',
  '2': [
    {'1': 'signature', '3': 1, '4': 1, '5': 9, '10': 'signature'},
    {'1': 'cipher', '3': 2, '4': 1, '5': 12, '10': 'cipher'},
    {'1': 'encrypted_stream_id', '3': 3, '4': 1, '5': 12, '10': 'encryptedStreamId'},
  ],
};

/// Descriptor for `StreamResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List streamResponseDescriptor = $convert.base64Decode(
    'Cg5TdHJlYW1SZXNwb25zZRIcCglzaWduYXR1cmUYASABKAlSCXNpZ25hdHVyZRIWCgZjaXBoZX'
    'IYAiABKAxSBmNpcGhlchIuChNlbmNyeXB0ZWRfc3RyZWFtX2lkGAMgASgMUhFlbmNyeXB0ZWRT'
    'dHJlYW1JZA==');

@$core.Deprecated('Use streamUpdateDescriptor instead')
const StreamUpdate$json = {
  '1': 'StreamUpdate',
  '2': [
    {'1': 'stream_id', '3': 2, '4': 1, '5': 9, '10': 'streamId'},
  ],
};

/// Descriptor for `StreamUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List streamUpdateDescriptor = $convert.base64Decode(
    'CgxTdHJlYW1VcGRhdGUSGwoJc3RyZWFtX2lkGAIgASgJUghzdHJlYW1JZA==');

@$core.Deprecated('Use dataDescriptor instead')
const Data$json = {
  '1': 'Data',
  '2': [
    {'1': 'dst', '3': 1, '4': 1, '5': 9, '10': 'dst'},
    {'1': 'stream_id', '3': 2, '4': 1, '5': 9, '10': 'streamId'},
    {'1': 'encrypted_data', '3': 3, '4': 1, '5': 12, '10': 'encryptedData'},
  ],
};

/// Descriptor for `Data`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dataDescriptor = $convert.base64Decode(
    'CgREYXRhEhAKA2RzdBgBIAEoCVIDZHN0EhsKCXN0cmVhbV9pZBgCIAEoCVIIc3RyZWFtSWQSJQ'
    'oOZW5jcnlwdGVkX2RhdGEYAyABKAxSDWVuY3J5cHRlZERhdGE=');

@$core.Deprecated('Use cmdResponseDescriptor instead')
const CmdResponse$json = {
  '1': 'CmdResponse',
  '2': [
    {'1': 'response', '3': 1, '4': 1, '5': 9, '10': 'response'},
  ],
};

/// Descriptor for `CmdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cmdResponseDescriptor = $convert.base64Decode(
    'CgtDbWRSZXNwb25zZRIaCghyZXNwb25zZRgBIAEoCVIIcmVzcG9uc2U=');

@$core.Deprecated('Use cmdLocalNetworkDescriptor instead')
const CmdLocalNetwork$json = {
  '1': 'CmdLocalNetwork',
  '2': [
    {'1': 'subnet', '3': 1, '4': 1, '5': 9, '10': 'subnet'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `CmdLocalNetwork`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cmdLocalNetworkDescriptor = $convert.base64Decode(
    'Cg9DbWRMb2NhbE5ldHdvcmsSFgoGc3VibmV0GAEgASgJUgZzdWJuZXQSFwoHdXNlcl9pZBgCIA'
    'EoCVIGdXNlcklk');

@$core.Deprecated('Use ipcStartDescriptor instead')
const IpcStart$json = {
  '1': 'IpcStart',
  '2': [
    {'1': 'api_base_url', '3': 1, '4': 1, '5': 9, '10': 'apiBaseUrl'},
    {'1': 'anchor_token', '3': 2, '4': 1, '5': 9, '10': 'anchorToken'},
    {'1': 'anchor_name', '3': 3, '4': 1, '5': 9, '10': 'anchorName'},
    {'1': 'domain_name', '3': 4, '4': 1, '5': 9, '10': 'domainName'},
    {'1': 'region', '3': 5, '4': 1, '5': 9, '10': 'region'},
    {'1': 'public', '3': 6, '4': 1, '5': 8, '10': 'public'},
  ],
};

/// Descriptor for `IpcStart`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ipcStartDescriptor = $convert.base64Decode(
    'CghJcGNTdGFydBIgCgxhcGlfYmFzZV91cmwYASABKAlSCmFwaUJhc2VVcmwSIQoMYW5jaG9yX3'
    'Rva2VuGAIgASgJUgthbmNob3JUb2tlbhIfCgthbmNob3JfbmFtZRgDIAEoCVIKYW5jaG9yTmFt'
    'ZRIfCgtkb21haW5fbmFtZRgEIAEoCVIKZG9tYWluTmFtZRIWCgZyZWdpb24YBSABKAlSBnJlZ2'
    'lvbhIWCgZwdWJsaWMYBiABKAhSBnB1YmxpYw==');

@$core.Deprecated('Use ipcStopDescriptor instead')
const IpcStop$json = {
  '1': 'IpcStop',
};

/// Descriptor for `IpcStop`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ipcStopDescriptor = $convert.base64Decode(
    'CgdJcGNTdG9w');

@$core.Deprecated('Use ipcResponseDescriptor instead')
const IpcResponse$json = {
  '1': 'IpcResponse',
  '2': [
    {'1': 'response', '3': 1, '4': 1, '5': 9, '10': 'response'},
  ],
};

/// Descriptor for `IpcResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ipcResponseDescriptor = $convert.base64Decode(
    'CgtJcGNSZXNwb25zZRIaCghyZXNwb25zZRgBIAEoCVIIcmVzcG9uc2U=');

