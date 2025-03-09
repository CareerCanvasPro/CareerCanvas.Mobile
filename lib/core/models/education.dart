// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:career_canvas/core/models/certificateFile.dart';

class UploadEducation {
  List<Education> education;
  UploadEducation({
    required this.education,
  });

  UploadEducation copyWith({
    List<Education>? education,
  }) {
    return UploadEducation(
      education: education ?? this.education,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'education': education.map((x) => x.toMap()).toList(),
    };
  }

  factory UploadEducation.fromMap(Map<String, dynamic> map) {
    return UploadEducation(
      education: List<Education>.from(
        (map['education'] as List<int>).map<Education>(
          (x) => Education.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UploadEducation.fromJson(String source) =>
      UploadEducation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UploadEducation(education: $education)';

  @override
  bool operator ==(covariant UploadEducation other) {
    if (identical(this, other)) return true;

    return listEquals(other.education, education);
  }

  @override
  int get hashCode => education.hashCode;
}

///
/// String achievements;
///
/// UploadedFile? certificate;
///
/// String field;
///
/// int? graduationDate;
///
/// String institute;
///
/// bool isCurrent;
///
class Education {
  String achievements;
  UploadedFile? certificate;
  String field;
  int? graduationDate;
  String institute;
  bool isCurrent;
  Education({
    required this.achievements,
    this.certificate,
    required this.field,
    this.graduationDate,
    required this.institute,
    required this.isCurrent,
  });

  Education copyWith({
    String? achievements,
    UploadedFile? certificate,
    String? field,
    int? graduationDate,
    String? institute,
    bool? isCurrent,
  }) {
    return Education(
      achievements: achievements ?? this.achievements,
      certificate: certificate ?? this.certificate,
      field: field ?? this.field,
      graduationDate: graduationDate ?? this.graduationDate,
      institute: institute ?? this.institute,
      isCurrent: isCurrent ?? this.isCurrent,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'achievements': achievements,
      'certificate': certificate?.toMap(),
      'field': field,
      'graduationDate': graduationDate,
      'institute': institute,
      'isCurrent': isCurrent,
    };
  }

  factory Education.fromMap(Map<String, dynamic> map) {
    return Education(
      achievements: map['achievements'] as String,
      certificate: map['certificate'] != null
          ? UploadedFile.fromMap(map['certificate'] as Map<String, dynamic>)
          : null,
      field: map['field'] as String,
      graduationDate:
          map['graduationDate'] != null ? map['graduationDate'] as int : null,
      institute: map['institute'] as String,
      isCurrent: map['isCurrent'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Education.fromJson(String source) =>
      Education.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Education(achievements: $achievements, certificate: $certificate, field: $field, graduationDate: $graduationDate, institute: $institute, isCurrent: $isCurrent)';
  }

  @override
  bool operator ==(covariant Education other) {
    if (identical(this, other)) return true;

    return other.achievements == achievements &&
        other.certificate == certificate &&
        other.field == field &&
        other.graduationDate == graduationDate &&
        other.institute == institute &&
        other.isCurrent == isCurrent;
  }

  @override
  int get hashCode {
    return achievements.hashCode ^
        certificate.hashCode ^
        field.hashCode ^
        graduationDate.hashCode ^
        institute.hashCode ^
        isCurrent.hashCode;
  }
}
