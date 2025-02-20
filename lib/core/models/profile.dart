// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:career_canvas/core/models/education.dart';
import 'package:career_canvas/core/models/experiance.dart';
import 'package:career_canvas/core/models/resume.dart';

class UserProfileData {
  int following;
  int followers;
  String address;
  String email;
  String name;
  String aboutMe;
  List<Experiance> occupation;
  List<Education> education;
  List<String> languages;
  int points;
  String profilePicture;
  List<String> skills;
  String phone;
  List<Resume> resumes;
  UserProfileData({
    required this.following,
    required this.followers,
    required this.address,
    required this.email,
    required this.name,
    required this.aboutMe,
    required this.occupation,
    required this.education,
    required this.languages,
    required this.points,
    required this.profilePicture,
    required this.skills,
    required this.phone,
    required this.resumes,
  });

  UserProfileData copyWith({
    int? following,
    int? followers,
    String? address,
    String? email,
    String? name,
    String? aboutMe,
    List<Experiance>? occupation,
    List<Education>? education,
    List<String>? languages,
    int? points,
    String? profilePicture,
    List<String>? skills,
    String? phone,
    List<Resume>? resumes,
  }) {
    return UserProfileData(
      following: following ?? this.following,
      followers: followers ?? this.followers,
      address: address ?? this.address,
      email: email ?? this.email,
      name: name ?? this.name,
      aboutMe: aboutMe ?? this.aboutMe,
      occupation: occupation ?? this.occupation,
      education: education ?? this.education,
      languages: languages ?? this.languages,
      points: points ?? this.points,
      profilePicture: profilePicture ?? this.profilePicture,
      skills: skills ?? this.skills,
      phone: phone ?? this.phone,
      resumes: resumes ?? this.resumes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'following': following,
      'followers': followers,
      'address': address,
      'email': email,
      'name': name,
      'aboutMe': aboutMe,
      'occupation': occupation.map((x) => x.toMap()).toList(),
      'education': education.map((x) => x.toMap()).toList(),
      'languages': languages,
      'points': points,
      'profilePicture': profilePicture,
      'skills': skills,
      'phone': phone,
      'resumes': resumes.map((x) => x.toMap()).toList(),
    };
  }

  factory UserProfileData.fromMap(Map<String, dynamic> map) {
    return UserProfileData(
      following: (map['following'] as int?) ?? 0,
      followers: (map['followers'] as int?) ?? 0,
      address: (map['address'] as String?) ?? "",
      email: (map['email'] as String?) ?? "",
      name: (map['name'] as String?) ?? "",
      aboutMe: (map['aboutMe'] as String?) ?? "",
      occupation: List<Experiance>.from(
        (map['occupation'] as List<dynamic>? ?? []).map<Experiance>(
          (x) => Experiance.fromMap(x as Map<String, dynamic>),
        ),
      ),
      education: List<Education>.from(
        (map['education'] as List<dynamic>? ?? []).map<Education>(
          (x) => Education.fromMap(x as Map<String, dynamic>),
        ),
      ),
      languages: List<String>.from(
        (map['languages'] as List<dynamic>? ?? []).map((x) => x as String),
      ),
      points: (map['points'] as int?) ?? 0,
      profilePicture: (map['profilePicture'] as String?) ?? "",
      skills: List<String>.from(
        (map['skills'] as List<dynamic>? ?? []).map((x) => x as String),
      ),
      phone: (map['phone'] as String?) ?? "",
      resumes: List<Resume>.from(
        (map['resumes'] as List<dynamic>? ?? []).map<Resume>(
          (x) => Resume.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfileData.fromJson(String source) =>
      UserProfileData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserProfileData(following: $following, followers: $followers, address: $address, email: $email, name: $name, aboutMe: $aboutMe, occupation: $occupation, education: $education, languages: $languages, points: $points, profilePicture: $profilePicture, skills: $skills, phone: $phone, resumes: $resumes)';
  }

  @override
  bool operator ==(covariant UserProfileData other) {
    if (identical(this, other)) return true;

    return other.following == following &&
        other.followers == followers &&
        other.address == address &&
        other.email == email &&
        other.name == name &&
        other.aboutMe == aboutMe &&
        listEquals(other.occupation, occupation) &&
        listEquals(other.education, education) &&
        listEquals(other.languages, languages) &&
        other.points == points &&
        other.profilePicture == profilePicture &&
        listEquals(other.skills, skills) &&
        other.phone == phone &&
        listEquals(other.resumes, resumes);
  }

  @override
  int get hashCode {
    return following.hashCode ^
        followers.hashCode ^
        address.hashCode ^
        email.hashCode ^
        name.hashCode ^
        aboutMe.hashCode ^
        occupation.hashCode ^
        education.hashCode ^
        languages.hashCode ^
        points.hashCode ^
        profilePicture.hashCode ^
        skills.hashCode ^
        phone.hashCode ^
        resumes.hashCode;
  }
}
