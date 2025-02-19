import 'package:career_canvas/core/models/certificateFile.dart';
import 'package:career_canvas/core/models/education.dart';
import 'package:career_canvas/core/models/experiance.dart';
import 'package:career_canvas/core/models/otpVerificationResponse.dart';
import 'package:career_canvas/core/network/api_client.dart';
import 'package:career_canvas/core/utils/CustomButton.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:dio/dio.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mime/mime.dart';

class CustomDialog {
  static void showCustomDialog(
    BuildContext context, {
    required String title,
    required String content,
    String buttonText = "Ok",
    VoidCallback? onPressed,
    String? button2Text,
    VoidCallback? onPressed2,
  }) {
    showAdaptiveDialog(
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
                        textStyle:
                            getCTATextStyle(context, 16, color: Colors.white),
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Experiance Details",
                style: getCTATextStyle(
                  context,
                  18,
                  color: Colors.black,
                ),
              ),
              Text(
                "Enter your experiance details below.",
                style: getCTATextStyle(
                  context,
                  12,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 20,
              ),
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
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                    borderSide: BorderSide(color: Colors.grey.shade500),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
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
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                    borderSide: BorderSide(color: Colors.grey.shade500),
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
                      Text("From"),
                      if (startDate != null)
                        Text(
                          formatDate(startDate!),
                          style: TextStyle(color: Colors.grey),
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
                        Text("Till Date"),
                        if (endDate != null)
                          Text(
                            formatDate(endDate!),
                            style: TextStyle(color: Colors.grey),
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
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: CustomTextButton(
                title: "Add Experiance",
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  if (formKey.currentState!.validate()) {
                    Experiance experiance = Experiance(
                      designation: designationController.text,
                      from: startDate!.millisecondsSinceEpoch,
                      isCurrent: isCurrentExperiance,
                      organization: organizationNameController.text,
                      to: endDate != null
                          ? endDate!.millisecondsSinceEpoch
                          : null,
                    );
                    widget.onPressedSubmit(experiance);
                  }
                },
                backgroundColor: primaryBlue,
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
                onPressed: () => Get.back(),
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
        "${ApiClient.mediaBase}/media/certificate",
        data: formData,
        options: http.Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            "Authorization": "Bearer $token",
          },
        ),
      );
      debugPrint(response.data['message']);
      certificateFile = UploadedFile.fromMap(response.data['data']['file']);
      print(certificateFile.toString());
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
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    } catch (e) {
      debugPrint(e.toString());
      setState(() {
        imageUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Education Details",
                style: getCTATextStyle(
                  context,
                  18,
                  color: Colors.black,
                ),
              ),
              Text(
                "Enter your education details below.",
                style: getCTATextStyle(
                  context,
                  12,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
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
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                    borderSide: BorderSide(color: Colors.grey.shade500),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
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
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                    borderSide: BorderSide(color: Colors.grey.shade500),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: academicAchievementsController,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                minLines: 1,
                decoration: InputDecoration(
                  hintText: "Academic Achievements",
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                    borderSide: BorderSide(color: Colors.grey.shade500),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: isCurrentEducation,
                    activeColor: primaryBlue,
                    onChanged: (value) {
                      isCurrentEducation = value ?? false;
                      setState(() {});
                    },
                  ),
                  // SizedBox(
                  //   width: 8,
                  // ),
                  Text("Current Education"),
                ],
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
                        title: "Add Certificate",
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
                                  print(result.files.first.path);
                                  await uploadCertifiate(
                                      result.files.first.path!);
                                }
                              },
                        // backgroundColor: primaryBlue,
                        textStyle:
                            getCTATextStyle(context, 16, color: Colors.black),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: CustomTextButton(
                title: "Add Education",
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  if (formKey.currentState!.validate()) {
                    Education education = Education(
                      achievements: academicAchievementsController.text,
                      field: fieldOfEducationController.text,
                      institute: instituteNameController.text,
                      isCurrent: isCurrentEducation,
                      graduationDate: expectedGraduationDate != null
                          ? expectedGraduationDate!.millisecondsSinceEpoch
                          : null,
                      certificate: certificateFile,
                    );
                    widget.onPressedSubmit(education);
                  }
                },
                backgroundColor: primaryBlue,
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
                onPressed: () => Get.back(),
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

class getOTPVerificationDialog extends StatefulWidget {
  final String to;
  final Function(Otpverificationresponse) onPressedSubmit;
  getOTPVerificationDialog({
    super.key,
    required this.to,
    required this.onPressedSubmit,
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
        ApiClient.authBase + "/otp/email/verify?otp=${pin}",
      );
      print(response.data);
      setState(() {
        isLoading = false;
      });
      if (response.data['data'] != null) {
        final otpResponse = Otpverificationresponse.fromMap(
          response.data['data'],
        );
        print(response);
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
