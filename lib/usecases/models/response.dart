import 'dart:convert';

import 'package:braille_translator/usecases/models/data.dart';

class Response {
  int status;
  String message;
  Data data;
  Response({
    required this.status,
    required this.message,
    required this.data,
  });
  
  

  Response copyWith({
    int? status,
    String? message,
    Data? data,
  }) {
    return Response(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'data': data.toMap(),
    };
  }

  factory Response.fromMap(Map<String, dynamic> map) {
    return Response(
      status: map['status']?.toInt() ?? 0,
      message: map['message'] ?? '',
      data: Data.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Response.fromJson(String source) => Response.fromMap(json.decode(source));

  @override
  String toString() => 'Response(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Response &&
      other.status == status &&
      other.message == message &&
      other.data == data;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}
