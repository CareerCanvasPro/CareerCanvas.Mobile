import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:saver_gallery/saver_gallery.dart';

Future<bool> checkAndRequestPermissions({required bool skipIfExists}) async {
  if (!Platform.isAndroid && !Platform.isIOS) {
    return false; // Only Android and iOS platforms are supported
  }

  if (Platform.isAndroid) {
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    final sdkInt = deviceInfo.version.sdkInt;

    if (skipIfExists) {
      // Read permission is required to check if the file already exists
      return sdkInt >= 33
          ? await Permission.photos.request().isGranted
          : await Permission.storage.request().isGranted;
    } else {
      // No read permission required for Android SDK 29 and above
      return sdkInt >= 29 ? true : await Permission.storage.request().isGranted;
    }
  } else if (Platform.isIOS) {
    // iOS permission for saving images to the gallery
    return skipIfExists
        ? await Permission.photos.request().isGranted
        : await Permission.photosAddOnly.request().isGranted;
  }

  return false; // Unsupported platforms
}

Future<bool> saveToGallery(
  Uint8List bytes, {
  required String fileName,
}) async {
  try {
    if (!await checkAndRequestPermissions(skipIfExists: false)) {
      debugPrint("Permissions not granted");
      return false;
    }
    final result = await SaverGallery.saveImage(
      bytes,
      quality: 60,
      fileName: fileName,
      androidRelativePath: "Pictures/CareerCanvas",
      skipIfExists: false,
    );
    return result.isSuccess;
  } catch (e) {
    debugPrint(e.toString());
    return false;
  }
}
