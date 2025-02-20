// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:career_canvas/core/models/profile.dart';

class MainRouteData {
  String initialRoute;
  UserProfileData? userProfile;
  MainRouteData({
    required this.initialRoute,
    this.userProfile,
  });
}
