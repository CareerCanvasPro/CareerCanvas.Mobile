import 'package:career_canvas/core/models/profile.dart';
import 'package:career_canvas/src/profile/domain/repository/userprofile_repo.dart';
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
}
