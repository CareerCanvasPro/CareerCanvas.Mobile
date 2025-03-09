import 'package:career_canvas/core/utils/TokenInfo.dart';
import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;

  ApiClient(this.dio);

  static String authBase = "https://auth.api.careercanvas.pro/auth";
  static String userBase = "https://users.api.careercanvas.pro";
  static String mediaBase = "https://media.api.careercanvas.pro";
  static String personalityBase = "https://personality.api.careercanvas.pro";
  static String jobsBase = "https://jobs.api.careercanvas.pro";
  static String coursesBase = "https://courses.api.careercanvas.pro";

  Future<Response> post(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    return dio.post(path, data: data);
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool useToken = true,
  }) async {
    Map<String, dynamic> headers = {
      'Content-Type': "application/json",
    };
    if (useToken) {
      headers["Authorization"] = "Bearer ${TokenInfo.token}";
    }
    return dio.get(
      path,
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
      ),
    );
  }
}
