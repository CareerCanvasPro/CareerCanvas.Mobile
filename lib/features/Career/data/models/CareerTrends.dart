// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CareerTrendResponse {
  CareerTrend? data;
  String? message;

  CareerTrendResponse({
    this.data,
    this.message,
  });

  factory CareerTrendResponse.fromMap(Map<String, dynamic> map) {
    return CareerTrendResponse(
      data: map['data'] != null
          ? CareerTrend.fromMap(map['data'] as Map<String, dynamic>)
          : null,
      message: map['message'] != null ? map['message'] as String : null,
    );
  }

  factory CareerTrendResponse.fromJson(String source) =>
      CareerTrendResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}

class CareerTrend {
  List<Career> careerTrends;

  CareerTrend({
    required this.careerTrends,
  });

  factory CareerTrend.fromMap(Map<String, dynamic> map) {
    return CareerTrend(
      careerTrends: map['careerTrends'] != null
          ? List<Career>.from(
              (map['careerTrends'] as List).map<Career?>(
                (x) => Career.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }

  factory CareerTrend.fromJson(String source) =>
      CareerTrend.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Career {
  String description;
  String name;
  String image;
  String id;

  Career({
    required this.description,
    required this.name,
    required this.image,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'name': name,
      'image': image,
      'id': id,
    };
  }

  factory Career.fromMap(Map<String, dynamic> map) {
    return Career(
      description: map['description'] as String? ?? '',
      name: map['name'] as String? ?? '',
      image: map['image'] as String? ?? '',
      id: map['id'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Career.fromJson(String source) =>
      Career.fromMap(json.decode(source) as Map<String, dynamic>);
}
