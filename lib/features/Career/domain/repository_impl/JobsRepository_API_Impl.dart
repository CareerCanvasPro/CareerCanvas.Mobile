import 'package:career_canvas/core/Dependencies/setupDependencies.dart';
import 'package:career_canvas/core/network/api_client.dart';
import 'package:career_canvas/core/utils/AppCache.dart';
import 'package:career_canvas/features/Career/data/datasources/jobs_remote_data_source.dart';
import 'package:career_canvas/features/Career/data/models/CareerTrends.dart';
import 'package:career_canvas/features/Career/data/models/JobsModel.dart';
import 'package:career_canvas/features/Career/domain/repository/JobsRepository.dart';
import 'package:career_canvas/src/profile/presentation/getx/controllers/user_profile_controller.dart';
import 'package:dio/dio.dart';

class JobsRepository_API_Impl extends JobsRepository {
  final ApiClient apiClient;
  JobsRepository_API_Impl(this.apiClient);
  @override
  Future<JobsResponseModel?> getJobsRecomendation() async {
    if (await getIt<UserProfileController>().isOnline == false &&
        Appcache.jobs != null) {
      return Appcache.jobs;
    }
    JobsRemoteDataSource jobsRemoteDataSource = JobsRemoteDataSource(apiClient);
    try {
      final response = await jobsRemoteDataSource.getJobs();
      if (response.statusCode == 200) {
        JobsResponseModel data = JobsResponseModel.fromMap(response.data);
        await Appcache.setJobs(data);
        return data;
      } else {
        throw Exception('Failed to load jobs');
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        // print(e.response!.data["message"]);
        // print(e.response!.headers);
        // print(e.response!.requestOptions);
        throw Exception(e.response!.data["message"]);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        // print(e.requestOptions);
        // print(e.message);
        throw Exception(e.message);
      }
    } catch (e) {
      // print('Error fetching jobs: $e');
      return null;
    }
  }

  @override
  Future<CareerTrendResponse?> getCareerTrends() async {
    if (await getIt<UserProfileController>().isOnline == false &&
        Appcache.careerTrends != null) {
      return Appcache.careerTrends;
    }
    JobsRemoteDataSource jobsRemoteDataSource = JobsRemoteDataSource(apiClient);
    try {
      final response = await jobsRemoteDataSource.getCareerTrends();
      if (response.statusCode == 200) {
        CareerTrendResponse trends = CareerTrendResponse.fromMap(response.data);
        await Appcache.setCareerTrends(trends);
        return trends;
      } else {
        throw Exception('Failed to load jobs');
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        // print(e.response!.data["message"]);
        // print(e.response!.headers);
        // print(e.response!.requestOptions);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        // print(e.requestOptions);
        // print(e.message);
      }

      return null;
    } catch (e) {
      // print('Error fetching jobs: $e');
      return null;
    }
  }

  @override
  Future<bool> saveJob(JobsModel job) async {
    JobsRemoteDataSource jobsRemoteDataSource = JobsRemoteDataSource(apiClient);
    try {
      final response = await jobsRemoteDataSource.saveJob(job);
      if (response.statusCode == 200) {
        // JobsResponseModel data = JobsResponseModel.fromMap(response.data);
        return true;
      } else {
        throw Exception('Failed to save job');
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        // print(e.response!.data["message"]);
        // print(e.response!.headers);
        // print(e.response!.requestOptions);
        throw Exception(e.response!.data["message"]);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        // print(e.requestOptions);
        // print(e.message);
        throw Exception(e.message);
      }
    } catch (e) {
      // print('Error fetching jobs: $e');
      return false;
    }
  }

  @override
  Future<bool> unsaveJob(JobsModel job) async {
    JobsRemoteDataSource jobsRemoteDataSource = JobsRemoteDataSource(apiClient);
    try {
      final response = await jobsRemoteDataSource.unsaveJob(job);
      if (response.statusCode == 200) {
        // JobsResponseModel data = JobsResponseModel.fromMap(response.data);
        return true;
      } else {
        throw Exception('Failed to unsave job');
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        // print(e.response!.data["message"]);
        // print(e.response!.headers);
        // print(e.response!.requestOptions);
        throw Exception(e.response!.data["message"]);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        // print(e.requestOptions);
        // print(e.message);
        throw Exception(e.message);
      }
    } catch (e) {
      // print('Error fetching jobs: $e');
      return false;
    }
  }

  @override
  Future<JobsResponseModel?> searchJobs(String query) async {
    JobsRemoteDataSource jobsRemoteDataSource = JobsRemoteDataSource(apiClient);
    try {
      final response = await jobsRemoteDataSource.searchJobs(query);
      if (response.statusCode == 200) {
        JobsResponseModel data = JobsResponseModel.fromMap(response.data);
        return data;
      } else {
        throw Exception('Failed to load jobs');
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        // print(e.response!.data["message"]);
        // print(e.response!.headers);
        // print(e.response!.requestOptions);
        throw Exception(e.response!.data["message"]);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        // print(e.requestOptions);
        // print(e.message);
        throw Exception(e.message);
      }
    } catch (e) {
      // print('Error fetching jobs: $e');
      return null;
    }
  }
}
