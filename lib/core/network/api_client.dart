import 'package:career_canvas/core/utils/TokenInfo.dart';
import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;

  ApiClient(this.dio);
static String authBase ="https://6gael81mn5.execute-api.ap-southeast-1.amazonaws.com/prod/auth";
  //static String authBase = "https://auth.api.careercanvas.pro/auth";
   static String userBase= "https://omwfq23az5.execute-api.ap-southeast-1.amazonaws.com/prod/user";
  //static String userBase = "https://users.api.careercanvas.pro";
  static String mediaBase = "https://media.api.careercanvas.pro";
  static String personalityBase = "https://fzwtb3cx54.execute-api.ap-southeast-1.amazonaws.com/prod/personality-test";
  //static String personalityBase = "https://personality.api.careercanvas.pro";
  static String jobsBase = "https://2bvgs6ame7.execute-api.ap-southeast-1.amazonaws.com/prod/jobs";
  //static String jobsBase = "https://jobs.api.careercanvas.pro";
  //static String coursesBase = "https://courses.api.careercanvas.pro";
  static String coursesBase ="https://4j6bud59c9.execute-api.ap-southeast-1.amazonaws.com/prod/courses";

  Future<Response> post(
    String path, {
    Map<String, dynamic>? data,
    bool useToken = false,
  }) async {
    Map<String, dynamic> headers = {
      'Content-Type': "application/json",
    };
    if (useToken) {
      headers["Authorization"] = "Bearer ${TokenInfo.token}";
    }
    return dio.post(
      path,
      data: data,
      options: Options(
        headers: headers,
      ),
    );
  }

  Future<Response> put(
    String path, {
    Object? data,
    bool useToken = false,
  }) async {
    Map<String, dynamic> headers = {
      'Content-Type': "application/json",
    };
    if (useToken) {
      headers["Authorization"] = "Bearer ${TokenInfo.token}";
    }
    return dio.put(
      path,
      data: data,
      options: Options(
        headers: headers,
      ),
    );
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool useToken = false,
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
