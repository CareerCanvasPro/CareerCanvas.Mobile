
import 'package:career_canvas/features/personalitytest/data/models/personalityTestModel.dart';
import 'package:career_canvas/features/personalitytest/domain/repositories/PersonalityTestRepository.dart';

abstract class PersonalityTestUseCase {
  Future<PersonalityTest?> execute(String token);
}

class GetPersonalityTestUseCase implements PersonalityTestUseCase {
  final PersonalityTestRepository repository;

  GetPersonalityTestUseCase(this.repository);

  @override
  Future<PersonalityTest?> execute(String token) async {
    return await repository.fetchPersonalityTest(token);
  }
}