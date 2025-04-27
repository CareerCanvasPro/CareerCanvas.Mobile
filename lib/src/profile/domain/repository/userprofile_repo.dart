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
  Future<String> updateInterest(List<String> interests);
  Future<String> updateGoals(List<String> goals);
  Future<String> deleteResume(Resume resume);
  Future<String> deleteEducation(Education education);
  Future<String> deleteExperiance(Experiance experiance);
  Future addResume(Resume resume);
  Future<String> updateAboutMe(String aboutMe);
}
