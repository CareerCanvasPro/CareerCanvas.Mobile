import 'package:career_canvas/core/models/education.dart';
import 'package:career_canvas/core/models/experiance.dart';
import 'package:career_canvas/core/models/profile.dart';
import 'package:career_canvas/core/models/resume.dart';
import 'package:career_canvas/core/network/api_client.dart';
import 'package:career_canvas/src/profile/domain/repository/userprofile_repo.dart';
import 'package:dio/dio.dart';

class UserProfileRepository_API_Impl extends UserProfileRepository {
  final ApiClient apiClient;
  UserProfileRepository_API_Impl(this.apiClient);

  @override
  Future<UserProfileData?> getUserProfile() async {
    try {
      final response = await apiClient.get(
        ApiClient.userBase + '/user/profile',
        useToken: true,
      );
      return UserProfileData.fromMap(response.data['data']);
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        throw Exception(e.response!.data["message"]);
      } else {
        throw Exception(e.message);
      }
    } catch (e) {
      print('Error fetching user profile: $e');
      return null;
    }
  }

  @override
  Future<String> addEducation(UploadEducation education) async {
    try {
      print(education.toMap());
      await apiClient.put(
        ApiClient.userBase + '/user/profile',
        data: education.toMap(),
        useToken: true,
      );
      return "Uploaded Education";
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        // print("Resonse");
        // print(e.response!.statusCode);
        // print(e.response!.statusMessage);
        // print(e.response!.data["message"]);
        // print(e.response!.headers);
        // print(e.response!.requestOptions);
        return e.response!.data["message"].toString();
      } else {
        // print("No resonse");
        // print(e.requestOptions);
        // print(e.message);
        return e.message ?? e.toString();
      }
    } catch (e) {
      return "Failed to upload Education: $e";
    }
  }

  @override
  Future<String> addExperiance(UploadExperiance experiance) async {
    try {
      await apiClient.put(
        ApiClient.userBase + '/user/profile',
        data: experiance.toMap(),
        useToken: true,
      );
      return "Uploaded Experiance";
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        return e.response!.data["message"];
      } else {
        return e.message ?? e.toString();
      }
    } catch (e) {
      return "Failed to upload Experiance: $e";
    }
  }

  @override
  Future addResume(Resume resume) async {}

  @override
  Future<String> updateAboutMe(String aboutMe) async {
    try {
      await apiClient.put(
        ApiClient.userBase + '/user/profile',
        data: {
          "aboutMe": aboutMe,
        },
        useToken: true,
      );
      return "Updated about me.";
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        return e.response!.data["message"];
      } else {
        return e.message ?? e.toString();
      }
    } catch (e) {
      return "Failed to update about me: $e";
    }
  }

  @override
  Future<String> updateSkills(List<String> skills) async {
    try {
      await apiClient.put(
        ApiClient.userBase + '/user/profile',
        data: {
          "skills": skills,
        },
        useToken: true,
      );
      return "Updated your skills.";
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        return e.response!.data["message"];
      } else {
        return e.message ?? e.toString();
      }
    } catch (e) {
      return "Failed to update skills: $e";
    }
  }

  @override
  Future<String> updateLanguage(List<String> languages) async {
    try {
      await apiClient.put(
        ApiClient.userBase + '/user/profile',
        data: {
          "languages": languages,
        },
        useToken: true,
      );
      return "Updated your languages.";
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        return e.response!.data["message"];
      } else {
        return e.message ?? e.toString();
      }
    } catch (e) {
      return "Failed to update language: $e";
    }
  }

  @override
  Future<String> updateGoals(List<String> goals) async {
    try {
      await apiClient.put(
        ApiClient.userBase + '/user/profile',
        data: {
          "goals": goals,
        },
        useToken: true,
      );
      return "Updated your goals.";
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        return e.response!.data?["message"].toString() ??
            'Failed to update goals';
      } else {
        return e.message ?? e.toString();
      }
    } catch (e) {
      return "Failed to update goals: $e";
    }
  }

  @override
  Future<String> updateResumes(List<Resume> resumes) async {
    try {
      await apiClient.put(
        ApiClient.userBase + '/user/profile',
        data: {
          "resumes": resumes.map((e) => e.toMap()).toList(),
        },
        useToken: true,
      );
      return "Updated your resumes.";
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        return e.response!.data?["message"].toString() ??
            'Failed to update resumes';
      } else {
        return e.message ?? e.toString();
      }
    } catch (e) {
      return "Failed to update resumes: $e";
    }
  }
}
