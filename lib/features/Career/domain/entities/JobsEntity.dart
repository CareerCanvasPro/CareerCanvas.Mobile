abstract class JobsResponseEntity {
  JobsDataEntity? get data;
  String? get message;
}

abstract class JobsDataEntity {
  int? get count;
  List<JobsEntity>? get jobs;
}

abstract class JobsEntity {
  String? get location;
  String? get currency;
  List<String>? get personalityTypes;
  int? get salary;
  int? get salaryMax;
  String? get companyLogo;
  String? get jobId;
  List<String>? get goals;
  int? get deadline;
  List<String>? get fields;
  String? get organization;
  String? get locationType;
  String? get salaryTime;
  String? get position;
  String? get type;
}
