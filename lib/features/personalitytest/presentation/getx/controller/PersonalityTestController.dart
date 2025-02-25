

import 'package:career_canvas/features/personalitytest/data/models/personalityTestModel.dart';
import 'package:career_canvas/features/personalitytest/domain/repositories/PersonalityTestRepository.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class PersonalityTestController extends GetxController {
  final PersonalityTestRepository _repository;
  
  PersonalityTestController(this._repository);
  
  var personalityTest = Rxn<PersonalityTest>();
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> loadPersonalityTest(String token) async {
    isLoading.value = true;
    final result = await _repository.fetchPersonalityTest(token);
    if (result != null) {
      personalityTest.value = result;
      errorMessage.value = '';
    } else {
      errorMessage.value = 'Failed to load personality test.';
    }
    isLoading.value = false;
  }
}