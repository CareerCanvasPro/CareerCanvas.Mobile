// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:career_canvas/features/Career/domain/entities/JobsEntity.dart';

class JobsModel extends JobsEntity {
  @override
  String? id;
  @override
  String? companyLogo;
  @override
  DateTime? createdAt;
  @override
  DateTime? deadline;
  @override
  String? location;
  @override
  String? locationType;
  @override
  String? organization;
  @override
  String? position;
  @override
  String? type;
  @override
  DateTime? updatedAt;
  @override
  String? url;

  JobsModel({
    this.id,
    this.companyLogo,
    this.createdAt,
    this.deadline,
    this.location,
    this.locationType,
    this.organization,
    this.position,
    this.type,
    this.updatedAt,
    this.url,
  });

  factory JobsModel.fromJson(String str) => JobsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory JobsModel.fromMap(Map<String, dynamic> json) => JobsModel(
        id: json["id"],
        companyLogo: json["companyLogo"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        deadline:
            json["deadline"] == null ? null : DateTime.parse(json["deadline"]),
        location: json["location"],
        locationType: json["locationType"],
        organization: json["organization"],
        position: json["position"],
        type: json["type"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "companyLogo": companyLogo,
        "createdAt": createdAt?.toIso8601String(),
        "deadline": deadline?.toIso8601String(),
        "location": location,
        "locationType": locationType,
        "organization": organization,
        "position": position,
        "type": type,
        "updatedAt": updatedAt?.toIso8601String(),
        "url": url,
      };
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
