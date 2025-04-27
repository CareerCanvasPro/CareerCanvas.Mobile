import 'package:career_canvas/core/network/api_client.dart';
import 'package:dio/dio.dart';

class CoursesRemoteDataSource {
  final ApiClient apiClient;

  CoursesRemoteDataSource(this.apiClient);

  Future<Response> getCourses() async {
    final response = await apiClient.get(
      ApiClient.coursesBase + '/recommendation',
      useToken: true,
    );
    return response;
  }

  Future<Response> getCoursesByGoals() async {
    final response = await apiClient.get(
      ApiClient.coursesBase + '/recommendation/goals',
      useToken: true,
    );
    return response;
  }

  Future<Response> searchCourses(String query) async {
    final response = await apiClient.get(
      ApiClient.coursesBase + '/search',
      queryParameters: {
        'keyword': query,
      },
      useToken: true,
    );
    return response;
  }
}
