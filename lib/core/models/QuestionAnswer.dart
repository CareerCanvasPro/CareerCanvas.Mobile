import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Answer {
  int answer;
  String questionID;
  Answer({
    required this.answer,
    required this.questionID,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'answer': answer,
      'questionID': questionID,
    };
  }

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      answer: map['answer'] as int,
      questionID: map['questionID'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Answer.fromJson(String source) =>
      Answer.fromMap(json.decode(source) as Map<String, dynamic>);
}

class QuestionAnswer {
  String userID;
  List<Answer> result;
  QuestionAnswer({
    required this.userID,
    required this.result,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userID': userID,
      'result': result.map((x) => x.toMap()).toList(),
    };
  }

  factory QuestionAnswer.fromMap(Map<String, dynamic> map) {
    return QuestionAnswer(
      userID: map['userID'] as String,
      result: List<Answer>.from(
        (map['result'] as List<int>).map<Answer>(
          (x) => Answer.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionAnswer.fromJson(String source) =>
      QuestionAnswer.fromMap(json.decode(source) as Map<String, dynamic>);
}
