// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Resume {
  String name;
  DateTime uploadedAt;
  int size;
  String type;
  String url;
  Resume({
    required this.name,
    required this.uploadedAt,
    required this.size,
    required this.type,
    required this.url,
  });

  Resume copyWith({
    String? name,
    DateTime? uploadedAt,
    int? size,
    String? type,
    String? url,
  }) {
    return Resume(
      name: name ?? this.name,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      size: size ?? this.size,
      type: type ?? this.type,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'uploadedAt': uploadedAt.millisecondsSinceEpoch,
      'size': size,
      'type': type,
      'url': url,
    };
  }

  factory Resume.fromMap(Map<String, dynamic> map) {
    return Resume(
      name: map['name'] as String,
      uploadedAt: DateTime.fromMillisecondsSinceEpoch(map['uploadedAt'] as int),
      size: map['size'] as int,
      type: map['type'] as String,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Resume.fromJson(String source) =>
      Resume.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Resume(name: $name, uploadedAt: $uploadedAt, size: $size, type: $type, url: $url)';
  }

  @override
  bool operator ==(covariant Resume other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.uploadedAt == uploadedAt &&
        other.size == size &&
        other.type == type &&
        other.url == url;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        uploadedAt.hashCode ^
        size.hashCode ^
        type.hashCode ^
        url.hashCode;
  }
}
