import 'package:career_canvas/core/network/api_client.dart';
import 'package:career_canvas/features/Career/data/datasources/courses_remote_data_source.dart';
import 'package:career_canvas/features/Career/data/models/CoursesModel.dart';
import 'package:career_canvas/features/Career/domain/repository/CoursesRepository.dart';
import 'package:dio/dio.dart';

class CoursesRepository_API_Impl extends CoursesRepository {
  final ApiClient apiClient;
  CoursesRepository_API_Impl(this.apiClient);
  @override
  Future<CoursesResponseModel?> getCoursesRecomendation() async {
    try {
      CoursesRemoteDataSource coursesRemoteDataSource =
          CoursesRemoteDataSource(apiClient);
      final response = await coursesRemoteDataSource.getCourses();
      if (response.statusCode == 200) {
        return CoursesResponseModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load courses');
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data["message"]);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        throw Exception(e.response!.data["message"]);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        throw Exception(e.message);
      }
    } catch (e) {
      print('Error fetching courses: $e');
      return null;
    }
  }
}
