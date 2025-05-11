// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  bool isSaved;

  CoursesModel({
    required this.id,
    required this.createdAt,
    required this.description,
    required this.name,
    required this.sourceName,
    required this.sourceUrl,
    required this.updatedAt,
    required this.tags,
    required this.isSaved,
  });

  factory CoursesModel.fromJson(String str) =>
      CoursesModel.fromMap(json.decode(str));

  factory CoursesModel.fromMap(Map<String, dynamic> json) => CoursesModel(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]).toLocal(),
        description: json["description"] ?? "",
        name: json["name"] ?? "",
        sourceName: json["sourceName"] ?? "",
        sourceUrl: json["sourceUrl"] ?? "",
        updatedAt: DateTime.parse(json["updatedAt"]).toLocal(),
        isSaved: json["isSaved"] ?? false,
        tags: json["tags"] == null
            ? []
            : List<TagModel>.from(
                json["tags"]!.map(
                  (x) => TagModel.fromMap(x),
                ),
              ),
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'description': description,
      'name': name,
      'sourceName': sourceName,
      'sourceUrl': sourceUrl,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'tags': tags.map((x) => x.toMap()).toList(),
      'isSaved': isSaved,
    };
  }

  String toJson() => json.encode(toMap());
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
      'courses': courses?.map((x) => x.toMap()).toList(),
    };
  }

  factory CoursesDataModel.fromMap(Map<String, dynamic> map) {
    return CoursesDataModel(
      count: map['count'] != null ? map['count'] as int : null,
      courses: map['courses'] != null
          ? List<CoursesModel>.from(
              (map['courses'] as List<int>).map<CoursesModel?>(
                (x) => CoursesModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CoursesDataModel.fromJson(String source) =>
      CoursesDataModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class CoursesResponseModel extends CoursesResponseEntity {
  @override
  final CoursesDataModel? data;
  @override
  final String? message;

  CoursesResponseModel({this.data, this.message});

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data?.toMap(),
      'message': message,
    };
  }

  factory CoursesResponseModel.fromMap(Map<String, dynamic> map) {
    return CoursesResponseModel(
      data: map['data'] != null
          ? CoursesDataModel.fromMap(map['data'] as Map<String, dynamic>)
          : null,
      message: map['message'] != null ? map['message'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CoursesResponseModel.fromJson(String source) =>
      CoursesResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
