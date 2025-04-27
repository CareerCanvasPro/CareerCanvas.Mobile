import 'package:career_canvas/core/models/education.dart';
import 'package:career_canvas/core/models/experiance.dart';
import 'package:career_canvas/core/models/interests.dart';
import 'package:career_canvas/core/models/profile.dart';
import 'package:career_canvas/core/models/resume.dart';
import 'package:career_canvas/core/models/skills.dart';
import 'package:career_canvas/core/network/api_client.dart';
import 'package:career_canvas/src/profile/domain/models/UploadLanguage.dart';
import 'package:career_canvas/src/profile/domain/repository/userprofile_repo.dart';
import 'package:dio/dio.dart';

class UserProfileRepository_API_Impl extends UserProfileRepository {
  final ApiClient apiClient;
  UserProfileRepository_API_Impl(this.apiClient);

  @override
  Future<UserProfileData?> getUserProfile() async {
    try {
      final response = await apiClient.get(
        ApiClient.userBase,
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
      await apiClient.post(
        ApiClient.userBase + '/educations',
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
      await apiClient.post(
        ApiClient.userBase + '/occupations',
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
        ApiClient.userBase + '/about-me',
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
        ApiClient.userBase + '/skills',
        data: UploadSkills(skills: skills).toJson(),
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
        ApiClient.userBase + '/languages',
        data: UploadLanguage(languages: languages).toJson(),
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
  Future<String> updateInterest(List<String> interests) async {
    try {
      await apiClient.put(
        ApiClient.userBase + '/interests',
        data: UploadInterest(interests: interests).toJson(),
        useToken: true,
      );
      return "Updated your interests.";
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        return e.response!.data["message"];
      } else {
        return e.message ?? e.toString();
      }
    } catch (e) {
      return "Failed to update interests: $e";
    }
  }

  @override
  Future<String> updateGoals(List<String> goals) async {
    try {
      await apiClient.put(
        ApiClient.userBase + '/goals',
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
  Future<String> deleteResume(Resume resume) async {
    try {
      await apiClient.delete(
        ApiClient.userBase + '/resumes/${resume.id}?key=${resume.key}',
        useToken: true,
      );
      return "Deleted resume.";
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        return e.response!.data?["message"].toString() ??
            'Failed to delete resumes';
      } else {
        return e.message ?? e.toString();
      }
    } catch (e) {
      return "Failed to delete resumes: $e";
    }
  }

  @override
  Future<String> deleteEducation(Education education) async {
    try {
      String url = "ApiClient.userBase + '/educations/${education.id}";
      if (education.certificate != null) {
        url += "?key=${education.certificate?.key}";
      }
      await apiClient.delete(
        url,
        useToken: true,
      );
      return "Deleted education.";
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        return e.response!.data?["message"].toString() ??
            'Failed to delete education';
      } else {
        return e.message ?? e.toString();
      }
    } catch (e) {
      return "Failed to delete education: $e";
    }
  }

  @override
  Future<String> deleteExperiance(Experiance experiance) async {
    try {
      String url = "ApiClient.userBase + '/occupations/${experiance.id}";
      await apiClient.delete(
        url,
        useToken: true,
      );
      return "Deleted Experiance.";
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        return e.response!.data?["message"].toString() ??
            'Failed to delete experiance';
      } else {
        return e.message ?? e.toString();
      }
    } catch (e) {
      return "Failed to delete experiance: $e";
    }
  }
}
