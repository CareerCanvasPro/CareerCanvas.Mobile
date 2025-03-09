import 'package:career_canvas/core/errors/failure.dart';
import 'package:career_canvas/features/Career/data/models/JobsModel.dart';
import 'package:career_canvas/features/Career/domain/repository/JobsRepository.dart';
import 'package:dartz/dartz.dart';

class GetJobsRecomendation {
  final JobsRepository jobsRepository;

  GetJobsRecomendation(this.jobsRepository);

  Future<Either<Failure, JobsResponseModel>> call() async {
    try {
      final result = await jobsRepository.getJobsRecomendation();
      if (result == null) {
        throw Exception('Failed to load jobs');
      }
      return Right(result); // Return Right with the result if successful
    } catch (e) {
      return Left(
        ServerFailure(e.toString()),
      ); // Return Left with a failure message if an error occurs
    }
  }
}
