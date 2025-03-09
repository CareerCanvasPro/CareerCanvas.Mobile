import 'package:career_canvas/core/models/profile.dart';
import 'package:career_canvas/core/network/api_client.dart';
import 'package:career_canvas/src/profile/domain/repository/userprofile_repo.dart';
import 'package:dio/dio.dart';

class UserProfileRepository_API_Impl extends UserProfileRepository {
  final ApiClient apiClient;
  UserProfileRepository_API_Impl(this.apiClient);

  @override
  Future<UserProfileData?> getUserProfile() async {
    try {
      final response = await apiClient.get(
        ApiClient.userBase + '/user/profile',
        useToken: true,
      );
      return UserProfileData.fromMap(response.data['data']);
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        throw Exception(e.response!.data["message"]);
      } else {
        throw Exception(e.message);
      }
    } catch (e) {
      print('Error fetching user profile: $e');
      return null;
    }
  }
}
