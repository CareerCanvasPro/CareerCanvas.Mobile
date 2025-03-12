import 'package:career_canvas/features/Career/data/models/CoursesModel.dart';
import 'package:career_canvas/features/Career/domain/repository/CoursesRepository.dart';
import 'package:get/get.dart';

class CoursesController extends GetxController {
  CoursesRepository coursesRepository;
  CoursesController(this.coursesRepository);
  var isLoading = false.obs;
  var isLoadingGolsBasedCourses = false.obs;
  var errorMessage = ''.obs;
  var courses = Rxn<CoursesResponseModel>();
  var coursesGoals = Rxn<CoursesResponseModel>();

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

  Future<void> getCoursesBasedOnGoals() async {
    isLoadingGolsBasedCourses.value = true;
    final result = await coursesRepository.getCoursesBasedOnGoals();
    if (result != null) {
      coursesGoals.value = result;
    }
    isLoadingGolsBasedCourses.value = false;
  }

  Future<void> searchCourses(String query) async {
    isLoading.value = true;
    final result = await coursesRepository.searchCourses(query);
    if (result != null) {
      courses.value = result;
      errorMessage.value = '';
    } else {
      errorMessage.value = 'Failed to load courses.';
    }
    isLoading.value = false;
  }
}
