import 'package:career_canvas/core/network/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailController extends GetxController {
  var isLoading = false.obs;
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void onEmailButtonPressed(
    BuildContext context, {
    required Function(String?) onDone,
    required Function(String) onError,
  }) async {
    isLoading.value = true;

    try {
      if (emailController.text.isEmpty) {
        throw 'Email is required';
      }
      if (!formKey.currentState!.validate()) {
        throw 'Please enter valid email';
      }
      ApiClient apiClient = ApiClient(
        Dio(
          BaseOptions(
            baseUrl: ApiClient.authBase,
            connectTimeout: const Duration(seconds: 5),
            receiveTimeout: const Duration(seconds: 5),
          ),
        ),
      );

      final response = await apiClient.post(
        ApiClient.authBase + "/auth-otp",
        data: {
          'email': emailController.text,
        },
      );
      debugPrint(response.data['message']);
      if (response.data['message'].toString().isNotEmpty) {
        isLoading.value = false;
        onDone(response.data['message'].toString());
      } else {
        throw "Failed to send otp";
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
      onError(e.toString());
    }
  }
}

class PhoneNumberController extends GetxController {
  var isLoading = false.obs;
  TextEditingController phoneNumberController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void onPhoneNumberButtonPressed(BuildContext context) {
    isLoading.value = true;

    // Simulate async operation
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
      Navigator.pushNamed(context, '/profileCompletionOne',
          arguments: {'type': 'Phone Number'});

      //Get.to(() => ProfileCompletionScreenOne(), arguments: {'type': 'Phone Number'});
    });
  }
}

class WhatsAppController extends GetxController {
  var isLoading = false.obs;
  TextEditingController whatsAppController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void onWhatsAppButtonPressed(BuildContext context) {
    isLoading.value = true;

    // Simulate async operation
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
      Navigator.pushNamed(context, '/HomePage',
          arguments: {'type': 'WhatsApp'});

      //Get.to(() => ProfileCompletionScreenOne(), arguments: {'type': 'WhatsApp'});
    });
  }
}
