// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class UploadedFile {
  UploadedFile({
    required this.name,
    required this.size,
    required this.key,
    required this.type,
    required this.url,
    required this.id,
  });
  String id;
  String name;
  int size;
  String key;
  String type;
  String url;

  factory UploadedFile.fromJson(String str) =>
      UploadedFile.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UploadedFile.fromMap(Map<String, dynamic> json) => UploadedFile(
        id: json["id"] ?? UniqueKey().toString(),
        key: json["key"],
        name: json["name"],
        size: json["size"],
        type: json["type"],
        url: json["url"] ?? "",
      );

  Map<String, dynamic> toMap({bool isSaving = false}) {
    var data = {
      "key": key,
      "name": name,
      "size": size,
      "type": type,
    };
    if (isSaving) {
      data["id"] = id;
      data["url"] = url;
    }
    return data;
  }
}
