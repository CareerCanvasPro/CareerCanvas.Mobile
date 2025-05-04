import 'package:career_canvas/features/Career/data/models/CareerTrends.dart';
import 'package:career_canvas/features/Career/data/models/JobsModel.dart';

abstract class JobsRepository {
  Future<JobsResponseModel?> getJobsRecomendation();
  Future<CareerTrendResponse?> getCareerTrends();
  // Future<JobsResponseModel?> searchJobs(String query);
}
