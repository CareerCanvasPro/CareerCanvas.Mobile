
import 'package:get/get.dart';

class LoginController extends GetxController {
  var isLoading = false.obs; // Observable variable

  void toggleLoading() {
    isLoading.value = true;
    Future.delayed(Duration(seconds: 3), () {
      isLoading.value = false;
    });
  }
}
