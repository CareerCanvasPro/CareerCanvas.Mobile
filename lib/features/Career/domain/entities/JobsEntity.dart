abstract class JobsResponseEntity {
  JobsDataEntity? get data;
  String? get message;
}

abstract class JobsDataEntity {
  int? get count;
  List<JobsEntity>? get jobs;
}

abstract class JobsEntity {
  String? get id;
  String? get companyLogo;
  DateTime? get createdAt;
  DateTime? get deadline;
  String? get location;
  String? get locationType;
  String? get organization;
  String? get position;
  String? get type;
  DateTime? get updatedAt;
  String? get url;
}
