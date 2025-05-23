import 'package:career_canvas/core/Dependencies/setupDependencies.dart';
import 'package:career_canvas/features/Career/data/models/CoursesModel.dart';
import 'package:career_canvas/features/Career/data/models/JobsModel.dart';
import 'package:career_canvas/features/Career/domain/repository/CoursesRepository.dart';
import 'package:career_canvas/features/Career/domain/repository/JobsRepository.dart';
import 'package:career_canvas/src/profile/presentation/getx/controllers/user_profile_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

enum SearchState { course, job }

class GlobalSearchController extends GetxController {
  CoursesRepository coursesRepository;
  JobsRepository jobsRepository;
  GlobalSearchController(this.coursesRepository, this.jobsRepository);
  final isLoading = false.obs;
  final coursesErrorMessage = ''.obs;
  final jobsErrorMessage = ''.obs;
  final courses = Rxn<CoursesResponseModel>();
  final jobs = Rxn<JobsResponseModel>();
  final searchState = Rxn<SearchState>(SearchState.course);

  final searchQuery = ''.obs;

  Future<void> saveCourse(CoursesModel course) async {
    if (await getIt<UserProfileController>().isOnline == false) {
      Fluttertoast.showToast(
        msg: "You Are Offline",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 14.0,
      );
    } else {
      courses.value?.data?.courses
          ?.where((element) => element.id == course.id)
          .toList()
          .first
          .isSaved = true;
      courses.refresh();
      bool result = await coursesRepository.saveCourse(course);
      if (result == false) {
        courses.value?.data?.courses
            ?.where((element) => element.id == course.id)
            .toList()
            .first
            .isSaved = false;
        courses.refresh();
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
  }

  Future<void> unsaveCourse(CoursesModel course) async {
    if (await getIt<UserProfileController>().isOnline == false) {
      Fluttertoast.showToast(
        msg: "You Are Offline",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 14.0,
      );
    } else {
      courses.value?.data?.courses
          ?.where((element) => element.id == course.id)
          .toList()
          .first
          .isSaved = false;
      courses.refresh();
      bool result = await coursesRepository.unsaveCourse(course);
      if (result == false) {
        courses.value?.data?.courses
            ?.where((element) => element.id == course.id)
            .toList()
            .first
            .isSaved = true;
        courses.refresh();
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
  }

  Future<void> saveJob(JobsModel job) async {
    if (await getIt<UserProfileController>().isOnline == false) {
      Fluttertoast.showToast(
        msg: "You Are Offline",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 14.0,
      );
    } else {
      jobs.value?.data?.jobs
          ?.where((element) => element.id == job.id)
          .toList()
          .first
          .isSaved = true;
      jobs.refresh();
      bool result = await jobsRepository.saveJob(job);
      if (result == false) {
        jobs.value?.data?.jobs
            ?.where((element) => element.id == job.id)
            .toList()
            .first
            .isSaved = false;
        jobs.refresh();
        Fluttertoast.showToast(
          msg: "Failed to save job.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          fontSize: 14.0,
        );
      } else {
        await getIt<UserProfileController>().getUserProfile();
      }
      debugPrint(result.toString());
    }
  }

  Future<void> unsaveJob(JobsModel job) async {
    if (await getIt<UserProfileController>().isOnline == false) {
      Fluttertoast.showToast(
        msg: "You Are Offline",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 14.0,
      );
    } else {
      jobs.value?.data?.jobs
          ?.where((element) => element.id == job.id)
          .toList()
          .first
          .isSaved = false;
      bool result = await jobsRepository.unsaveJob(job);
      if (result == false) {
        jobs.value?.data?.jobs
            ?.where((element) => element.id == job.id)
            .toList()
            .first
            .isSaved = true;
        Fluttertoast.showToast(
          msg: "Failed to unsave job.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          fontSize: 14.0,
        );
      } else {
        await getIt<UserProfileController>().getUserProfile();
      }
      debugPrint(result.toString());
    }
  }

  Future<void> getCoursesRecomendation() async {
    isLoading.value = true;
    final result = await coursesRepository.getCoursesRecomendation();
    if (result != null) {
      courses.value = result;
      if (result.data?.courses?.isEmpty ?? true) {
        coursesErrorMessage.value =
            'No courses available at the moment. Please check back later.';
      } else {
        coursesErrorMessage.value = '';
      }
    } else {
      coursesErrorMessage.value = 'Failed to load courses.';
    }
    isLoading.value = false;
  }

  Future<void> getJobsRecomendation() async {
    isLoading.value = true;
    final result = await jobsRepository.getJobsRecomendation();
    // debugPrint("--------------Jobs----------------");
    // debugPrint(result.toString());
    if (result != null) {
      jobs.value = result;
      if (result.data?.jobs?.isEmpty ?? true) {
        jobsErrorMessage.value =
            'No jobs available at the moment. Please check back later.';
      } else {
        jobsErrorMessage.value = '';
      }
    } else {
      jobsErrorMessage.value = 'Failed to load jobs.';
    }
    isLoading.value = false;
  }

  Future<void> searchCourses(String? query) async {
    if (await getIt<UserProfileController>().isOnline == false) {
      Fluttertoast.showToast(
        msg: "You Are Offline",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 14.0,
      );
    } else {
      isLoading.value = true;
      if (query != null) {
        searchQuery.value = query;
      }
      var result;
      if (searchQuery.value.isNotEmpty) {
        result = await coursesRepository.searchCourses(searchQuery.value);
      } else {
        result = await coursesRepository.getCoursesRecomendation();
      }
      if (result != null) {
        courses.value = result;
        if (result.data?.courses?.isEmpty ?? true) {
          coursesErrorMessage.value =
              'No courses available at the moment. Please check back later.';
        } else {
          coursesErrorMessage.value = '';
        }
      } else {
        coursesErrorMessage.value = 'Failed to load courses.';
      }
      isLoading.value = false;
    }
  }

  Future<void> searchJobs(String? query) async {
    if (await getIt<UserProfileController>().isOnline == false) {
      Fluttertoast.showToast(
        msg: "You Are Offline",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 14.0,
      );
    } else {
      isLoading.value = true;
      if (query != null) {
        searchQuery.value = query;
      }
      var result;
      if (searchQuery.value.isNotEmpty) {
        result = await jobsRepository.searchJobs(searchQuery.value);
        // result = await jobsRepository.getJobsRecomendation();
      } else {
        result = await jobsRepository.getJobsRecomendation();
      }
      if (result != null) {
        jobs.value = result;
        if (result.data?.jobs?.isEmpty ?? true) {
          jobsErrorMessage.value =
              'No jobs available at the moment. Please check back later.';
        } else {
          jobsErrorMessage.value = '';
        }
      } else {
        jobsErrorMessage.value = 'Failed to load courses.';
      }
      isLoading.value = false;
    }
  }
}
