import 'dart:convert';
import 'dart:io';
import 'package:career_canvas/core/Dependencies/setupDependencies.dart';
import 'package:career_canvas/core/utils/TokenInfo.dart';
import 'package:career_canvas/features/AuthService.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:career_canvas/core/models/education.dart';
import 'package:career_canvas/core/models/experiance.dart';
import 'package:career_canvas/core/models/profile.dart';
import 'package:career_canvas/core/models/resume.dart';
import 'package:career_canvas/src/profile/domain/repository/userprofile_repo.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

class UserProfileController extends GetxController {
  UserProfileRepository userProfileRepository;
  UserProfileController(this.userProfileRepository);
  var userProfile = Rxn<UserProfileData>();
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  RxList<Resume> resumes = <Resume>[].obs;

  Future<void> getUserProfile() async {
    isLoading.value = true;
    final result = await userProfileRepository.getUserProfile();
    if (result != null) {
      userProfile.value = result;
      resumes.value = result.resumes;
      errorMessage.value = '';
    } else {
      errorMessage.value = 'Failed to load user profile.';
    }
    isLoading.value = false;
  }

  Future<void> uploadEducation(UploadEducation education) async {
    isLoading.value = true;
    final result = await userProfileRepository.addEducation(education);
    print(result);
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

  Future<void> updateResume(List<Resume> resumes) async {
    isLoading.value = true;
    final result = await userProfileRepository.updateResumes(resumes);
    Fluttertoast.showToast(
      msg: result,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      fontSize: 14.0,
    );
    isLoading.value = false;
  }

//   Future<void> uploadResume(File file, int index) async {
//     var url = Uri.parse("https://media.api.careercanvas.pro/media/resume?index=$index");
// final String? token = getIt<AuthService>().token;

//     if (token == null) {
//       Get.snackbar("Error", "Authorization token is missing.");
//       return;
//     }
//     var request = http.MultipartRequest('POST', url)
//       ..headers['Authorization'] = token
//       ..files.add(
//         await http.MultipartFile.fromPath('file', file.path, filename: basename(file.path)),
//       );
//       print('razzzzzz');
// print(request);
//     try {
//       var response = await request.send();
//       if (response.statusCode == 200) {
//         var responseBody = await response.stream.bytesToString();
//         var jsonResponse = json.decode(responseBody);

//         var uploadedResume = Resume(
//           name: jsonResponse['data']['file']['name'],
//           size: jsonResponse['data']['file']['size'],
//           type: jsonResponse['data']['file']['type'],
//           uploadedAt: DateTime.parse(jsonResponse['data']['file']['uploadedAt']),
//           url: jsonResponse['data']['file']['url'],
//         );

//         resumes.add(uploadedResume);
//         Get.snackbar("Success", "Resume uploaded successfully");
//       } else {
//         Get.snackbar("Error", "Failed to upload resume");
//       }
//     } catch (e) {
//       Get.snackbar("Error", "An error occurred: $e");
//     }
//   }
  Future<void> uploadResume(File file, int index) async {
    var url = Uri.parse(
        "https://media.api.careercanvas.pro/media/resume?index=$index");

    // Print the file details before adding it to the request
    print('File: ${file.path}, Filename: ${basename(file.path)}');
    var request = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = "Bearer ${TokenInfo.token}";

    try {
      var filePart = await http.MultipartFile.fromPath(
        'file',
        file.path,
        filename: basename(file.path),
        contentType: DioMediaType.parse(
          lookupMimeType(basename(file.path)) ?? 'image/jpeg',
        ),
      );
      print('File: ${filePart.filename}, Path: ${filePart.filename}');
      request.files.add(filePart);

      print('Request Headers: ${request.headers}');
      print('Request Files: ${request.files.length}');

      var response = await request.send();
      print('Response Status Code: ${response.statusCode}');

      var responseBody = await response.stream.bytesToString();
      print('Response Body: $responseBody');

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(responseBody);
        var uploadedResume = Resume(
          name: jsonResponse['data']['file']['name'],
          size: jsonResponse['data']['file']['size'],
          type: jsonResponse['data']['file']['type'],
          uploadedAt: DateTime.fromMillisecondsSinceEpoch(
            jsonResponse['data']['file']['uploadedAt'],
          ),
          url: jsonResponse['data']['file']['url'],
        );

        resumes.add(uploadedResume);
        updateResume(resumes);
        Get.snackbar("Success", "Resume uploaded successfully");
      } else {
        Get.snackbar("Error", "Failed to upload resume");
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar("Error", "An error occurred: $e");
    }
  }

  Future<void> uploadResumeold(Resume resume) async {
    isLoading.value = true;
    final result = await userProfileRepository.addResume(resume);
    if (result != null) {
      userProfile.value = result;
      errorMessage.value = '';
    } else {
      errorMessage.value = 'Failed to upload resume.';
    }
    isLoading.value = false;
  }
}
