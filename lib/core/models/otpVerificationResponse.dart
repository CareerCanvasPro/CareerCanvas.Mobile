// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Otpverificationresponse {
  String accessToken;
  bool isNewUser;
  String email;

  Otpverificationresponse({
    required this.accessToken,
    required this.isNewUser,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'isNewUser': isNewUser,
      'email': email,
    };
  }

  factory Otpverificationresponse.fromMap(Map<String, dynamic> map) {
    return Otpverificationresponse(
      accessToken: map['accessToken'] as String,
      isNewUser: map['isNewUser'] as bool,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Otpverificationresponse.fromJson(String source) =>
      Otpverificationresponse.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
