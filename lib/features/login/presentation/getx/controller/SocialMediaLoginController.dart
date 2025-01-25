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
      await Future.delayed(Duration(seconds: 2)); // Simulate a delay
    } finally {
      isAppleLoading.value = false;
    }
  }

  Future<void> loginWithFacebook() async {
    isFacebookLoading.value = true;
    try {
      await Future.delayed(Duration(seconds: 2)); // Simulate a delay
    } finally {
      isFacebookLoading.value = false;
    }
  }

  Future<void> loginWithGithub() async {
    isGithubLoading.value = true;
    try {
      await Future.delayed(Duration(seconds: 2)); // Simulate a delay
    } finally {
      isGithubLoading.value = false;
    }
  }

  Future<void> loginWithLinkedIn() async {
    isLinkedInLoading.value = true;
    try {
      await Future.delayed(Duration(seconds: 2)); // Simulate a delay
    } finally {
      isLinkedInLoading.value = false;
    }
  }
}
