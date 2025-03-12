import 'package:career_canvas/features/Career/data/models/CoursesModel.dart';

abstract class CoursesRepository {
  Future<CoursesResponseModel?> getCoursesRecomendation();
  Future<CoursesResponseModel?> getCoursesBasedOnGoals();
  Future<CoursesResponseModel?> searchCourses(String query);
}
