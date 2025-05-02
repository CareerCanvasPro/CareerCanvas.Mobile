// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:career_canvas/core/models/certificateFile.dart';

class UploadEducation {
  List<Education> educations;
  UploadEducation({
    required this.educations,
  });

  UploadEducation copyWith({
    List<Education>? educations,
  }) {
    return UploadEducation(
      educations: educations ?? this.educations,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'educations': educations.map((x) => x.toMap()).toList(),
    };
  }

  factory UploadEducation.fromMap(Map<String, dynamic> map) {
    return UploadEducation(
      educations: List<Education>.from(
        (map['educations'] as List<int>).map<Education>(
          (x) => Education.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UploadEducation.fromJson(String source) =>
      UploadEducation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UploadEducation(educations: $educations)';

  @override
  bool operator ==(covariant UploadEducation other) {
    if (identical(this, other)) return true;

    return listEquals(other.educations, educations);
  }

  @override
  int get hashCode => educations.hashCode;
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
  String id;
  String achievements;
  UploadedFile? certificate;
  String field;
  DateTime? graduationDate;
  String institute;
  bool isCurrent;
  Education({
    required this.id,
    required this.achievements,
    this.certificate,
    required this.field,
    this.graduationDate,
    required this.institute,
    required this.isCurrent,
  });

  Education copyWith({
    String? id,
    String? achievements,
    UploadedFile? certificate,
    String? field,
    DateTime? graduationDate,
    String? institute,
    bool? isCurrent,
  }) {
    return Education(
      id: id ?? this.id,
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
      'graduationDate': graduationDate?.toIso8601String(),
      'institute': institute,
      'isCurrent': isCurrent,
    };
  }

  factory Education.fromMap(Map<String, dynamic> map) {
    return Education(
      id: map['id'] as String,
      achievements: map['achievements'] as String,
      certificate: map['certificate'] != null
          ? UploadedFile.fromMap(map['certificate'] as Map<String, dynamic>)
          : null,
      field: map['field'] as String,
      graduationDate: map['graduationDate'] != null
          ? DateTime.tryParse(map['graduationDate'] as String)?.toLocal()
          : null,
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
