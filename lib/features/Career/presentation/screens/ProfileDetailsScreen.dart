import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:career_canvas/core/models/personalityInfo.dart';
import 'package:career_canvas/core/models/profile.dart';
import 'package:career_canvas/core/utils/CustomButton.dart';
import 'package:career_canvas/core/utils/SaveToGallery.dart';
import 'package:career_canvas/core/utils/ScreenHeightExtension.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';

class ProfileDetailsScreen extends StatefulWidget {
  static const String routeName = "/profileDetailsScreen";
  final UserProfileData userProfile;
  const ProfileDetailsScreen({
    super.key,
    required this.userProfile,
  });

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  String formatNumber(num value) {
    if (value >= 1e9) {
      return '${(value / 1e9).toStringAsFixed(1)}B'; // Billion
    } else if (value >= 1e6) {
      return '${(value / 1e6).toStringAsFixed(1)}M'; // Million
    } else if (value >= 1e3) {
      return '${(value / 1e3).toStringAsFixed(1)}K'; // Thousand
    } else {
      return value.toString(); // No formatting needed
    }
  }

  GlobalKey globalKey = GlobalKey();

  // Future<void> _capturePng() async {
  //   RenderRepaintBoundary boundary =
  //       globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  //   ui.Image image = await boundary.toImage();
  //   ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //   Uint8List pngBytes = byteData!.buffer.asUint8List();
  //   // print(pngBytes);
  // }

  bool isSavingImage = false;
  void _savePng() async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    // save to gallery
    final result = await saveToGallery(pngBytes, fileName: "cc_profile.png");
    if (result) {
      Fluttertoast.showToast(
        msg: "Image saved to gallery",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 14.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Failed to save image to gallery",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 14.0,
      );
    }
  }

  bool isSharingImage = false;
  void _sharePng() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      String androidLink =
          "https://play.google.com/store/apps/details?id=pro.careercanvas.app";
      //TODO: Add iOS link
      String iosLink =
          "https://apps.apple.com/us/app/career-canvas/id1601239870";
      String webLink = "https://careercanvas.pro";
      String appLink = "";
      if (Platform.isAndroid) {
        appLink = androidLink;
      } else if (Platform.isIOS) {
        appLink = iosLink;
      } else {
        appLink = webLink;
      }

      final result = await Share.shareXFiles(
        [
          XFile.fromData(
            pngBytes,
            mimeType: 'image/png',
            name: 'cc_profile.png',
          ),
        ],
        text: "Check out Career Canvas App. $appLink",
        subject: 'Look what I found on Career Canvas',
        sharePositionOrigin: Rect.fromLTWH(0, 0, 100, 100),
        fileNameOverrides: [
          "cc_profile.png",
        ],
      );
      debugPrint(result.raw);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        toolbarHeight: 0,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(child: Container()),
              IconButton(
                color: Colors.white,
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.cancel_rounded,
                ),
              ),
            ],
          ),
          Spacer(),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: RepaintBoundary(
              key: globalKey,
              child: Container(
                decoration: BoxDecoration(
                  color: primaryBlue,
                  // borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IgnorePointer(
                        child: Image.asset(
                          "assets/icons/cc_bg.png",
                          width: context.screenWidth,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    Container(
                      height: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 24),
                          Hero(
                            tag: "profileImage",
                            child: Container(
                              height: 100,
                              width: 100,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.5,
                                  strokeAlign: BorderSide.strokeAlignOutside,
                                ),
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    widget.userProfile.profilePicture,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.userProfile.name,
                                  textAlign: TextAlign.center,
                                  style: getCTATextStyle(
                                    context,
                                    16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.userProfile.address,
                                  textAlign: TextAlign.center,
                                  style: getCTATextStyle(
                                    context,
                                    12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Followers: " +
                                    formatNumber(widget.userProfile.followers),
                                textAlign: TextAlign.center,
                                style: getCTATextStyle(
                                  context,
                                  12,
                                  color: Colors.white,
                                ),
                              ),
                              // SizedBox(width: 8),
                              Text(
                                "Following: " +
                                    formatNumber(widget.userProfile.following),
                                textAlign: TextAlign.center,
                                style: getCTATextStyle(
                                  context,
                                  12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child:
                                    (widget.userProfile.personalityTestResult !=
                                            null)
                                        ? Text(
                                            "${PersonalityType.getType(widget.userProfile.personalityTestResult?.type ?? "")?.name ?? ""} "
                                            "(${PersonalityType.getType(widget.userProfile.personalityTestResult?.type ?? "")?.category ?? ""})",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          )
                                        : Text(
                                            "\"No Personality Info\"",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                              ),
                            ],
                          ),
                          if (widget.userProfile.personalityTestResult != null)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${PersonalityType.getType(widget.userProfile.personalityTestResult?.type ?? "")?.description ?? ""} ",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Spacer(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 8,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // const SizedBox(width: 8),
                Expanded(
                  child: CustomTextButton(
                    onPressed: _savePng,
                    backgroundColor: Colors.white,
                    textStyle: getCTATextStyle(
                      context,
                      12,
                      color: primaryBlue,
                    ),
                    title: "Save",
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: CustomOutlinedButton(
                    onPressed: _sharePng,
                    color: primaryBlue,
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1,
                    ),
                    textStyle: getCTATextStyle(context, 12),
                    title: "Share",
                  ),
                ),
                // const SizedBox(width: 8),
              ],
            ),
          )
        ],
      ),
    );
  }
}
