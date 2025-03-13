import 'package:career_canvas/core/models/onBoardingOne.dart';
import 'package:career_canvas/core/network/api_client.dart';
import 'package:career_canvas/core/utils/AppColors.dart';
import 'package:career_canvas/core/utils/CustomDialog.dart';
import 'package:career_canvas/core/utils/PhoneNumberParser.dart';
import 'package:career_canvas/core/utils/TokenInfo.dart';
import 'package:career_canvas/features/login/presentation/screens/ProfileCompletionScreenTwo.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:country_picker/country_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' as getIt;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileCompletionScreenOne extends StatefulWidget {
  ProfileCompletionScreenOne({
    super.key,
  });

  static const String routeName = '/profileCompletionOne';

  @override
  State<ProfileCompletionScreenOne> createState() =>
      _ProfileCompletionScreenOneState();
}

class _ProfileCompletionScreenOneState
    extends State<ProfileCompletionScreenOne> {
  // Controllers for input fields
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  bool imageUploading = false;
  String imageUrl = '';

  bool isUploadingData = false;

  Future<void> _pickImage() async {
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
          setState(() {
            imageUploading = true;
          });
          final dio = Dio(
            BaseOptions(
              baseUrl: ApiClient.mediaBase,
              connectTimeout: const Duration(seconds: 3000),
              receiveTimeout: const Duration(seconds: 3000),
            ),
          );
          String fileName = croppedFile.path.split('/').last;
          print(fileName);
          FormData formData = FormData.fromMap(
            {
              "file": await MultipartFile.fromFile(
                croppedFile.path,
                filename: fileName,
                contentType: DioMediaType.parse("image/jpeg"),
              ),
            },
          );
          final prefs = await SharedPreferences.getInstance();
          String token = prefs.getString('token') ?? '';

          final response = await dio.post(
            "${ApiClient.mediaBase}/media/profile-picture",
            data: formData,
            options: Options(
              headers: {
                'Content-Type': 'multipart/form-data',
                "Authorization": "Bearer $token",
              },
            ),
          );
          debugPrint(response.data['message']);
          setState(() {
            imageUploading = false;
            imageUrl = response.data['data']['url'];
          });
        } on DioException catch (e) {
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
    }
    // if (pickedFile != null) {
    //   final prefs = await SharedPreferences.getInstance();
    //   await prefs.setString('imagePath', pickedFile.path);
    //   setState(() {
    //     _imagePath = pickedFile.path;
    //   });
    // }
  }

  Map<String, dynamic> arguments = {};
  @override
  void initState() {
    super.initState();
    // run after ui build
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getExistingData(); // Add one initial experience section
    });
  }

  String type = "Unknown";

  getExistingData() {
    type = TokenInfo.type;
    if (type == "Email") {
      emailController.text = TokenInfo.username;
    } else {
      String phoneNumber = TokenInfo.username;
      PhoneNumber? phone = PhoneNumberParser.parse(phoneNumber);
      if (phone != null) {
        countryCode = phone.isoCode.name;
        phoneNumber = phone.nsn;
        phoneCode = "+${phone.countryCode}";
      }
      mobileController.text = phoneNumber;
    }
    setState(() {});
  }

  final Map<String, String?> uploadedFiles = {};

  String countryCode = 'BD';
  String phoneCode = "+880";

  Widget _buildEducationCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 6.0),
      decoration: BoxDecoration(
        color: scaffoldBackgroundColor,
        // color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image
            Center(child: buildProfileImage()),
            const SizedBox(height: 16),
            // Input Fields with Controllers
            _buildTextField('Full Name', fullNameController),
            // const SizedBox(height: 10),
            // _buildTextField('Date of Birth', controllers['dob']! ),
            const SizedBox(height: 10),
            _buildTextField('Present Address', addressController),
            const SizedBox(height: 10),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a valid phone number";
                } else if (!PhoneNumberParser.isValidSubscriberNumber(value)) {
                  return "Please enter a valid phone number";
                } else {
                  return null;
                }
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
                PhoneNumberInputFormatter(),
              ],
              enabled: (TokenInfo.type == 'Email'),
              controller: mobileController,
              autofocus: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                isDense: true,
                hintText: "1XXXXXXXXX",
                // contentPadding: const EdgeInsets.symmetric(
                //   horizontal: 16,
                //   vertical: 8,
                // ),
                prefixIconConstraints: BoxConstraints(
                  maxHeight: 55,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: GestureDetector(
                    onTap: () async {
                      showCountryPicker(
                        context: context,
                        favorite: ["BD", "US"],
                        showPhoneCode: true,
                        onSelect: (Country country) {
                          countryCode = country.countryCode;
                          phoneCode = "+${country.phoneCode}";
                          setState(() {});
                        },
                      );
                    },
                    child: Text(
                      phoneCode,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                labelStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  borderSide: const BorderSide(
                    color: AppColors.secondaryColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  borderSide: const BorderSide(color: AppColors.secondaryColor),
                ),
              ),
            ),
            // _buildTextField(
            //   'Phone',
            //   mobileController,
            //   isEnabled: !(type == 'Phone'),
            // ),
            const SizedBox(height: 10),
            _buildTextField(
              'Email',
              emailController,
              isEnabled: !(type == 'Email'),
            ),
            const SizedBox(height: 10),
            // _buildTextField('Contact Information', controllers['contactInfo']! ),
            // const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is removed from the widget tree
    fullNameController.dispose();
    addressController.dispose();
    mobileController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo
            Center(
              child: SvgPicture.asset(
                "assets/svg/Career_Canvas_Logo_black.svg",
                height: 50,
                fit: BoxFit.fitHeight,
              ),
            ),
            const SizedBox(height: 16),
            // Progress Bar
            buildProgressBar(progress: 0.2),
            const SizedBox(height: 16),
            // Welcome Text
            const Text(
              'Hello! Complete your profile to onboard',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            _buildEducationCard(),
            // const SizedBox(height: 4),
            // Footer
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget buildProgressBar({required double progress}) {
    return Row(
      children: [
        Expanded(
          child: LinearPercentIndicator(
            lineHeight: 10,
            animation: true,
            percent: progress,
            backgroundColor: Colors.grey.shade300,
            progressColor: primaryBlue,
            barRadius: Radius.circular(10),
          ),
        ),
      ],
    );
  }

  Widget buildProfileImage() {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: _pickImage, // Pick image when tapped
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            clipBehavior: Clip.antiAlias,
            child: imageUploading == true
                ? Center(
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        primaryBlue,
                      ),
                    ),
                  )
                : imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      )
                    : const Icon(
                        Icons.person, // Default icon if no image is set
                        size: 50,
                        color: Colors.grey,
                      ),
          ),
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: GestureDetector(
            onTap: _pickImage,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.grey,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    String hintText,
    TextEditingController controller, {
    bool isEnabled = true,
  }) {
    return TextField(
      controller: controller,
      enabled: isEnabled,
      decoration: InputDecoration(
        hintText: hintText,
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
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // const Text(
          //   'Earn 5 coins',
          //   style: TextStyle(color: Colors.green, fontSize: 14),
          // ),
          SvgPicture.asset(
            'assets/svg/icons/icon_coin_5.svg',
          ),
          Expanded(
            child: Row(
              children: [
                // TextButton(
                //   onPressed: () {},
                //   child: const Text(
                //     'Skip',
                //     style: TextStyle(color: primaryBlue, fontSize: 16),
                //   ),
                // ),
                SizedBox(
                  width: 10,
                ),
                // ElevatedButton(
                //   onPressed: isUploadingData
                //       ? null
                //       : () {
                //           // Action for skip button
                //           debugPrint("Skip button clicked");
                //           Navigator.pushNamed(
                //             context,
                //             ProfileCompletionScreenTwo.routeName,
                //           );
                //         },
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: scaffoldBackgroundColor,
                //     side: BorderSide(color: primaryBlue),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(24.0),
                //     ),
                //     minimumSize: const Size(80, 48),
                //   ),
                //   child: Text(
                //     'Skip',
                //     style: getCTATextStyle(
                //       context,
                //       16,
                //       color: primaryBlue,
                //     ),
                //   ),
                // ),
                Expanded(child: Container()),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: isUploadingData
                      ? null
                      : () async {
                          FocusScope.of(context).unfocus();
                          // final allValues = _getAllEducationValues();
                          // print(allValues);
                          // Example: Access user inputs
                          debugPrint(
                            "phoneNumber: " +
                                phoneCode +
                                mobileController.text.replaceAll("-", ""),
                          );
                          Onboardingone onboardingone = Onboardingone(
                            profilePicture: imageUrl,
                            name: fullNameController.text,
                            phone: phoneCode +
                                mobileController.text.replaceAll("-", ""),
                            address: addressController.text,
                            email: emailController.text,
                          );
                          try {
                            setState(() {
                              isUploadingData = true;
                            });
                            final dio = Dio(
                              BaseOptions(
                                baseUrl: ApiClient.userBase,
                                connectTimeout: const Duration(seconds: 3000),
                                receiveTimeout: const Duration(seconds: 3000),
                              ),
                            );
                            await dio.post(
                              "${ApiClient.userBase}/user/profile",
                              data: onboardingone.toJson(),
                              options: Options(
                                headers: {
                                  'Content-Type': "application/json",
                                  "Authorization": "Bearer ${TokenInfo.token}",
                                },
                              ),
                            );
                            setState(() {
                              isUploadingData = false;
                            });
                            // Navigator.pushNamed(context, '/profileCompletiontwo');
                            getIt.Get.to(
                              () => ProfileCompletionScreenTwo(),
                            );
                          } on DioException catch (e) {
                            setState(() {
                              isUploadingData = false;
                            });
                            // The request was made and the server responded with a status code
                            // that falls out of the range of 2xx and is also not 304.
                            if (e.response != null) {
                              print(e.response!.data["message"]);
                              print(e.response!.headers);
                              print(e.response!.requestOptions);
                              CustomDialog.showCustomDialog(
                                context,
                                title: "Error",
                                content: e.response!.data["message"].toString(),
                              );
                            } else {
                              // Something happened in setting up or sending the request that triggered an Error
                              print(e.requestOptions);
                              print(e.message);
                              CustomDialog.showCustomDialog(
                                context,
                                title: "Error",
                                content: e.message.toString(),
                              );
                            }
                          } catch (e) {
                            debugPrint(e.toString());
                            setState(() {
                              isUploadingData = false;
                            });
                            CustomDialog.showCustomDialog(
                              context,
                              title: "Error",
                              content: e.toString(),
                            );
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isUploadingData ? Colors.grey : primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    minimumSize: const Size(80, 48),
                  ),
                  child: Text(
                    'Next',
                    style: getCTATextStyle(context, 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
