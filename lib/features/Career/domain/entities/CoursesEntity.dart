abstract class CoursesResponseEntity {
  CoursesDataEntity? get data;
  String? get message;
}

abstract class CoursesDataEntity {
  int? get count;
  List<CoursesEntity>? get courses;
}

abstract class CoursesEntity {
  String? get id;
  DateTime? get createdAt;
  String? get description;
  String? get name;
  String? get sourceName;
  String? get sourceUrl;
  DateTime? get updatedAt;
  List<TagEntity>? get tags;
  bool get isSaved;
}

abstract class TagEntity {
  String? get id;
  String? get name;
}
