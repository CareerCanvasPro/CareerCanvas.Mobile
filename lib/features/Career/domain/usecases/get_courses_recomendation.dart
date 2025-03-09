import 'package:career_canvas/core/errors/failure.dart';
import 'package:career_canvas/features/Career/data/models/CoursesModel.dart';
import 'package:career_canvas/features/Career/domain/repository/CoursesRepository.dart';
import 'package:dartz/dartz.dart';

class GetCoursesRecomendation {
  final CoursesRepository coursesRepository;

  GetCoursesRecomendation(this.coursesRepository);

  Future<Either<Failure, CoursesResponseModel>> call() async {
    try {
      final result = await coursesRepository.getCoursesRecomendation();
      if (result == null) {
        throw Exception('Failed to load courses');
      }
      return Right(result); // Return Right with the result if successful
    } catch (e) {
      return Left(
        ServerFailure(
          e.toString(),
        ),
      ); // Return Left with a failure message if an error occurs
    }
  }
}
