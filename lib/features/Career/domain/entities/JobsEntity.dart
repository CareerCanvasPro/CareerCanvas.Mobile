abstract class JobsResponseEntity {
  JobsDataEntity? get data;
  String? get message;
}

abstract class JobsDataEntity {
  int? get count;
  List<JobsEntity>? get jobs;
}

enum JobType {
  CONTRACTUAL,
  FULL_TIME,
  INTERN,
  PART_TIME;

  static JobType fromString(String value) {
    switch (value) {
      case 'CONTRACTUAL':
        return JobType.CONTRACTUAL;
      case 'FULL_TIME':
        return JobType.FULL_TIME;
      case 'INTERN':
        return JobType.INTERN;
      case 'PART_TIME':
        return JobType.PART_TIME;
      default:
        return JobType.FULL_TIME;
    }
  }

  String toString() {
    switch (this) {
      case JobType.CONTRACTUAL:
        return "Contractual";
      case JobType.FULL_TIME:
        return "Full Time";
      case JobType.INTERN:
        return "Intern";
      case JobType.PART_TIME:
        return "Part Time";
      default:
        return "Full Time";
    }
  }
}

enum JobLocationType {
  HYBRID,
  ON_SITE,
  REMOTE;

  static JobLocationType fromString(String value) {
    switch (value) {
      case 'OHYBRID':
        return JobLocationType.HYBRID;
      case 'ON_SITE':
        return JobLocationType.ON_SITE;
      case 'REMOTE':
        return JobLocationType.REMOTE;
      default:
        return JobLocationType.ON_SITE;
    }
  }

  String toString() {
    switch (this) {
      case JobLocationType.HYBRID:
        return "Hybrid";
      case JobLocationType.ON_SITE:
        return "On Site";
      case JobLocationType.REMOTE:
        return "Remote";
      default:
        return "On Site";
    }
  }
}

abstract class JobsEntity {
  String? get id;
  String? get companyLogo;
  DateTime? get createdAt;
  DateTime? get deadline;
  String? get location;
  String? get sourceName;
  JobLocationType? get locationType;
  String? get organization;
  String? get position;
  JobType? get type;
  DateTime? get updatedAt;
  String? get url;
  bool get isSaved;
}
