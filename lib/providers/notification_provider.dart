// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/main.dart';

class VeilNetNotification {
  final String id;
  final DateTime created_at;
  final String title;
  final String type;
  final String message;
  VeilNetNotification({
    required this.id,
    required this.created_at,
    required this.title,
    required this.type,
    required this.message,
  });

  VeilNetNotification copyWith({
    String? id,
    DateTime? created_at,
    String? title,
    String? type,
    String? message,
  }) {
    return VeilNetNotification(
      id: id ?? this.id,
      created_at: created_at ?? this.created_at,
      title: title ?? this.title,
      type: type ?? this.type,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': created_at.toUtc().toIso8601String(),
      'title': title,
      'type': type,
      'message': message,
    };
  }

  factory VeilNetNotification.fromMap(Map<String, dynamic> map) {
    return VeilNetNotification(
      id: map['id'] as String,
      created_at: DateTime.parse(map['created_at'] as String),
      title: map['title'] as String,
      type: map['type'] as String,
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VeilNetNotification.fromJson(String source) =>
      VeilNetNotification.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Notification(id: $id, created_at: $created_at, title: $title, type: $type, message: $message)';
  }

  @override
  bool operator ==(covariant VeilNetNotification other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.created_at == created_at &&
        other.title == title &&
        other.type == type &&
        other.message == message;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        created_at.hashCode ^
        title.hashCode ^
        type.hashCode ^
        message.hashCode;
  }
}

final notificationProvider = StreamProvider<List<VeilNetNotification>>((ref) async* {
  // Create a stream from the 'notifications' table
  final stream = supabase
      .from('notifications')
      .stream(primaryKey: ['id'])
      .map((event) => event.map((row) => VeilNetNotification.fromMap(row)).toList());

  // Yield the stream
  yield* stream;
});
