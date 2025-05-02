// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class UploadExperiance {
  List<Experiance> occupations;
  UploadExperiance({
    required this.occupations,
  });

  UploadExperiance copyWith({
    List<Experiance>? occupations,
  }) {
    return UploadExperiance(
      occupations: occupations ?? this.occupations,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'occupations': occupations.map((x) => x.toMap()).toList(),
    };
  }

  factory UploadExperiance.fromMap(Map<String, dynamic> map) {
    return UploadExperiance(
      occupations: List<Experiance>.from(
        (map['occupations'] as List<int>).map<Experiance>(
          (x) => Experiance.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UploadExperiance.fromJson(String source) =>
      UploadExperiance.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UploadExperiance(occupations: $occupations)';

  @override
  bool operator ==(covariant UploadExperiance other) {
    if (identical(this, other)) return true;

    return listEquals(other.occupations, occupations);
  }

  @override
  int get hashCode => occupations.hashCode;
}

class Experiance {
  String id;
  String designation;
  DateTime startDate;
  bool isCurrent;
  String organization;
  DateTime? endDate;
  Experiance({
    required this.id,
    required this.designation,
    required this.startDate,
    required this.isCurrent,
    required this.organization,
    this.endDate,
  });

  Experiance copyWith({
    String? id,
    String? designation,
    DateTime? startDate,
    bool? isCurrent,
    String? organization,
    DateTime? endDate,
  }) {
    return Experiance(
      id: id ?? this.id,
      designation: designation ?? this.designation,
      startDate: startDate ?? this.startDate,
      isCurrent: isCurrent ?? this.isCurrent,
      organization: organization ?? this.organization,
      endDate: endDate ?? this.endDate,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = <String, dynamic>{
      'designation': designation,
      'startDate': startDate.toIso8601String(),
      'isCurrent': isCurrent,
      'organization': organization,
    };
    if (endDate != null) {
      data['endDate'] = endDate!.toIso8601String();
    }
    return data;
  }

  factory Experiance.fromMap(Map<String, dynamic> map) {
    return Experiance(
      id: map['id'] as String,
      designation: map['designation'] as String,
      startDate: DateTime.parse(map['startDate'] as String).toLocal(),
      isCurrent: map['isCurrent'] as bool,
      organization: map['organization'] as String,
      endDate: map['endDate'] != null
          ? DateTime.parse(map['endDate'] as String).toLocal()
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Experiance.fromJson(String source) =>
      Experiance.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Experiance(designation: $designation, startDate: $startDate, isCurrent: $isCurrent, organization: $organization, endDate: $endDate)';
  }

  @override
  bool operator ==(covariant Experiance other) {
    if (identical(this, other)) return true;

    return other.designation == designation &&
        other.startDate == startDate &&
        other.isCurrent == isCurrent &&
        other.organization == organization &&
        other.endDate == endDate;
  }

  @override
  int get hashCode {
    return designation.hashCode ^
        startDate.hashCode ^
        isCurrent.hashCode ^
        organization.hashCode ^
        endDate.hashCode;
  }
}
