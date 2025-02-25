abstract class PersonalityTestEntity {
  DataEntity? get data;
  String? get message;
}


abstract class DataEntity {
  int? get count;
  List<QuestionsEntity>? get questions;
}

abstract class QuestionsEntity {
  String? get category;
  int? get score;
  String? get question;
  String? get questionID;
}

