import 'package:career_canvas/features/Career/data/models/CoursesModel.dart';
import 'package:career_canvas/features/Career/domain/repository/CoursesRepository.dart';
import 'package:get/get.dart';

class GlobalSearchController extends GetxController {
  CoursesRepository coursesRepository;
  GlobalSearchController(this.coursesRepository);
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final courses = Rxn<CoursesResponseModel>();

  final searchQuery = ''.obs;

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

  Future<void> searchCourses(String query) async {
    isLoading.value = true;
    searchQuery.value = query;
    var result;
    if (query.isNotEmpty) {
      result = await coursesRepository.searchCourses(query);
    } else {
      result = await coursesRepository.getCoursesRecomendation();
    }
    if (result != null) {
      courses.value = result;
      errorMessage.value = '';
    } else {
      errorMessage.value = 'Failed to load courses.';
    }
    isLoading.value = false;
  }
}
