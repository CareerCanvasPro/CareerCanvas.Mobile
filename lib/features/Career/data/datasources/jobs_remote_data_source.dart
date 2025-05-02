import 'package:career_canvas/core/network/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class JobsRemoteDataSource {
  final ApiClient apiClient;
  JobsRemoteDataSource(this.apiClient);

  Future<Response<dynamic>> getJobs() async {
    final response = await apiClient.get(
      '${ApiClient.jobsBase}/recommendation',
      useToken: true,
    );
    debugPrint(response.toString());
    return response;
  }

  Future<Response<dynamic>> getCareerTrends() async {
    final response = await apiClient.get(
      '${ApiClient.jobsBase}/career-trends',
      useToken: true,
    );
    return response;
  }
}
