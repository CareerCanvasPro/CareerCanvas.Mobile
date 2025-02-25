

import 'package:career_canvas/features/personalitytest/domain/entities/personalityTestEntity.dart';

class PersonalityTest extends PersonalityTestEntity {
  @override
  final Data? data;
  @override
  final String? message;

  PersonalityTest({this.data, this.message});

  PersonalityTest.fromJson(Map<String, dynamic> json)
      : data = json['data'] != null ? Data.fromJson(json['data']) : null,
        message = json['message'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }

  PersonalityTest copyWith({Data? data, String? message}) {
    return PersonalityTest(
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }

  @override
  String toString() {
    return 'PersonalityTest(data: $data, message: $message)';
  }
}


class Data extends DataEntity {
  @override
  final int? count;
  @override
  final List<Questions>? questions;

  Data({this.count, this.questions});

  Data.fromJson(Map<String, dynamic> json)
      : count = json['count'],
        questions = json['questions'] != null
            ? (json['questions'] as List)
                .map((v) => Questions.fromJson(v))
                .toList()
            : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['count'] = count;
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Data copyWith({int? count, List<Questions>? questions}) {
    return Data(
      count: count ?? this.count,
      questions: questions ?? this.questions,
    );
  }

  @override
  String toString() {
    return 'Data(count: $count, questions: $questions)';
  }
}


class Questions extends QuestionsEntity {
  @override
  final String? category;
  @override
  final int? score;
  @override
  final String? question;
  @override
  final String? questionID;
  int? selectedOption;

  Questions({this.category, this.score, this.question, this.questionID,this.selectedOption});

  Questions.fromJson(Map<String, dynamic> json)
      : category = json['category'],
        score = json['score'],
        question = json['question'],
        questionID = json['questionID'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['category'] = category;
    data['score'] = score;
    data['question'] = question;
    data['questionID'] = questionID;
    return data;
  }

  Questions copyWith({String? category, int? score, String? question, String? questionID, int? selectedOption}) {
    return Questions(
      category: category ?? this.category,
      score: score ?? this.score,
      question: question ?? this.question,
      questionID: questionID ?? this.questionID,
      selectedOption: selectedOption ?? this.selectedOption,
    );
  }

  @override
  String toString() {
    return 'Questions(category: $category, score: $score, question: $question, questionID: $questionID)';
  }
}
