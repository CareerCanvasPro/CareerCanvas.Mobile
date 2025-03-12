import 'package:flutter/services.dart';

class FileUriResolver {
  static const MethodChannel _channel = MethodChannel('com.yourapp/file');

  // Method to resolve content URI to file path
  static Future<String> resolveContentUri(Uri uri) async {
    try {
      final String filePath = await _channel.invokeMethod('resolveContentUri', {'uri': uri.toString()});
      return filePath;
    } on PlatformException catch (e) {
      throw Exception("Failed to resolve URI: ${e.message}");
    }
  }
}