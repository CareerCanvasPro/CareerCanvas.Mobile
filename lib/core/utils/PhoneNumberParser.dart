import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

class PhoneNumberParser {
  static PhoneNumber? parse(String phoneNumber) {
    try {
      if (phoneNumber.length < 10) throw "Invalid phone number";
      if (!phoneNumber.startsWith('+') && !phoneNumber.startsWith("00")) {
        throw "Not containing any country code";
      }
      var phone = PhoneNumber.parse(phoneNumber);
      return phone;
    } on PhoneNumberException catch (e) {
      debugPrint(e.description.toString());
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static bool isValidSubscriberNumber(String phoneNumber) {
    debugPrint(phoneNumber);
    final RegExp regex = RegExp(r'^[1-9]\d{7,10}$');
    return regex.hasMatch(phoneNumber.replaceAll("-", ""));
  }
}

String formatPhoneNumber(String digits) {
  if (digits.length <= 3) {
    return digits;
  } else if (digits.length <= 6) {
    return '${digits.substring(0, 3)}-${digits.substring(3)}';
  } else {
    return '${digits.substring(0, 3)}-${digits.substring(3, 6)}-${digits.substring(6)}';
  }
}

class PhoneNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String digits =
        newValue.text.replaceAll(RegExp(r'\D'), ''); // Remove non-digits
    String formatted = '';
    formatted = formatPhoneNumber(digits);
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
