import 'package:career_canvas/core/Dependencies/setupDependencies.dart';
import 'package:career_canvas/features/Career/data/models/CoursesModel.dart';
import 'package:career_canvas/features/Career/domain/repository/CoursesRepository.dart';
import 'package:career_canvas/src/profile/presentation/getx/controllers/user_profile_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  Future<void> saveCourse(CoursesModel course) async {
    if (courses.value?.data?.courses
            ?.where((element) => element.id == course.id)
            .toList()
            .isNotEmpty ??
        false) {
      courses.value?.data?.courses
          ?.where((element) => element.id == course.id)
          .toList()
          .first
          .isSaved = true;
      courses.refresh();
    }
    bool result = await coursesRepository.saveCourse(course);
    if (result == false) {
      if (courses.value?.data?.courses
              ?.where((element) => element.id == course.id)
              .toList()
              .isNotEmpty ??
          false) {
        courses.value?.data?.courses
            ?.where((element) => element.id == course.id)
            .toList()
            .first
            .isSaved = false;
        courses.refresh();
      }
      Fluttertoast.showToast(
        msg: "Failed to save course.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 14.0,
      );
    } else {
      await getIt<UserProfileController>().getUserProfile();
    }
    debugPrint(result.toString());
  }

  Future<void> unsaveCourse(CoursesModel course) async {
    if (courses.value?.data?.courses
            ?.where((element) => element.id == course.id)
            .toList()
            .isNotEmpty ??
        false) {
      courses.value?.data?.courses
          ?.where((element) => element.id == course.id)
          .toList()
          .first
          .isSaved = false;
      courses.refresh();
    }
    bool result = await coursesRepository.unsaveCourse(course);
    if (result == false) {
      if (courses.value?.data?.courses
              ?.where((element) => element.id == course.id)
              .toList()
              .isNotEmpty ??
          false) {
        courses.value?.data?.courses
            ?.where((element) => element.id == course.id)
            .toList()
            .first
            .isSaved = true;
        courses.refresh();
      }
      Fluttertoast.showToast(
        msg: "Failed to unsave course.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 14.0,
      );
    } else {
      await getIt<UserProfileController>().getUserProfile();
    }
    debugPrint(result.toString());
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
