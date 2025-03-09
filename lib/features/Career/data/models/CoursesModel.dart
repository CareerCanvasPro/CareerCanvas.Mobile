import 'package:career_canvas/features/Career/domain/entities/CoursesEntity.dart';

class CoursesModel extends CoursesEntity {
  @override
  final String currency;
  @override
  final double rating;
  @override
  final String topic;
  @override
  final String sourceName;
  @override
  final List<String> goals;
  @override
  final int studentCount;
  @override
  final String name;
  @override
  final String image;
  @override
  final String level;
  @override
  final String courseId;
  @override
  final double price;
  @override
  final int duration;
  @override
  final int? ratingCount;
  @override
  final String sourceUrl;
  @override
  final List<String> authors;

  CoursesModel({
    required this.currency,
    required this.topic,
    required this.sourceName,
    required this.goals,
    required this.name,
    required this.image,
    required this.level,
    required this.sourceUrl,
    required this.courseId,
    required this.authors,
    this.studentCount = 0,
    this.rating = 0,
    this.price = 0,
    this.duration = 0,
    this.ratingCount = 0,
  });

  CoursesModel.fromJson(Map<String, dynamic> json)
      : currency = json['currency'] ?? '',
        rating = double.tryParse(json['rating'].toString()) ?? 0,
        topic = json['topic'] ?? '',
        sourceName = json['sourceName'] ?? '',
        goals = json['goals'] != null
            ? (json['goals'] as List).map((v) => v.toString()).toList()
            : [],
        studentCount = json['studentCount'] as int? ?? 0,
        name = json['name'] ?? '',
        image = json['image'] ?? '',
        level = json['level'] ?? '',
        courseId = json['courseId'] ?? '',
        price = double.tryParse(json['price'].toString()) ?? 0,
        duration = json['duration'] as int? ?? 0,
        ratingCount = json['ratingCount'] as int? ?? 0,
        sourceUrl = json['sourceUrl'] ?? '',
        authors = json['authors'] != null
            ? (json['authors'] as List).map((v) => v.toString()).toList()
            : [];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['currency'] = currency;
    data['rating'] = rating;
    data['topic'] = topic;
    data['sourceName'] = sourceName;
    data['goals'] = goals.map((v) => v).toList();

    data['studentCount'] = studentCount;
    data['name'] = name;
    data['image'] = image;
    data['level'] = level;
    data['courseId'] = courseId;
    data['price'] = price;
    data['duration'] = duration;
    data['ratingCount'] = ratingCount;
    data['sourceUrl'] = sourceUrl;
    data['authors'] = authors.map((v) => v).toList();

    return data;
  }

  CoursesModel copyWith({
    String? currency,
    double? rating,
    String? topic,
    String? sourceName,
    List<String>? goals,
    int? studentCount,
    String? name,
    String? image,
    String? level,
    String? courseId,
    double? price,
    int? duration,
    int? ratingCount,
    String? sourceUrl,
    List<String>? authors,
  }) {
    return CoursesModel(
      currency: currency ?? this.currency,
      rating: rating ?? this.rating,
      topic: topic ?? this.topic,
      sourceName: sourceName ?? this.sourceName,
      goals: goals ?? this.goals,
      studentCount: studentCount ?? this.studentCount,
      name: name ?? this.name,
      image: image ?? this.image,
      level: level ?? this.level,
      courseId: courseId ?? this.courseId,
      price: price ?? this.price,
      duration: duration ?? this.duration,
      ratingCount: ratingCount ?? this.ratingCount,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      authors: authors ?? this.authors,
    );
  }

  @override
  String toString() {
    return 'CoursesModel(currency: $currency, rating: $rating, topic: $topic, sourceName: $sourceName, goals: $goals, studentCount: $studentCount, name: $name, image: $image, level: $level, courseId: $courseId, price: $price, duration: $duration, ratingCount: $ratingCount, sourceUrl: $sourceUrl, authors: $authors)';
  }

  @override
  int get hashCode {
    return currency.hashCode ^
        rating.hashCode ^
        topic.hashCode ^
        sourceName.hashCode ^
        goals.hashCode ^
        studentCount.hashCode ^
        name.hashCode ^
        image.hashCode ^
        level.hashCode ^
        courseId.hashCode ^
        price.hashCode ^
        duration.hashCode ^
        ratingCount.hashCode ^
        sourceUrl.hashCode ^
        authors.hashCode;
  }
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
