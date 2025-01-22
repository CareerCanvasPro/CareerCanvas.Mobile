// import 'package:get/get.dart';
// class TabContentController extends GetxController {
//   var isLoading = false.obs;
//   Future<void> onButtonPressed() async {
//     isLoading.value = true;
//     try {
//       await Future.delayed(Duration(seconds: 2)); // Simulate a delay
//       // Your button logic here
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../login/ProfileCompletionScreenOne.dart';

class EmailController extends GetxController {
  var isLoading = false.obs;

  void onEmailButtonPressed(BuildContext context) {
    isLoading.value = true;

    // Simulate async operation
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
      Navigator.pushNamed(context, '/profileCompletionOne',  arguments: {'type': 'Email'});
      //Get.to(() => ProfileCompletionScreenOne(),  arguments: {'type': 'Email'});
    });
  }
}

class PhoneNumberController extends GetxController {
  var isLoading = false.obs;

  void onPhoneNumberButtonPressed(BuildContext context) {
    isLoading.value = true;

    // Simulate async operation
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
            Navigator.pushNamed(context, '/profileCompletionOne',  arguments: {'type': 'Phone Number'});

      //Get.to(() => ProfileCompletionScreenOne(), arguments: {'type': 'Phone Number'});
    });
  }
}

class WhatsAppController extends GetxController {
  var isLoading = false.obs;

  void onWhatsAppButtonPressed(BuildContext context) {
    isLoading.value = true;

    // Simulate async operation
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
                  Navigator.pushNamed(context, '/profileCompletionOne',  arguments: {'type': 'WhatsApp'});

      //Get.to(() => ProfileCompletionScreenOne(), arguments: {'type': 'WhatsApp'});
    });
  }
}
