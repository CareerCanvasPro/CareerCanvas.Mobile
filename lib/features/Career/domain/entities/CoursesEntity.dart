abstract class CoursesResponseEntity {
  CoursesDataEntity? get data;
  String? get message;
}

abstract class CoursesDataEntity {
  int? get count;
  List<CoursesEntity>? get courses;
}

abstract class CoursesEntity {
  String? currency;
  double? rating;
  String? topic;
  String? sourceName;
  List<String>? goals;
  int? studentCount;
  String? name;
  String? image;
  String? level;
  String? courseId;
  double? price;
  int? duration;
  int? ratingCount;
  String? sourceUrl;
  List<String>? authors;
}
