// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UploadLanguage {
  List<String> languages;

  UploadLanguage({
    required this.languages,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'languages': languages,
    };
  }

  factory UploadLanguage.fromMap(Map<String, dynamic> map) {
    return UploadLanguage(
      languages: List<String>.from((map['languages'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory UploadLanguage.fromJson(String source) =>
      UploadLanguage.fromMap(json.decode(source) as Map<String, dynamic>);
}
