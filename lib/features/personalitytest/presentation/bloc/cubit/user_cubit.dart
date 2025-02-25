
import 'package:career_canvas/features/personalitytest/data/models/personalityTestModel.dart';
import 'package:career_canvas/features/personalitytest/domain/usecases/PersonalityTestUseCase.dart';
import 'package:career_canvas/features/personalitytest/presentation/bloc/cubit/PersonalityTestState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalityTestCubit extends Cubit<PersonalityTestState> {
  final GetPersonalityTestUseCase _getPersonalityTestUseCase;
  PersonalityTest? _personalityTest;

  PersonalityTestCubit(this._getPersonalityTestUseCase) : super(PersonalityTestLoading());

  PersonalityTest? get personalityTest => _personalityTest;

  Future<void> loadPersonalityTest(String token) async {
    emit(PersonalityTestLoading());
    final result = await _getPersonalityTestUseCase.execute(token);
    if (result != null) {
      _personalityTest = result;
    } else {
      emit(PersonalityTestError('Failed to load personality test.'));
    }
  }
}
