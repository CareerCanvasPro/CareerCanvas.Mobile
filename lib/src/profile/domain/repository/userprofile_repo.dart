import 'package:career_canvas/core/models/profile.dart';

abstract class UserProfileRepository {
  Future<UserProfileData?> getUserProfile();
}
