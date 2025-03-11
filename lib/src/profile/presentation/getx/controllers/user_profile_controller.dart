import 'package:career_canvas/core/models/education.dart';
import 'package:career_canvas/core/models/experiance.dart';
import 'package:career_canvas/core/models/profile.dart';
import 'package:career_canvas/core/models/resume.dart';
import 'package:career_canvas/src/profile/domain/repository/userprofile_repo.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class UserProfileController extends GetxController {
  UserProfileRepository userProfileRepository;
  UserProfileController(this.userProfileRepository);
  var userProfile = Rxn<UserProfileData>();
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> getUserProfile() async {
    isLoading.value = true;
    final result = await userProfileRepository.getUserProfile();
    if (result != null) {
      userProfile.value = result;
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

  Future<void> uploadResume(Resume resume) async {
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
