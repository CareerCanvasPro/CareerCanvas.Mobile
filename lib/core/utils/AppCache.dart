import 'package:career_canvas/core/models/profile.dart';
import 'package:career_canvas/features/Career/data/models/CareerTrends.dart';
import 'package:career_canvas/features/Career/data/models/CoursesModel.dart';
import 'package:career_canvas/features/Career/data/models/JobsModel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Appcache {
  static UserProfileData? userProfile;
  static JobsResponseModel? jobs;
  static CoursesResponseModel? courses;
  static CareerTrendResponse? careerTrends;

  static final Appcache _instance = Appcache._internal();
  Appcache._internal();

  factory Appcache() {
    return _instance;
  }
  static Appcache get instance => _instance;
  static late FlutterSecureStorage secureStorage;
  static Future init() async {
    secureStorage = FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock,
      ),
    );
    await getUserProfile();
    await getJobs();
    await getCourses();
    await getCareerTrends();
  }

  static Future<void> setUserProfile(UserProfileData userProfile) async {
    Appcache.userProfile = userProfile;
    await secureStorage.write(key: 'userProfile', value: userProfile.toJson());
  }

  static Future<void> setJobs(JobsResponseModel jobs) async {
    Appcache.jobs = jobs;
    await secureStorage.write(
      key: 'jobs',
      value: jobs.toJson(),
    );
  }

  static Future<void> setCourses(CoursesResponseModel courses) async {
    Appcache.courses = courses;
    await secureStorage.write(
      key: 'courses',
      value: courses.toJson(),
    );
  }

  static Future<void> setCareerTrends(CareerTrendResponse careerTrends) async {
    Appcache.careerTrends = careerTrends;
    await secureStorage.write(
      key: 'careerTrends',
      value: careerTrends.toJson(),
    );
  }

  static Future<UserProfileData?> getUserProfile() async {
    String? userProfileJson = await secureStorage.read(key: 'userProfile');
    if (userProfileJson != null) {
      userProfile = UserProfileData.fromJson(userProfileJson);
    }
    return userProfile;
  }

  static Future<JobsResponseModel?> getJobs() async {
    String? jobsJson = await secureStorage.read(key: 'jobs');
    if (jobsJson != null) {
      jobs = JobsResponseModel.fromJson(jobsJson);
    }
    return jobs;
  }

  static Future<CoursesResponseModel?> getCourses() async {
    String? coursesJson = await secureStorage.read(key: 'courses');
    if (coursesJson != null) {
      courses = CoursesResponseModel.fromJson(coursesJson);
    }
    return courses;
  }

  static Future<CareerTrendResponse?> getCareerTrends() async {
    String? careerTrendsJson = await secureStorage.read(key: 'careerTrends');
    if (careerTrendsJson != null) {
      careerTrends = CareerTrendResponse.fromJson(careerTrendsJson);
    }
    return careerTrends;
  }

  static Future<void> clear() async {
    userProfile = null;
    jobs = null;
    courses = null;
    careerTrends = null;
    await secureStorage.deleteAll();
  }
}
