// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Onboardingone {
  String profilePicture;
  String name;
  String phone;
  String address;
  String email;
  Onboardingone({
    required this.profilePicture,
    required this.name,
    required this.phone,
    required this.address,
    required this.email,
  });

  Onboardingone copyWith({
    String? profilePicture,
    String? name,
    String? phone,
    String? address,
    String? email,
  }) {
    return Onboardingone(
      profilePicture: profilePicture ?? this.profilePicture,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'profilePicture': profilePicture,
      'name': name,
      'phone': phone,
      'address': address,
      'email': email,
    };
  }

  factory Onboardingone.fromMap(Map<String, dynamic> map) {
    return Onboardingone(
      profilePicture: map['profilePicture'] as String,
      name: map['name'] as String,
      phone: map['phone'] as String,
      address: map['address'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Onboardingone.fromJson(String source) =>
      Onboardingone.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Onboardingone(profilePicture: $profilePicture, name: $name, phone: $phone, address: $address, email: $email)';
  }

  @override
  bool operator ==(covariant Onboardingone other) {
    if (identical(this, other)) return true;

    return other.profilePicture == profilePicture &&
        other.name == name &&
        other.phone == phone &&
        other.address == address &&
        other.email == email;
  }

  @override
  int get hashCode {
    return profilePicture.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        address.hashCode ^
        email.hashCode;
  }
}
