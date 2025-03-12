// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:career_canvas/core/models/education.dart';
import 'package:career_canvas/core/models/experiance.dart';
import 'package:career_canvas/core/models/resume.dart';

class PersonalityTestResult {
  double TF;
  double SN;
  double EI;
  double JP;
  PersonalityTestResult({
    required this.TF,
    required this.SN,
    required this.EI,
    required this.JP,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'TF': TF,
      'SN': SN,
      'EI': EI,
      'JP': JP,
    };
  }

  factory PersonalityTestResult.fromMap(Map<String, dynamic> map) {
    return PersonalityTestResult(
      TF: double.tryParse(map['TF'].toString()) ?? 0,
      SN: double.tryParse(map['SN'].toString()) ?? 0,
      EI: double.tryParse(map['EI'].toString()) ?? 0,
      JP: double.tryParse(map['JP'].toString()) ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonalityTestResult.fromJson(String source) =>
      PersonalityTestResult.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PersonalityTestResult(TF: $TF, SN: $SN, EI: $EI, JP: $JP)';
  }
}

class UserProfileData {
  int following;
  int followers;
  String address;
  String email;
  String name;
  String aboutMe;
  int coins;
  List<Experiance> occupation;
  List<Education> education;
  List<String> languages;
  int points;
  String profilePicture;
  List<String> skills;
  String phone;
  List<Resume> resumes;
  String personalityTestStatus;
  String? personalityType;
  List<String> goals;
  PersonalityTestResult? personalityTestResult;
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
    this.personalityTestStatus = 'pending',
    this.personalityType,
    this.coins = 0,
    required this.goals,
    this.personalityTestResult,
  });

  factory UserProfileData.fromMap(Map<String, dynamic> map) {
    return UserProfileData(
      following: (map['following'] as int?) ?? 0,
      followers: (map['followers'] as int?) ?? 0,
      goals: (map['goals'] as List<dynamic>?)
              ?.map<String>((e) => e as String)
              .toList() ??
          [],
      coins: (map['coins'] as int?) ?? 0,
      address: (map['address'] as String?) ?? "",
      email: (map['email'] as String?) ?? "",
      name: (map['name'] as String?) ?? "",
      aboutMe: (map['aboutMe'] as String?) ?? "",
      personalityTestResult: map["personalityTestResult"] != null
          ? PersonalityTestResult.fromMap(
              map["personalityTestResult"] as Map<String, dynamic>)
          : PersonalityTestResult(TF: 0, SN: 0, EI: 0, JP: 0),
      personalityTestStatus:
          (map['personalityTestStatus'] as String?) ?? "pending",
      personalityType: map['personalityType'] as String?,
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

  // String toJson() => json.encode(toMap());

  factory UserProfileData.fromJson(String source) =>
      UserProfileData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserProfileData(following: $following, followers: $followers, address: $address, email: $email, name: $name, aboutMe: $aboutMe, occupation: $occupation, education: $education, languages: $languages, points: $points, profilePicture: $profilePicture, skills: $skills, phone: $phone, resumes: $resumes, personalityTestStatus: $personalityTestStatus, personalityType: $personalityType)';
  }
}
