// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Resume {
  String id;
  String key;
  String name;
  int size;
  String type;
  DateTime createdAt;
  DateTime updatedAt;
  String url;

  Resume({
    required this.id,
    required this.key,
    required this.name,
    required this.size,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.url,
  });

  factory Resume.fromJson(String str) => Resume.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Resume.fromMap(Map<String, dynamic> json) => Resume(
        id: json["id"],
        key: json["key"],
        name: json["name"],
        size: json["size"] ?? 0,
        type: json["type"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        url: json["url"] ?? "",
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "key": key,
        "name": name,
        "size": size,
        "type": type,
      };
}
