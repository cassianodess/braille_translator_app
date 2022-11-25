import 'dart:convert';

class Response {
  int status;
  String message;
  String data;
  
  Response({
    required this.status,
    required this.message,
    required this.data,
  });


  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'data': data,
    };
  }

  factory Response.fromMap(Map<String, dynamic> map) {
    return Response(
      status: map['status']?.toInt() ?? 0,
      message: map['message'] ?? '',
      data: map['data'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Response.fromJson(String source) => Response.fromMap(json.decode(source));
}
