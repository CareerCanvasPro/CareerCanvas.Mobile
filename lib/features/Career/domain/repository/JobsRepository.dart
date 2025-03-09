import 'package:career_canvas/features/Career/data/models/JobsModel.dart';

abstract class JobsRepository {
  Future<JobsResponseModel?> getJobsRecomendation();
}
