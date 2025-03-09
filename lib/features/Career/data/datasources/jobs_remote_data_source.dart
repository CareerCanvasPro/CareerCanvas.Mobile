import 'package:career_canvas/core/network/api_client.dart';
import 'package:dio/dio.dart';

class JobsRemoteDataSource {
  final ApiClient apiClient;
  JobsRemoteDataSource(this.apiClient);

  Future<Response<dynamic>> getJobs() async {
    final response = await apiClient.get(
      '${ApiClient.jobsBase}/jobs/recommendation',
      useToken: true,
    );
    return response;
  }
}
