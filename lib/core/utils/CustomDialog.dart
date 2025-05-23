import 'package:career_canvas/core/models/certificateFile.dart';
import 'package:career_canvas/core/models/education.dart';
import 'package:career_canvas/core/models/experiance.dart';
import 'package:career_canvas/core/models/otpVerificationResponse.dart';
import 'package:career_canvas/core/network/api_client.dart';
import 'package:career_canvas/core/utils/CustomButton.dart';
import 'package:career_canvas/core/utils/ScreenHeightExtension.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:dio/dio.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mime/mime.dart';

class CustomDialog {
  static Future showCustomDialog(
    BuildContext context, {
    required String title,
    required String content,
    String buttonText = "Ok",
    VoidCallback? onPressed,
    String? button2Text,
    VoidCallback? onPressed2,
  }) async {
    return showAdaptiveDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          scrollable: true,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: getCTATextStyle(context, 24, color: Colors.black),
              ),
              const SizedBox(height: 10),
              Text(
                content,
                textAlign: TextAlign.center,
                style: getBodyTextStyle(context, 16, color: Colors.black),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CustomTextButton(
                      title: buttonText,
                      onPressed: onPressed ?? () => Get.back(),
                      backgroundColor: primaryBlue,
                      textStyle:
                          getCTATextStyle(context, 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
              if (button2Text != null) SizedBox(height: 4),
              if (button2Text != null)
                Row(
                  children: [
                    Expanded(
                      child: CustomTextButton(
                        title: button2Text,
                        onPressed: onPressed2 ?? () => Get.back(),
                        backgroundColor: primaryBlue.withOpacity(0.8),
                        textStyle: getCTATextStyle(
                          context,
                          16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  static Future showCustomOTPDialog(
    BuildContext context, {
    required String to,
    required String username,
    required Function(Otpverificationresponse) onPressedSubmit,
  }) {
    return showAdaptiveDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          scrollable: true,
          content: getOTPVerificationDialog(
            to: to,
            username: username,
            onPressedSubmit: onPressedSubmit,
          ),
        );
      },
    );
  }

  static Future showAddEducationDialog(
    BuildContext context, {
    required Function(Education) onPressedSubmit,
  }) {
    return showAdaptiveDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          scrollable: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          contentPadding: const EdgeInsets.all(0),
          titlePadding: const EdgeInsets.all(0),
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          content: AddEducationDialog(
            onPressedSubmit: onPressedSubmit,
          ),
        );
      },
    );
  }

  static Future showAddExperianceDialog(
    BuildContext context, {
    required Function(Experiance) onPressedSubmit,
  }) {
    return showAdaptiveDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          scrollable: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          contentPadding: const EdgeInsets.all(0),
          titlePadding: const EdgeInsets.all(0),
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          content: AddExperianceDialog(
            onPressedSubmit: onPressedSubmit,
          ),
        );
      },
    );
  }
}

class AddExperianceDialog extends StatefulWidget {
  final Function(Experiance) onPressedSubmit;
  const AddExperianceDialog({
    super.key,
    required this.onPressedSubmit,
  });

  @override
  State<AddExperianceDialog> createState() => _AddExperianceDialogState();
}

class _AddExperianceDialogState extends State<AddExperianceDialog> {
  final formKey = GlobalKey<FormState>();
  bool isCurrentExperiance = false;
  DateTime? startDate;
  DateTime? endDate;
  TextEditingController organizationNameController = TextEditingController();
  TextEditingController designationController = TextEditingController();

  String formatDate(DateTime date) {
    return DateFormat().add_yMMMMd().format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: primaryBlue,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "Experiance Details",
                              style: getCTATextStyle(
                                context,
                                16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Enter your experiance details below.",
                        style: getCTATextStyle(
                          context,
                          12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: organizationNameController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Organization name is required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Organization Name",
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Color(0xFFfb0102),
                            ),
                          ),
                          errorMaxLines: 1,
                          // errorText: '',
                          errorStyle: TextStyle(
                            fontSize: 0,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: primaryBlue,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: primaryBlue,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: primaryBlue,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: designationController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Designation is required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Designation",
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Color(0xFFfb0102),
                            ),
                          ),
                          errorMaxLines: 1,
                          // errorText: '',
                          errorStyle: TextStyle(
                            fontSize: 0,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: primaryBlue,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: primaryBlue,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: primaryBlue,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Joining Date"),
                              if (startDate != null)
                                Text(
                                  formatDate(startDate!),
                                  style: getCTATextStyle(
                                    context,
                                    12,
                                    color: Colors.black,
                                  ),
                                ),
                            ],
                          ),
                          IconButton(
                            onPressed: () async {
                              startDate = await showDatePicker(
                                context: context,
                                initialDate: startDate,
                                firstDate: DateTime(1971),
                                lastDate: DateTime.now(),
                                barrierDismissible: false,
                              );
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.calendar_month_rounded,
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: isCurrentExperiance,
                            activeColor: primaryBlue,
                            onChanged: (value) {
                              isCurrentExperiance = value ?? false;
                              setState(() {});
                            },
                          ),
                          // const SizedBox(width: 4),
                          Text("Current Occupation"),
                        ],
                      ),
                      if (!isCurrentExperiance)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Leaving Date"),
                                if (endDate != null)
                                  Text(
                                    formatDate(endDate!),
                                    style: getCTATextStyle(
                                      context,
                                      12,
                                      color: Colors.black,
                                    ),
                                  ),
                              ],
                            ),
                            IconButton(
                              onPressed: () async {
                                endDate = await showDatePicker(
                                  context: context,
                                  initialDate: endDate,
                                  firstDate: DateTime(1971),
                                  lastDate: DateTime.now(),
                                  barrierDismissible: false,
                                );
                                setState(() {});
                              },
                              icon: Icon(
                                Icons.calendar_month_rounded,
                              ),
                            )
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomTextButton(
                        title: "Add Experiance",
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (startDate == null) {
                            Fluttertoast.showToast(
                              msg: "Please enter Joining date",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              fontSize: 14.0,
                            );
                          } else if (isCurrentExperiance != true &&
                              endDate == null) {
                            Fluttertoast.showToast(
                              msg: "Please enter Leaving date",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              fontSize: 14.0,
                            );
                          } else if (formKey.currentState!.validate()) {
                            Experiance experiance = Experiance(
                              id: UniqueKey().toString(),
                              designation: designationController.text,
                              startDate: startDate!,
                              isCurrent: isCurrentExperiance,
                              organization: organizationNameController.text,
                              endDate: endDate,
                            );
                            widget.onPressedSubmit(experiance);
                          }
                        },
                        backgroundColor: primaryBlue,
                        textStyle:
                            getCTATextStyle(context, 14, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: CustomOutlinedButton(
                        title: "Cancel",
                        onPressed: () => Get.back(),
                        color: primaryBlue,
                        textStyle: getCTATextStyle(
                          context,
                          14,
                          color: primaryBlue,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AddEducationDialog extends StatefulWidget {
  final Function(Education) onPressedSubmit;
  const AddEducationDialog({
    super.key,
    required this.onPressedSubmit,
  });

  @override
  State<AddEducationDialog> createState() => _AddEducationDialogState();
}

class _AddEducationDialogState extends State<AddEducationDialog> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController instituteNameController = TextEditingController();
  final TextEditingController graduationDateController =
      TextEditingController();
  final TextEditingController fieldOfEducationController =
      TextEditingController();
  final TextEditingController academicAchievementsController =
      TextEditingController();
  bool isCurrentEducation = false;
  DateTime? expectedGraduationDate;
  UploadedFile? certificateFile;

  bool imageUploading = false;

  String formatDate(DateTime date) {
    return DateFormat().add_yMMMMd().format(date);
  }

  uploadCertifiate(String filePath) async {
    try {
      final dio = http.Dio(
        http.BaseOptions(
          baseUrl: ApiClient.mediaBase,
          connectTimeout: const Duration(seconds: 3000),
          receiveTimeout: const Duration(seconds: 3000),
        ),
      );
      String fileName = filePath.split('/').last;
      String type = lookupMimeType(fileName) ?? "image/jpeg";
      http.FormData formData = http.FormData.fromMap(
        {
          "file": await http.MultipartFile.fromFile(
            filePath,
            filename: fileName,
            contentType: http.DioMediaType.parse(type),
          ),
        },
      );
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token') ?? '';

      final response = await dio.post(
        "${ApiClient.userBase}/certificate",
        data: formData,
        options: http.Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            "Authorization": "Bearer $token",
          },
        ),
      );
      // debugPrint(response.data['message']);
      certificateFile = UploadedFile.fromMap(response.data['data']['file']);
      // print(certificateFile.toString());
      setState(() {
        imageUploading = false;
      });
    } on http.DioException catch (e) {
      setState(() {
        imageUploading = false;
      });
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        debugPrint(e.response!.data);
        debugPrint(e.response!.headers.toString());
        debugPrint(e.response!.requestOptions.toString());
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        debugPrint(e.requestOptions.toString());
        debugPrint(e.message);
      }
    } catch (e) {
      // debugPrint(e.toString());
      setState(() {
        imageUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: primaryBlue,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Education Details",
                              style: getCTATextStyle(
                                context,
                                16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Enter your education details below.",
                        style: getCTATextStyle(
                          context,
                          12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                        child: TextFormField(
                          controller: instituteNameController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Institute name is required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Institute Name",
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Color(0xFFfb0102),
                              ),
                            ),
                            errorMaxLines: 1,
                            // errorText: '',
                            errorStyle: TextStyle(
                              fontSize: 0,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: primaryBlue,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: primaryBlue,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: primaryBlue,
                              ),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 14,
                            height: 1,
                            color: Colors.black,
                          ),
                          cursorColor: primaryBlue,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 40,
                        child: TextFormField(
                          controller: fieldOfEducationController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field of education is required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Field of Education",
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Color(0xFFfb0102),
                              ),
                            ),
                            errorMaxLines: 1,
                            // errorText: '',
                            errorStyle: TextStyle(
                              fontSize: 0,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: primaryBlue,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: primaryBlue,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: primaryBlue,
                              ),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 14,
                            height: 1,
                            color: Colors.black,
                          ),
                          cursorColor: primaryBlue,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 40,
                        child: TextFormField(
                          controller: academicAchievementsController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          minLines: 1,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Academic Achievements is required";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Academic Achievements",
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Color(0xFFfb0102),
                              ),
                            ),
                            errorMaxLines: 1,
                            // errorText: '',
                            errorStyle: TextStyle(
                              fontSize: 0,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: primaryBlue,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: primaryBlue,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: primaryBlue,
                              ),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 14,
                            height: 1,
                            color: Colors.black,
                          ),
                          cursorColor: primaryBlue,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      if (certificateFile != null)
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Certificate.${extensionFromMime(certificateFile!.type)}",
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  certificateFile = null;
                                });
                              },
                              icon: Icon(
                                Icons.delete_forever_rounded,
                              ),
                            ),
                          ],
                        ),
                      if (certificateFile == null)
                        Row(
                          children: [
                            Expanded(
                              child: CustomOutlinedButton(
                                title: "Upload Certificate",
                                onPressed: imageUploading
                                    ? null
                                    : () async {
                                        FilePickerResult? result =
                                            await FilePicker.platform.pickFiles(
                                          type: FileType.custom,
                                          allowedExtensions: [
                                            'pdf',
                                            'png',
                                            'jpg',
                                            "jpeg",
                                            "heic",
                                            "webp"
                                          ],
                                          dialogTitle: 'Upload Certificate',
                                        );
                                        if (result != null) {
                                          // print(result.files.first.path);
                                          await uploadCertifiate(
                                              result.files.first.path!);
                                        }
                                      },
                                // backgroundColor: primaryBlue,

                                textStyle: getCTATextStyle(
                                  context,
                                  14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 4,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Expected Graduation Date"),
                              if (expectedGraduationDate != null)
                                Text(
                                  formatDate(expectedGraduationDate!),
                                  style: TextStyle(color: Colors.grey),
                                ),
                            ],
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () async {
                              expectedGraduationDate = await showDatePicker(
                                context: context,
                                initialDate: expectedGraduationDate,
                                currentDate: DateTime.now(),
                                firstDate: DateTime(1971),
                                lastDate: DateTime(2071),
                                barrierDismissible: false,
                              );
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.calendar_month_rounded,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          isCurrentEducation = !isCurrentEducation;
                          setState(() {});
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 16,
                              child: Checkbox(
                                value: isCurrentEducation,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                activeColor: primaryBlue,
                                onChanged: (value) {
                                  isCurrentEducation = !isCurrentEducation;
                                  setState(() {});
                                },
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text("Current Education"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomTextButton(
                        title: "Add Education",
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (certificateFile == null) {
                            Fluttertoast.showToast(
                              msg: "Please upload certificate",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              fontSize: 14.0,
                            );
                          } else if (isCurrentEducation != true &&
                              expectedGraduationDate == null) {
                            Fluttertoast.showToast(
                              msg: "Please enter expected graduation date",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              fontSize: 14.0,
                            );
                          } else if (formKey.currentState!.validate()) {
                            Education education = Education(
                              id: UniqueKey().toString(),
                              achievements: academicAchievementsController.text,
                              field: fieldOfEducationController.text,
                              institute: instituteNameController.text,
                              isCurrent: isCurrentEducation,
                              graduationDate: expectedGraduationDate,
                              certificate: certificateFile,
                            );
                            widget.onPressedSubmit(education);
                          }
                        },
                        backgroundColor: primaryBlue,
                        textStyle: getCTATextStyle(
                          context,
                          14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: CustomOutlinedButton(
                        title: "Cancel",
                        onPressed: () => Get.back(),
                        color: primaryBlue,
                        textStyle: getCTATextStyle(
                          context,
                          14,
                          color: primaryBlue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class getOTPVerificationDialog extends StatefulWidget {
  final String to;
  final String username;
  final Function(Otpverificationresponse) onPressedSubmit;
  getOTPVerificationDialog({
    super.key,
    required this.to,
    required this.onPressedSubmit,
    required this.username,
  });

  @override
  State<getOTPVerificationDialog> createState() =>
      _getOTPVerificationDialogState();
}

class _getOTPVerificationDialogState extends State<getOTPVerificationDialog> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  Future<void> onPressedSubmit(String pin) async {
    try {
      setState(() {
        isLoading = true;
      });
      ApiClient apiClient = ApiClient(
        http.Dio(
          http.BaseOptions(
            baseUrl: ApiClient.authBase,
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            validateStatus: (status) {
              return status! < 500;
            },
          ),
        ),
      );

      final response = await apiClient.get(
        ApiClient.authBase + "/otp/verify?otp=${pin}&username=${widget.to}", //
      );
      // print(response.data);
      setState(() {
        isLoading = false;
      });
      if (response.data['data'] != null) {
        final otpResponse = Otpverificationresponse.fromMap(
          response.data['data'],
        );
        // print(response);
        widget.onPressedSubmit(
          otpResponse,
        );
      } else {
        throw response.data['message'] ?? "Something went wrong";
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.toString());
    }
  }

  final pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    final fillColor = Color.fromRGBO(243, 246, 249, 0);
    final borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Enter OTP",
          textAlign: TextAlign.center,
          style: getCTATextStyle(context, 24, color: Colors.black),
        ),
        const SizedBox(height: 10),
        Text(
          "Otp sent to ${widget.to}",
          textAlign: TextAlign.center,
          style: getBodyTextStyle(context, 16, color: Colors.black),
        ),
        const SizedBox(height: 10),
        Form(
          key: formKey,
          child: Row(
            children: [
              Expanded(
                child: Pinput(
                  length: 6,
                  controller: pinController,
                  defaultPinTheme: defaultPinTheme,
                  separatorBuilder: (index) => const SizedBox(width: 8),
                  validator: (value) {
                    return value != null && value.length == 6
                        ? null
                        : 'Pin is invalid';
                  },
                  hapticFeedbackType: HapticFeedbackType.lightImpact,
                  onCompleted: onPressedSubmit,
                  onChanged: (value) {
                    debugPrint('onChanged: $value');
                  },
                  cursor: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 9),
                        width: 22,
                        height: 1,
                        color: focusedBorderColor,
                      ),
                    ],
                  ),
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: focusedBorderColor),
                    ),
                  ),
                  submittedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      color: fillColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: focusedBorderColor),
                    ),
                  ),
                  errorPinTheme: defaultPinTheme.copyBorderWith(
                    border: Border.all(color: Colors.redAccent),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: CustomTextButton(
                title: "Submit",
                onPressed: isLoading
                    ? null
                    : () async {
                        if (formKey.currentState!.validate()) {
                          await onPressedSubmit(pinController.text);
                        }
                      },
                backgroundColor: isLoading ? Colors.grey : primaryBlue,
                textStyle: getCTATextStyle(context, 16, color: Colors.white),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: CustomTextButton(
                title: "Cancel",
                onPressed: isLoading ? null : () => Get.back(),
                backgroundColor: primaryBlue.withOpacity(0.8),
                textStyle: getCTATextStyle(context, 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
