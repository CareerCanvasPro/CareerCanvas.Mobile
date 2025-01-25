import 'package:get/get.dart';

class SocialMediaLoginController extends GetxController {
  RxBool isGoogleLoading = false.obs;
  RxBool isAppleLoading = false.obs;
  RxBool isFacebookLoading = false.obs;
  RxBool isGithubLoading = false.obs;
  RxBool isLinkedInLoading = false.obs;

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Future<void> loginWithGoogle() async {
  //   isGoogleLoading.value = true;
  //   try {
  //     // Trigger the Google Sign-In flow
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //     if (googleUser == null) {
  //       // User canceled the sign-in
  //       return;
  //     }

  //     // Obtain the Google authentication details
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;

  //     // Create a new credential
  //     final OAuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     // Sign in to Firebase with the credential
  //     final UserCredential userCredential =
  //         await _auth.signInWithCredential(credential);

  //     // Handle the signed-in user
  //     User? user = userCredential.user;
  //     if (user != null) {

  //       Get.snackbar("Welcome", "Hello, ${user.displayName}!",
  //           snackPosition: SnackPosition.BOTTOM);
  //     }
  //   } catch (e) {
  //     print('Error signing in with Google: $e');
  //     Get.snackbar("Error", "Google sign-in failed",
  //         snackPosition: SnackPosition.BOTTOM);
  //   } finally {
  //     isGoogleLoading.value = false;
  //   }
  // }

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
