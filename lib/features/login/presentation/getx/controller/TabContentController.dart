import 'package:career_canvas/core/Dependencies/setupDependencies.dart';
import 'package:career_canvas/core/network/api_client.dart';
import 'package:career_canvas/src/profile/presentation/getx/controllers/user_profile_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum EmailLoginType {
  Otp,
  MagicLink,
}

class EmailController extends GetxController {
  var isLoading = false.obs;
  var isSecondaryLoading = false.obs;
  TextEditingController emailController = TextEditingController();

  void onEmailButtonPressed(
    BuildContext context, {
    EmailLoginType type = EmailLoginType.Otp,
    required Function(String?) onDone,
    required Function(String) onError,
    required GlobalKey<FormState> formKey,
  }) async {
    if (type == EmailLoginType.MagicLink) {
      isSecondaryLoading.value = true;
    } else {
      isLoading.value = true;
    }

    try {
      if (getIt<UserProfileController>().isOnline.value == false) {
        throw "You Are Offline";
      }
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
        "${ApiClient.authBase}${type == EmailLoginType.Otp ? "/otp/request/email" : "/magic-link/request"}",
        data: {
          'email': emailController.text,
        },
      );
      debugPrint(response.data['message']);
      if (response.data['message'].toString().isNotEmpty) {
        if (type == EmailLoginType.MagicLink) {
          isSecondaryLoading.value = false;
        } else {
          isLoading.value = false;
        }
        onDone(response.data['message'].toString());
      } else {
        throw "Failed to send. Please try again.";
      }
    } on DioException catch (e) {
      if (type == EmailLoginType.MagicLink) {
        isSecondaryLoading.value = false;
      } else {
        isLoading.value = false;
      }

      if (e.response != null) {
        var responseData = e.response!.data;

        // Check if responseData is a Map (expected JSON)
        if (responseData is Map<String, dynamic> &&
            responseData.containsKey("message")) {
          onError(responseData["message"].toString());
        }
        // If responseData is a String, return it directly
        else if (responseData is String) {
          onError(responseData);
        }
        // Handle unexpected response format
        else {
          onError("Unexpected error format");
        }
      } else {
        onError(e.message ?? "Problem occurred");
      }
    } catch (e) {
      if (type == EmailLoginType.MagicLink) {
        isSecondaryLoading.value = false;
      } else {
        isLoading.value = false;
      }
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
