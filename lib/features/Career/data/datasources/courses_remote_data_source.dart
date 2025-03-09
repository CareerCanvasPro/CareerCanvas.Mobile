import 'package:career_canvas/core/network/api_client.dart';
import 'package:dio/dio.dart';

class CoursesRemoteDataSource {
  final ApiClient apiClient;

  CoursesRemoteDataSource(this.apiClient);

  Future<Response> getCourses() async {
    final response = await apiClient.get(
      ApiClient.coursesBase + '/courses/recommendation',
      useToken: true,
    );
    return response;
  }
}
