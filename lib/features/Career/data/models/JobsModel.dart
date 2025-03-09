// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:career_canvas/features/Career/domain/entities/JobsEntity.dart';
import 'package:flutter/foundation.dart';

class JobsModel extends JobsEntity {
  @override
  final String location;
  @override
  final String currency;
  @override
  final List<String> personalityTypes;
  @override
  final int salary;
  @override
  final int? salaryMax;
  @override
  final String companyLogo;
  @override
  final String jobId;
  @override
  final List<String> goals;
  @override
  final int deadline;
  @override
  final List<String> fields;
  @override
  final String organization;
  @override
  final String locationType;
  @override
  final String salaryTime;
  @override
  final String position;
  @override
  final String type;

  JobsModel({
    required this.location,
    required this.currency,
    required this.personalityTypes,
    required this.salary,
    required this.salaryMax,
    required this.companyLogo,
    required this.jobId,
    required this.goals,
    required this.deadline,
    required this.fields,
    required this.organization,
    required this.locationType,
    required this.salaryTime,
    required this.position,
    required this.type,
  });

  JobsModel copyWith({
    String? location,
    String? currency,
    List<String>? personalityTypes,
    int? salary,
    int? salaryMax,
    String? companyLogo,
    String? jobId,
    List<String>? goals,
    int? deadline,
    List<String>? fields,
    String? organization,
    String? locationType,
    String? salaryTime,
    String? position,
    String? type,
  }) {
    return JobsModel(
      location: location ?? this.location,
      currency: currency ?? this.currency,
      personalityTypes: personalityTypes ?? this.personalityTypes,
      salary: salary ?? this.salary,
      salaryMax: salaryMax ?? this.salaryMax,
      companyLogo: companyLogo ?? this.companyLogo,
      jobId: jobId ?? this.jobId,
      goals: goals ?? this.goals,
      deadline: deadline ?? this.deadline,
      fields: fields ?? this.fields,
      organization: organization ?? this.organization,
      locationType: locationType ?? this.locationType,
      salaryTime: salaryTime ?? this.salaryTime,
      position: position ?? this.position,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'location': location,
      'currency': currency,
      'personalityTypes': personalityTypes,
      'salary': salary,
      'salaryMax': salaryMax,
      'companyLogo': companyLogo,
      'jobId': jobId,
      'goals': goals,
      'deadline': deadline,
      'fields': fields,
      'organization': organization,
      'locationType': locationType,
      'salaryTime': salaryTime,
      'position': position,
      'type': type,
    };
  }

  factory JobsModel.fromMap(Map<String, dynamic> map) {
    return JobsModel(
      location: map['location'] as String? ?? '',
      currency: map['currency'] as String? ?? '',
      personalityTypes: List<String>.from((map['personalityTypes'] as List)),
      salary: map['salary'] as int,
      salaryMax: map['salaryMax'] != null ? map['salaryMax'] as int : null,
      companyLogo: map['companyLogo'] as String? ?? '',
      jobId: map['jobId'] as String? ?? '',
      goals: List<String>.from((map['goals'] as List)),
      deadline: map['deadline'] as int,
      fields: List<String>.from((map['fields'] as List)),
      organization: map['organization'] as String? ?? '',
      locationType: map['locationType'] as String? ?? '',
      salaryTime: map['salaryTime'] as String? ?? '',
      position: map['position'] as String? ?? '',
      type: map['type'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory JobsModel.fromJson(String source) =>
      JobsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'JobsModel(location: $location, currency: $currency, personalityTypes: $personalityTypes, salary: $salary, salaryMax: $salaryMax, companyLogo: $companyLogo, jobId: $jobId, goals: $goals, deadline: $deadline, fields: $fields, organization: $organization, locationType: $locationType, salaryTime: $salaryTime, position: $position, type: $type)';
  }

  @override
  bool operator ==(covariant JobsModel other) {
    if (identical(this, other)) return true;

    return other.location == location &&
        other.currency == currency &&
        listEquals(other.personalityTypes, personalityTypes) &&
        other.salary == salary &&
        other.salaryMax == salaryMax &&
        other.companyLogo == companyLogo &&
        other.jobId == jobId &&
        listEquals(other.goals, goals) &&
        other.deadline == deadline &&
        listEquals(other.fields, fields) &&
        other.organization == organization &&
        other.locationType == locationType &&
        other.salaryTime == salaryTime &&
        other.position == position &&
        other.type == type;
  }

  @override
  int get hashCode {
    return location.hashCode ^
        currency.hashCode ^
        personalityTypes.hashCode ^
        salary.hashCode ^
        salaryMax.hashCode ^
        companyLogo.hashCode ^
        jobId.hashCode ^
        goals.hashCode ^
        deadline.hashCode ^
        fields.hashCode ^
        organization.hashCode ^
        locationType.hashCode ^
        salaryTime.hashCode ^
        position.hashCode ^
        type.hashCode;
  }
}

class JobDataModel extends JobsDataEntity {
  @override
  final int? count;
  @override
  final List<JobsModel>? jobs;

  JobDataModel({this.count, this.jobs});

  JobDataModel.fromJson(Map<String, dynamic> json)
      : count = json['count'],
        jobs = json['jobs'] != null
            ? (json['jobs'] as List).map((v) => JobsModel.fromMap(v)).toList()
            : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['count'] = count;
    if (jobs != null) {
      data['jobs'] = jobs!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  JobDataModel copyWith({int? count, List<JobsModel>? jobs}) {
    return JobDataModel(
      count: count ?? this.count,
      jobs: jobs ?? this.jobs,
    );
  }

  @override
  String toString() {
    return 'JobDataModel(count: $count, jobs: $jobs)';
  }
}

class JobsResponseModel extends JobsResponseEntity {
  @override
  final JobDataModel? data;
  @override
  final String? message;

  JobsResponseModel({this.data, this.message});

  JobsResponseModel.fromJson(Map<String, dynamic> json)
      : data =
            json['data'] != null ? JobDataModel.fromJson(json['data']) : null,
        message = json['message'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }

  JobsResponseModel copyWith({JobDataModel? data, String? message}) {
    return JobsResponseModel(
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }

  @override
  String toString() {
    return 'JobsResponseModel(data: $data, message: $message)';
  }
}
