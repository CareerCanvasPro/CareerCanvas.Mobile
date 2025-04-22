// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class UploadInterest {
  List<String> interests;
  UploadInterest({
    required this.interests,
  });

  UploadInterest copyWith({
    List<String>? interests,
  }) {
    return UploadInterest(
      interests: interests ?? this.interests,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'interests': interests,
    };
  }

  factory UploadInterest.fromMap(Map<String, dynamic> map) {
    return UploadInterest(
      interests: List<String>.from(
        (map['interests'] as List<String>),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UploadInterest.fromJson(String source) =>
      UploadInterest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UploadInterest(interests: $interests)';

  @override
  bool operator ==(covariant UploadInterest other) {
    if (identical(this, other)) return true;

    return listEquals(other.interests, interests);
  }

  @override
  int get hashCode => interests.hashCode;
}
