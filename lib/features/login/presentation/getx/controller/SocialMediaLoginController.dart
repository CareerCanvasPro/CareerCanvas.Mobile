import 'package:get/get.dart';

class SocialMediaLoginController extends GetxController {
  RxBool isGoogleLoading = false.obs;
  RxBool isAppleLoading = false.obs;
  RxBool isFacebookLoading = false.obs;
  RxBool isGithubLoading = false.obs;
  RxBool isLinkedInLoading = false.obs;

  Future<void> loginWithGoogle() async {
    isGoogleLoading.value = true;
    try {
      await Future.delayed(Duration(seconds: 2)); // Simulate a delay
    } finally {
      isGoogleLoading.value = false;
    }
  }

  Future<void> loginWithApple() async {
    isAppleLoading.value = true;
    try {
      // Your Apple login logic here
    } finally {
      isAppleLoading.value = false;
    }
  }

  Future<void> loginWithFacebook() async {
    isFacebookLoading.value = true;
    try {
      // Your Facebook login logic here
    } finally {
      isFacebookLoading.value = false;
    }
  }

  Future<void> loginWithGithub() async {
    isGithubLoading.value = true;
    try {
      // Your Github login logic here
    } finally {
      isGithubLoading.value = false;
    }
  }

  Future<void> loginWithLinkedIn() async {
    isLinkedInLoading.value = true;
    try {
      // Your LinkedIn login logic here
    } finally {
      isLinkedInLoading.value = false;
    }
  }
}
