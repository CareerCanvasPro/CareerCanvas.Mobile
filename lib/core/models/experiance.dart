// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class UploadExperiance {
  List<Experiance> occupation;
  UploadExperiance({
    required this.occupation,
  });

  UploadExperiance copyWith({
    List<Experiance>? occupation,
  }) {
    return UploadExperiance(
      occupation: occupation ?? this.occupation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'occupation': occupation.map((x) => x.toMap()).toList(),
    };
  }

  factory UploadExperiance.fromMap(Map<String, dynamic> map) {
    return UploadExperiance(
      occupation: List<Experiance>.from(
        (map['occupation'] as List<int>).map<Experiance>(
          (x) => Experiance.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UploadExperiance.fromJson(String source) =>
      UploadExperiance.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UploadExperiance(occupation: $occupation)';

  @override
  bool operator ==(covariant UploadExperiance other) {
    if (identical(this, other)) return true;

    return listEquals(other.occupation, occupation);
  }

  @override
  int get hashCode => occupation.hashCode;
}

class Experiance {
  String designation;
  int from;
  bool isCurrent;
  String organization;
  int? to;
  Experiance({
    required this.designation,
    required this.from,
    required this.isCurrent,
    required this.organization,
    this.to,
  });

  Experiance copyWith({
    String? designation,
    int? from,
    bool? isCurrent,
    String? organization,
    int? to,
  }) {
    return Experiance(
      designation: designation ?? this.designation,
      from: from ?? this.from,
      isCurrent: isCurrent ?? this.isCurrent,
      organization: organization ?? this.organization,
      to: to ?? this.to,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = <String, dynamic>{
      'designation': designation,
      'from': from,
      'isCurrent': isCurrent,
      'organization': organization,
    };
    if (to != null) {
      data['to'] = to;
    }
    return data;
  }

  factory Experiance.fromMap(Map<String, dynamic> map) {
    return Experiance(
      designation: map['designation'] as String,
      from: map['from'] as int,
      isCurrent: map['isCurrent'] as bool,
      organization: map['organization'] as String,
      to: map['to'] != null ? map['to'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Experiance.fromJson(String source) =>
      Experiance.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Experiance(designation: $designation, from: $from, isCurrent: $isCurrent, organization: $organization, to: $to)';
  }

  @override
  bool operator ==(covariant Experiance other) {
    if (identical(this, other)) return true;

    return other.designation == designation &&
        other.from == from &&
        other.isCurrent == isCurrent &&
        other.organization == organization &&
        other.to == to;
  }

  @override
  int get hashCode {
    return designation.hashCode ^
        from.hashCode ^
        isCurrent.hashCode ^
        organization.hashCode ^
        to.hashCode;
  }
}
