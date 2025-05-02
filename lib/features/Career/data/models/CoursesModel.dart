import 'dart:convert';

import 'package:career_canvas/features/Career/domain/entities/CoursesEntity.dart';

class CoursesModel extends CoursesEntity {
  String id;
  DateTime createdAt;
  String description;
  String name;
  String sourceName;
  String sourceUrl;
  DateTime updatedAt;
  List<TagModel> tags;

  CoursesModel({
    required this.id,
    required this.createdAt,
    required this.description,
    required this.name,
    required this.sourceName,
    required this.sourceUrl,
    required this.updatedAt,
    required this.tags,
  });

  factory CoursesModel.fromJson(String str) =>
      CoursesModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CoursesModel.fromMap(Map<String, dynamic> json) => CoursesModel(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]).toLocal(),
        description: json["description"] ?? "",
        name: json["name"] ?? "",
        sourceName: json["sourceName"] ?? "",
        sourceUrl: json["sourceUrl"] ?? "",
        updatedAt: DateTime.parse(json["updatedAt"]).toLocal(),
        tags: json["tags"] == null
            ? []
            : List<TagModel>.from(
                json["tags"]!.map((x) => TagModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "description": description,
        "name": name,
        "sourceName": sourceName,
        "sourceUrl": sourceUrl,
        "updatedAt": updatedAt.toIso8601String(),
        "tags": List<dynamic>.from(tags.map((x) => x.toMap())),
      };
}

class TagModel extends TagEntity {
  String? id;
  String? name;

  TagModel({
    this.id,
    this.name,
  });

  factory TagModel.fromJson(String str) => TagModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TagModel.fromMap(Map<String, dynamic> json) => TagModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}

class CoursesDataModel extends CoursesDataEntity {
  @override
  final int? count;
  @override
  final List<CoursesModel>? courses;

  CoursesDataModel({this.count, this.courses});

  CoursesDataModel.fromJson(Map<String, dynamic> json)
      : count = json['count'],
        courses = json['courses'] != null
            ? (json['courses'] as List)
                .map((v) => CoursesModel.fromJson(v))
                .toList()
            : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['count'] = count;
    if (courses != null) {
      data['courses'] = courses!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  CoursesDataModel copyWith({int? count, List<CoursesModel>? courses}) {
    return CoursesDataModel(
      count: count ?? this.count,
      courses: courses ?? this.courses,
    );
  }

  @override
  String toString() {
    return 'CoursesDataModel(count: $count, courses: $courses)';
  }
}

class CoursesResponseModel extends CoursesResponseEntity {
  @override
  final CoursesDataModel? data;
  @override
  final String? message;

  CoursesResponseModel({this.data, this.message});

  CoursesResponseModel.fromJson(Map<String, dynamic> json)
      : data = json['data'] != null
            ? CoursesDataModel.fromJson(json['data'])
            : null,
        message = json['message'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }

  CoursesResponseModel copyWith({CoursesDataModel? data, String? message}) {
    return CoursesResponseModel(
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }

  @override
  String toString() {
    return 'CoursesResponseModel(data: $data, message: $message)';
  }
}
