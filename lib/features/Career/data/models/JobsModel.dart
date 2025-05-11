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
  String? sourceName;
  @override
  JobLocationType? locationType;
  @override
  String? organization;
  @override
  String? position;
  @override
  JobType? type;
  @override
  DateTime? updatedAt;
  @override
  String? url;

  @override
  bool isSaved;

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
    this.sourceName,
    required this.isSaved,
  });

  factory JobsModel.fromJson(String str) => JobsModel.fromMap(json.decode(str));

  factory JobsModel.fromMap(Map<String, dynamic> json) {
    return JobsModel(
      id: json["id"],
      companyLogo: json["companyLogo"] ?? "",
      createdAt: json["createdAt"] == null
          ? null
          : DateTime.parse(json["createdAt"]).toLocal(),
      deadline: json["deadline"] == null
          ? null
          : DateTime.parse(json["deadline"]).toLocal(),
      location: json["location"],
      locationType: json["locationType"] != null
          ? JobLocationType.fromString(json["locationType"])
          : null,
      organization: json["organization"],
      sourceName: json["sourceName"],
      position: json["position"],
      isSaved: json["isSaved"] ?? false,
      type: json["type"] != null ? JobType.fromString(json["type"]) : null,
      updatedAt: json["updatedAt"] == null
          ? null
          : DateTime.parse(json["updatedAt"]).toLocal(),
      url: json["url"],
    );
  }

  @override
  String toString() {
    return 'JobsModel(id: $id, companyLogo: $companyLogo, createdAt: $createdAt, deadline: $deadline, location: $location, locationType: $locationType, organization: $organization, position: $position, type: $type, updatedAt: $updatedAt, url: $url)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'companyLogo': companyLogo,
      'createdAt': createdAt?.toIso8601String(),
      'deadline': deadline?.toIso8601String(),
      'location': location,
      'sourceName': sourceName,
      'locationType': locationType?.name,
      'organization': organization,
      'position': position,
      'type': type?.name,
      'updatedAt': updatedAt?.toIso8601String(),
      'url': url,
      'isSaved': isSaved,
    };
  }

  String toJson() => json.encode(toMap());
}

class JobDataModel extends JobsDataEntity {
  @override
  final int? count;
  @override
  final List<JobsModel>? jobs;

  JobDataModel({this.count, this.jobs});

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
      'jobs': jobs?.map((x) => x.toMap()).toList(),
    };
  }

  factory JobDataModel.fromMap(Map<String, dynamic> map) {
    return JobDataModel(
      count: map['count'] != null ? map['count'] as int : null,
      jobs: map['jobs'] != null
          ? List<JobsModel>.from(
              (map['jobs'] as List? ?? []).map<JobsModel?>(
                (x) => JobsModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory JobDataModel.fromJson(String source) =>
      JobDataModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class JobsResponseModel extends JobsResponseEntity {
  @override
  final JobDataModel? data;
  @override
  final String? message;

  JobsResponseModel({this.data, this.message});

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data?.toMap(),
      'message': message,
    };
  }

  factory JobsResponseModel.fromMap(Map<String, dynamic> map) {
    return JobsResponseModel(
      data: map['data'] != null
          ? JobDataModel.fromMap(map['data'] as Map<String, dynamic>)
          : null,
      message: map['message'] != null ? map['message'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory JobsResponseModel.fromJson(String source) =>
      JobsResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
