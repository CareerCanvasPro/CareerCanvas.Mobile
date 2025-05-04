import 'package:career_canvas/core/network/api_client.dart';
import 'package:career_canvas/features/Career/data/datasources/courses_remote_data_source.dart';
import 'package:career_canvas/features/Career/data/models/CoursesModel.dart';
import 'package:career_canvas/features/Career/domain/repository/CoursesRepository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CoursesRepository_API_Impl extends CoursesRepository {
  final ApiClient apiClient;
  CoursesRepository_API_Impl(this.apiClient);
  @override
  Future<CoursesResponseModel?> getCoursesRecomendation() async {
    try {
      CoursesRemoteDataSource coursesRemoteDataSource =
          CoursesRemoteDataSource(apiClient);
      final response = await coursesRemoteDataSource.getCourses();
      debugPrint(response.toString());
      if (response.statusCode == 200) {
        return CoursesResponseModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load courses');
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        debugPrint(e.response!.data["message"]);
        debugPrint(e.response!.headers.toString());
        debugPrint(e.response!.requestOptions.toString());
        return null;
        // throw Exception(e.response!.data["message"]);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        debugPrint(e.requestOptions.toString());
        debugPrint(e.message);
        return null;
        // throw Exception(e.message);
      }
    } catch (e) {
      debugPrint('Error fetching courses: ${e.toString()}');
      return null;
    }
  }

  @override
  Future<CoursesResponseModel?> searchCourses(String query) async {
    try {
      CoursesRemoteDataSource coursesRemoteDataSource =
          CoursesRemoteDataSource(apiClient);
      final response = await coursesRemoteDataSource.searchCourses(query);
      // debugPrint(response.data.toString());
      if (response.statusCode == 200) {
        CoursesResponseModel data =
            CoursesResponseModel.fromJson(response.data);
        return data;
      } else {
        throw Exception('Failed to load courses');
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        debugPrint(e.response!.data["message"].toString());
        debugPrint(e.response!.headers.toString());
        debugPrint(e.response!.requestOptions.toString());
        return null;
        // throw Exception(e.response!.data["message"]);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        debugPrint(e.requestOptions.toString());
        debugPrint(e.message.toString());
        return null;
        // throw Exception(e.message);
      }
    } catch (e) {
      debugPrint('Error fetching courses: ${e.toString()}');
      return null;
    }
  }

  @override
  Future<CoursesResponseModel?> getCoursesBasedOnGoals() async {
    try {
      CoursesRemoteDataSource coursesRemoteDataSource =
          CoursesRemoteDataSource(apiClient);
      final response = await coursesRemoteDataSource.getCoursesByGoals();
      if (response.statusCode == 200) {
        return CoursesResponseModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load courses');
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        // print(e.response!.data["message"]);
        // print(e.response!.headers);
        // print(e.response!.requestOptions);
        return null;
        // throw Exception(e.response!.data["message"]);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        // print(e.requestOptions);
        // print(e.message);
        return null;
        // throw Exception(e.message);
      }
    } catch (e) {
      // print('Error fetching courses: $e');
      return null;
    }
  }
}
