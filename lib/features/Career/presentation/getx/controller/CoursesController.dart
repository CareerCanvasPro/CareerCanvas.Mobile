import 'package:career_canvas/features/Career/data/models/CoursesModel.dart';
import 'package:career_canvas/features/Career/domain/repository/CoursesRepository.dart';
import 'package:get/get.dart';

class CoursesController extends GetxController {
  CoursesRepository coursesRepository;
  CoursesController(this.coursesRepository);
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var courses = Rxn<CoursesResponseModel>();

  Future<void> getCoursesRecomendation() async {
    isLoading.value = true;
    final result = await coursesRepository.getCoursesRecomendation();
    if (result != null) {
      courses.value = result;
      errorMessage.value = '';
    } else {
      errorMessage.value = 'Failed to load courses.';
    }
    isLoading.value = false;
  }
}
