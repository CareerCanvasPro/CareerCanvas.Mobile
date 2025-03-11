import 'package:career_canvas/core/models/education.dart';
import 'package:career_canvas/core/models/experiance.dart';
import 'package:career_canvas/core/models/profile.dart';
import 'package:career_canvas/core/models/resume.dart';

abstract class UserProfileRepository {
  Future<UserProfileData?> getUserProfile();
  Future<String> addEducation(UploadEducation education);
  Future<String> addExperiance(UploadExperiance experiance);
  Future<String> updateSkills(List<String> experiance);
  Future<String> updateLanguage(List<String> languages);
  Future<String> updateGoals(List<String> goals);
  Future addResume(Resume resume);
  Future<String> updateAboutMe(String aboutMe);
}
