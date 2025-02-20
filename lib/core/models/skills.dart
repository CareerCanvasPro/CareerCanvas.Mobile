// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class UploadSkills {
  List<String> skills;
  UploadSkills({
    required this.skills,
  });

  UploadSkills copyWith({
    List<String>? skills,
  }) {
    return UploadSkills(
      skills: skills ?? this.skills,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'skills': skills,
    };
  }

  factory UploadSkills.fromMap(Map<String, dynamic> map) {
    return UploadSkills(
      skills: List<String>.from(
        (map['skills'] as List<String>),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UploadSkills.fromJson(String source) =>
      UploadSkills.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UploadSkills(skills: $skills)';

  @override
  bool operator ==(covariant UploadSkills other) {
    if (identical(this, other)) return true;

    return listEquals(other.skills, skills);
  }

  @override
  int get hashCode => skills.hashCode;
}
