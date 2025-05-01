import 'package:career_canvas/features/Career/data/models/CareerTrends.dart';
import 'package:career_canvas/features/Career/data/models/JobsModel.dart';
import 'package:career_canvas/features/Career/domain/repository/JobsRepository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class JobsController extends GetxController {
  JobsRepository jobsRepository;
  JobsController(this.jobsRepository);
  var jobs = Rxn<JobsResponseModel>();
  var careerTrends = Rxn<CareerTrendResponse>();
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var isLoadingCareerTrends = false.obs;
  var errorMessageCareerTrends = ''.obs;

  Future<void> getJobsRecomendation() async {
    isLoading.value = true;
    final result = await jobsRepository.getJobsRecomendation();
    debugPrint(result.toString());
    if (result != null) {
      jobs.value = result;
      errorMessage.value = '';
    } else {
      errorMessage.value = 'Failed to load jobs.';
    }
    isLoading.value = false;
  }

  Future<void> getCareerTrends() async {
    isLoadingCareerTrends.value = true;
    final result = await jobsRepository.getCareerTrends();
    debugPrint(result.toString());
    if (result != null) {
      careerTrends.value = result;
      errorMessageCareerTrends.value = '';
    } else {
      errorMessageCareerTrends.value = 'Failed to load career trends.';
    }
    isLoadingCareerTrends.value = false;
  }
}
