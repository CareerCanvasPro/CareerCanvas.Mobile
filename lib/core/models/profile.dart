// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:career_canvas/core/models/education.dart';
import 'package:career_canvas/core/models/experiance.dart';
import 'package:career_canvas/core/models/resume.dart';
import 'package:career_canvas/features/Career/data/models/CoursesModel.dart';
import 'package:career_canvas/features/Career/data/models/JobsModel.dart';
import 'package:flutter/foundation.dart';

class PersonalityTestResult {
  double TF;
  double SN;
  double EI;
  double JP;
  String type;
  PersonalityTestResult({
    required this.TF,
    required this.SN,
    required this.EI,
    required this.JP,
    required this.type,
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
    debugPrint("PersonalityTestResult fromMap: $map");
    return PersonalityTestResult(
      TF: double.tryParse(map['testResultTF'].toString()) ?? 0,
      SN: double.tryParse(map['testResultSN'].toString()) ?? 0,
      EI: double.tryParse(map['testResultEI'].toString()) ?? 0,
      JP: double.tryParse(map['testResultJP'].toString()) ?? 0,
      type: map['type'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonalityTestResult.fromJson(String source) =>
      PersonalityTestResult.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PersonalityTestResult(TF: $TF, SN: $SN, EI: $EI, JP: $JP, type: $type)';
  }
}

class KeyVal {
  String id;
  String name;
  KeyVal({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory KeyVal.fromMap(Map<String, dynamic> map) {
    return KeyVal(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory KeyVal.fromJson(String source) =>
      KeyVal.fromMap(json.decode(source) as Map<String, dynamic>);
}

class UserProfileData {
  int following;
  int followers;
  String address;
  String email;
  String name;
  String aboutMe;
  bool isPrivate;
  int coins;
  List<Experiance> occupation;
  List<Education> education;
  List<KeyVal> languages;
  String profilePicture;
  List<KeyVal> skills;
  List<KeyVal> interests;
  String phone;
  List<Resume> resumes;
  List<KeyVal> goals;
  List<CoursesModel> savedCourses;
  List<JobsModel> savedJobs;
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
    required this.profilePicture,
    required this.skills,
    required this.interests,
    required this.phone,
    required this.resumes,
    required this.isPrivate,
    this.coins = 0,
    required this.goals,
    this.personalityTestResult,
    required this.savedCourses,
    required this.savedJobs,
  });

  factory UserProfileData.fromMap(Map<String, dynamic> map) {
    debugPrint(map["personality"].toString());
    return UserProfileData(
      isPrivate: map['isPrivate'] as bool? ?? false,
      following: (map['following'] as int?) ?? 0,
      followers: (map['followers'] as int?) ?? 0,
      savedCourses: List<CoursesModel>.from(
        (map['savedCourses'] as List<dynamic>? ?? []).map<CoursesModel>(
          (x) => CoursesModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      savedJobs: List<JobsModel>.from(
        (map['savedJobs'] as List<dynamic>? ?? []).map<JobsModel>(
          (x) => JobsModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      goals: List<KeyVal>.from(
        (map['goals'] as List<dynamic>? ?? []).map<KeyVal>(
          (x) => KeyVal.fromMap(x as Map<String, dynamic>),
        ),
      ),
      coins: (map['coins'] as int?) ?? 0,
      address: (map['address'] as String?) ?? "",
      email: (map['email'] as String?) ?? "",
      name: (map['name'] as String?) ?? "",
      aboutMe: (map['aboutMe'] as String?) ?? "",
      personalityTestResult: map["personality"] != null
          ? PersonalityTestResult.fromMap(
              map["personality"] as Map<String, dynamic>)
          : null,
      occupation: List<Experiance>.from(
        (map['occupations'] as List<dynamic>? ?? []).map<Experiance>(
          (x) => Experiance.fromMap(x as Map<String, dynamic>),
        ),
      ),
      education: List<Education>.from(
        (map['educations'] as List<dynamic>? ?? []).map<Education>(
          (x) => Education.fromMap(x as Map<String, dynamic>),
        ),
      ),
      languages: List<KeyVal>.from(
        (map['languages'] as List<dynamic>? ?? []).map<KeyVal>(
          (x) => KeyVal.fromMap(x as Map<String, dynamic>),
        ),
      ),
      profilePicture: (map['profilePicture'] as String?) ?? "",
      skills: List<KeyVal>.from(
        (map['skills'] as List<dynamic>? ?? []).map<KeyVal>(
          (x) => KeyVal.fromMap(x as Map<String, dynamic>),
        ),
      ),
      interests: List<KeyVal>.from(
        (map['interests'] as List<dynamic>? ?? []).map<KeyVal>(
          (x) => KeyVal.fromMap(x as Map<String, dynamic>),
        ),
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
    return 'UserProfileData(following: $following, followers: $followers, address: $address, email: $email, name: $name, aboutMe: $aboutMe, occupation: $occupation, education: $education, languages: $languages, profilePicture: $profilePicture, skills: $skills, phone: $phone, resumes: $resumes, goals: $goals, personalityTestResult: $personalityTestResult)';
  }
}
