import 'package:career_canvas/features/Career/data/models/CoursesModel.dart';
import 'package:career_canvas/features/Career/data/models/JobsModel.dart';
import 'package:career_canvas/features/Career/domain/repository/CoursesRepository.dart';
import 'package:career_canvas/features/Career/domain/repository/JobsRepository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

enum SearchState { course, job }

class GlobalSearchController extends GetxController {
  CoursesRepository coursesRepository;
  JobsRepository jobsRepository;
  GlobalSearchController(this.coursesRepository, this.jobsRepository);
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final courses = Rxn<CoursesResponseModel>();
  final jobs = Rxn<JobsResponseModel>();
  final searchState = Rxn<SearchState>(SearchState.course);

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

  Future<void> getJobsRecomendation() async {
    isLoading.value = true;
    final result = await jobsRepository.getJobsRecomendation();
    debugPrint("--------------Jobs----------------");
    debugPrint(result.toString());
    if (result != null) {
      jobs.value = result;
      errorMessage.value = '';
    } else {
      errorMessage.value = 'Failed to load jobs.';
    }
    isLoading.value = false;
  }

  Future<void> searchCourses(String? query) async {
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
      errorMessage.value = '';
    } else {
      errorMessage.value = 'Failed to load courses.';
    }
    isLoading.value = false;
  }

  Future<void> searchJobs(String? query) async {
    isLoading.value = true;
    if (query != null) {
      searchQuery.value = query;
    }
    var result;
    if (searchQuery.value.isNotEmpty) {
      // result = await jobsRepository.searchJobs(searchQuery.value);
      result = await jobsRepository.getJobsRecomendation();
    } else {
      result = await jobsRepository.getJobsRecomendation();
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
