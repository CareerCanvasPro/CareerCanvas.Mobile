abstract class PersonalityTestState {}

class PersonalityTestLoading extends PersonalityTestState {}

class PersonalityTestError extends PersonalityTestState {
  final String errorMessage;
  PersonalityTestError(this.errorMessage);
}