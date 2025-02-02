import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;

  ApiClient(this.dio);

  static String authBase = "http://13.229.30.167:5000";
  static String userBase = "http://13.229.30.167:8000";

  Future<Response> post(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    return dio.post(path, data: data);
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return dio.get(path, queryParameters: queryParameters);
  }
}
