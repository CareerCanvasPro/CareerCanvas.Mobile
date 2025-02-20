// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UploadedFile {
  String name;
  int size;
  String url;
  String type;
  int uploadedAt;
  UploadedFile({
    required this.name,
    required this.size,
    required this.url,
    required this.type,
    required this.uploadedAt,
  });

  UploadedFile copyWith({
    String? name,
    int? size,
    String? url,
    String? type,
    int? uploadedAt,
  }) {
    return UploadedFile(
      name: name ?? this.name,
      size: size ?? this.size,
      url: url ?? this.url,
      type: type ?? this.type,
      uploadedAt: uploadedAt ?? this.uploadedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'size': size,
      'url': url,
      'type': type,
      'uploadedAt': uploadedAt,
    };
  }

  factory UploadedFile.fromMap(Map<String, dynamic> map) {
    return UploadedFile(
      name: map['name'] as String,
      size: map['size'] as int,
      url: map['url'] as String,
      type: map['type'] as String,
      uploadedAt: map['uploadedAt'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UploadedFile.fromJson(String source) =>
      UploadedFile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UploadedFile(name: $name, size: $size, url: $url, type: $type, uploadedAt: $uploadedAt)';
  }

  @override
  bool operator ==(covariant UploadedFile other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.size == size &&
        other.url == url &&
        other.type == type &&
        other.uploadedAt == uploadedAt;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        size.hashCode ^
        url.hashCode ^
        type.hashCode ^
        uploadedAt.hashCode;
  }
}
