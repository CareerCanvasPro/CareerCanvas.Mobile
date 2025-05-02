// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

import 'package:career_canvas/core/Dependencies/setupDependencies.dart';
import 'package:career_canvas/core/network/api_client.dart';
import 'package:career_canvas/core/utils/TokenInfo.dart';
import 'package:career_canvas/src/constants.dart';

class ProfileUpload {
  String profilePicture;
  ProfileUpload({
    required this.profilePicture,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'profilePicture': profilePicture,
    };
  }

  factory ProfileUpload.fromMap(Map<String, dynamic> map) {
    return ProfileUpload(
      profilePicture: map['profilePicture'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileUpload.fromJson(String source) =>
      ProfileUpload.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ProfileSettingsController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool imageUploading = false.obs;
  String? errorMessage;
  RxBool isPrivate = false.obs;

  Future<void> updateProfilePrivacy(bool private) async {
    isPrivate.value = private;
    try {
      final apiClient = getIt<ApiClient>();
      await apiClient.put(
        ApiClient.userBase + '/profile-privacy',
        data: {
          "isPrivate": isPrivate,
        },
        useToken: true,
      );
      Fluttertoast.showToast(
        msg: "Updated your profile privacy.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 14.0,
      );
    } on dio.DioException catch (e) {
      isPrivate.value = !private;
      if (e.response != null) {
        Fluttertoast.showToast(
          msg: e.response!.data["message"],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          fontSize: 14.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: e.message ?? e.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          fontSize: 14.0,
        );
      }
    } catch (e) {
      isPrivate.value = !private;
      Fluttertoast.showToast(
        msg: "Failed to update profile privacy: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 14.0,
      );
    }
  }

  Future<void> updateProfileImageToProfile(String url) async {
    try {
      final apiClient = getIt<ApiClient>();
      await apiClient.put(
        ApiClient.userBase + '/profile-picture',
        data: ProfileUpload(profilePicture: url).toJson(),
        useToken: true,
      );
      Fluttertoast.showToast(
        msg: "Updated your profile image.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 14.0,
      );
    } on dio.DioException catch (e) {
      if (e.response != null) {
        Fluttertoast.showToast(
          msg: e.response!.data["message"],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          fontSize: 14.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: e.message ?? e.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          fontSize: 14.0,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to update profile image: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 14.0,
      );
    }
  }

  Future<void> uploadProfileImage(BuildContext context) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: primaryBlue,
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: true,
            cropStyle: CropStyle.rectangle,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
            ],
            hideBottomControls: true,
          ),
          IOSUiSettings(
            title: 'Cropper',
            aspectRatioLockEnabled: true,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
            ],
            aspectRatioPickerButtonHidden: true,
            hidesNavigationBar: true,
          ),
          WebUiSettings(
            context: context,
          ),
        ],
      );
      if (croppedFile != null) {
        try {
          imageUploading.value = true;
          final dioApi = dio.Dio(
            dio.BaseOptions(
              baseUrl: ApiClient.mediaBase,
              connectTimeout: const Duration(seconds: 3000),
              receiveTimeout: const Duration(seconds: 3000),
            ),
          );
          String fileName = croppedFile.path.split('/').last;
          dio.FormData formData = dio.FormData.fromMap(
            {
              "file": await dio.MultipartFile.fromFile(
                croppedFile.path,
                filename: fileName,
                contentType: dio.DioMediaType.parse(
                    lookupMimeType(basename(croppedFile.path)) ?? 'image/jpeg'),
              ),
            },
          );

          final response = await dioApi.put(
            "${ApiClient.userBase}/profile-picture/upload",
            data: formData,
            options: dio.Options(
              headers: {
                'Content-Type': 'multipart/form-data',
                "Authorization": "Bearer ${TokenInfo.token}",
              },
            ),
          );
          String? imageUrl = response.data['data']['url'];
          if (imageUrl != null) {
            await CachedNetworkImage.evictFromCache(imageUrl);
            await updateProfileImageToProfile(imageUrl);
          }
          imageUploading.value = false;
        } on dio.DioException catch (e) {
          imageUploading.value = false;
          // The request was made and the server responded with a status code
          // that falls out of the range of 2xx and is also not 304.
          if (e.response != null) {
            Fluttertoast.showToast(
              msg: e.response!.data["message"],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              fontSize: 14.0,
            );
          } else {
            Fluttertoast.showToast(
              msg: e.message ?? e.toString(),
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              fontSize: 14.0,
            );
          }
        } catch (e) {
          imageUploading.value = false;
          Fluttertoast.showToast(
            msg: e.toString(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            fontSize: 14.0,
          );
        }
      }
    }
  }
}
