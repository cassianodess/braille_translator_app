import 'dart:convert';

class Data {
  String raw_text;
  String braille;
  Data({
    required this.raw_text,
    required this.braille,
  });

  Data copyWith({
    String? raw_text,
    String? braille,
  }) {
    return Data(
      raw_text: raw_text ?? this.raw_text,
      braille: braille ?? this.braille,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'raw_text': raw_text,
      'braille': braille,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      raw_text: map['raw_text'] as String,
      braille: map['braille'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) => Data.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Data(raw_text: $raw_text, braille: $braille)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Data &&
      other.raw_text == raw_text &&
      other.braille == braille;
  }

  @override
  int get hashCode => raw_text.hashCode ^ braille.hashCode;
}
