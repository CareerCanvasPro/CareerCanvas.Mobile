import 'package:career_canvas/features/personalitytest/data/models/personalityTestModel.dart';

abstract class PersonalityTestRepository {
  Future<PersonalityTest?> fetchPersonalityTest(String token);
}