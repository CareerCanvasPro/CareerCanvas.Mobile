import 'dart:io';
import 'package:career_canvas/core/network/api_client.dart';
import 'package:career_canvas/core/utils/ConnectivityService.dart';
import 'package:career_canvas/core/utils/TokenInfo.dart';
import 'package:dio/dio.dart' as dio;
import 'package:career_canvas/core/models/education.dart';
import 'package:career_canvas/core/models/experiance.dart';
import 'package:career_canvas/core/models/profile.dart';
import 'package:career_canvas/core/models/resume.dart';
import 'package:career_canvas/src/profile/domain/repository/userprofile_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

class UserProfileController extends GetxController {
  UserProfileRepository userProfileRepository;
  ConnectivityService connectivityService;

  UserProfileController(this.userProfileRepository, this.connectivityService);

  Future<bool> get isOnline async {
    return await ConnectivityService().checkCurrentStatus();
  }

  var userProfile = Rxn<UserProfileData>();
  var isLoading = false.obs;
  var isUploadingResume = false.obs;
  RxDouble progress = 0.0.obs;
  var errorMessage = ''.obs;
  RxList<Resume> resumes = <Resume>[].obs;
  dio.CancelToken? cancelToken;

  Future<void> getUserProfile() async {
    final result = await userProfileRepository.getUserProfile();
    debugPrint(result.toString());
    if (result != null) {
      userProfile.value = result;
      resumes.value = result.resumes;
      errorMessage.value = '';
    } else {
      errorMessage.value = 'Failed to load user profile.';
    }
  }

  Future<void> uploadEducation(UploadEducation education) async {
    isLoading.value = true;
    final result = await userProfileRepository.addEducation(education);
    // print(result);
    Fluttertoast.showToast(
      msg: result,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      fontSize: 14.0,
    );
    isLoading.value = false;
  }

  Future<void> deleteEducation(Education education) async {
    isLoading.value = true;
    final result = await userProfileRepository.deleteEducation(education);
    // print(result);
    Fluttertoast.showToast(
      msg: result,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      fontSize: 14.0,
    );
    isLoading.value = false;
  }

  Future<void> deleteExperiance(Experiance experiance) async {
    isLoading.value = true;
    final result = await userProfileRepository.deleteExperiance(experiance);
    // print(result);
    Fluttertoast.showToast(
      msg: result,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      fontSize: 14.0,
    );
    isLoading.value = false;
  }

  Future<void> updateAboutMe(String aboutMe) async {
    isLoading.value = true;
    final result = await userProfileRepository.updateAboutMe(aboutMe);
    Fluttertoast.showToast(
      msg: result,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      fontSize: 14.0,
    );
    isLoading.value = false;
  }

  Future<void> uploadExperiance(UploadExperiance experiance) async {
    isLoading.value = true;
    final result = await userProfileRepository.addExperiance(experiance);
    Fluttertoast.showToast(
      msg: result,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      fontSize: 14.0,
    );
    isLoading.value = false;
  }

  Future<void> updateSkills(List<String> skills) async {
    isLoading.value = true;
    final result = await userProfileRepository.updateSkills(skills);
    Fluttertoast.showToast(
      msg: result,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      fontSize: 14.0,
    );
    isLoading.value = false;
  }

  Future<void> updateLanguage(List<String> languages) async {
    isLoading.value = true;
    final result = await userProfileRepository.updateLanguage(languages);
    Fluttertoast.showToast(
      msg: result,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      fontSize: 14.0,
    );
    isLoading.value = false;
  }

  Future<void> updateInterest(List<String> interests) async {
    isLoading.value = true;
    final result = await userProfileRepository.updateInterest(interests);
    Fluttertoast.showToast(
      msg: result,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      fontSize: 14.0,
    );
    isLoading.value = false;
  }

  Future<void> updateGoals(List<String> goals) async {
    isLoading.value = true;
    final result = await userProfileRepository.updateGoals(goals);
    Fluttertoast.showToast(
      msg: result,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      fontSize: 14.0,
    );
    isLoading.value = false;
  }

  Future<void> deleteResume(Resume resume) async {
    isLoading.value = true;
    final result = await userProfileRepository.deleteResume(resume);
    Fluttertoast.showToast(
      msg: result,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      fontSize: 14.0,
    );
    isLoading.value = false;
  }

  Future<void> uploadResume(
    File file,
  ) async {
    try {
      cancelToken = dio.CancelToken();
      dio.FormData formData = dio.FormData.fromMap(
        {
          "file": await dio.MultipartFile.fromFile(
            file.path,
            filename: basename(file.path),
            contentType: dio.DioMediaType.parse(
              lookupMimeType(basename(file.path)) ?? 'image/jpeg',
            ),
          ),
        },
      );
      final dioA = dio.Dio(
        dio.BaseOptions(
          baseUrl: ApiClient.mediaBase,
          connectTimeout: const Duration(seconds: 3000),
          receiveTimeout: const Duration(seconds: 3000),
        ),
      );

      isUploadingResume.value = true;
      final response = await dioA.post(
        "${ApiClient.userBase}/resumes",
        data: formData,
        cancelToken: cancelToken,
        options: dio.Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            "Authorization": "Bearer ${TokenInfo.token}",
          },
        ),
        onSendProgress: (count, total) {
          progress.value = (count / total) * 100;
        },
      );

      isUploadingResume.value = false;
      progress.value = 0;

      if (response.statusCode == 200) {
        // Resume uploadedResume = Resume.fromMap(response.data["data"]["resume"]);
        Fluttertoast.showToast(
          msg: "Successfully uploaded resume.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          fontSize: 14.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Failed to upload resume.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          fontSize: 14.0,
        );
      }
    } on dio.DioException catch (e) {
      isUploadingResume.value = false;
      progress.value = 0;
      if (e.type == dio.DioExceptionType.cancel) {
        Fluttertoast.showToast(
          msg: "Uploading Resume Cancelled.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          fontSize: 14.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: e.message ?? "An error occurred.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          fontSize: 14.0,
        );
      }
    } catch (e) {
      isUploadingResume.value = false;
      progress.value = 0;
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 14.0,
      );
    }
  }
}
