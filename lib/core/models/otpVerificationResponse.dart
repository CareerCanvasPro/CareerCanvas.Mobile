// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Otpverificationresponse {
  String accessToken;
  bool isNewUser;
  String email;
  DateTime expiresAt;
  Otpverificationresponse({
    required this.accessToken,
    required this.isNewUser,
    required this.email,
    required this.expiresAt,
  });

  Otpverificationresponse copyWith({
    String? accessToken,
    bool? isNewUser,
    String? email,
    DateTime? expiresAt,
  }) {
    return Otpverificationresponse(
      accessToken: accessToken ?? this.accessToken,
      isNewUser: isNewUser ?? this.isNewUser,
      email: email ?? this.email,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'isNewUser': isNewUser,
      'email': email,
      'expiresAt': expiresAt.millisecondsSinceEpoch,
    };
  }

  factory Otpverificationresponse.fromMap(Map<String, dynamic> map) {
    return Otpverificationresponse(
      accessToken: map['accessToken'] as String,
      isNewUser: map['isNewUser'] as bool,
      email: map['email'] as String,
      expiresAt: DateTime.fromMillisecondsSinceEpoch(map['expiresAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Otpverificationresponse.fromJson(String source) =>
      Otpverificationresponse.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Otpverificationresponse(accessToken: $accessToken, isNewUser: $isNewUser, email: $email, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(covariant Otpverificationresponse other) {
    if (identical(this, other)) return true;

    return other.accessToken == accessToken &&
        other.isNewUser == isNewUser &&
        other.email == email &&
        other.expiresAt == expiresAt;
  }

  @override
  int get hashCode {
    return accessToken.hashCode ^
        isNewUser.hashCode ^
        email.hashCode ^
        expiresAt.hashCode;
  }
}
