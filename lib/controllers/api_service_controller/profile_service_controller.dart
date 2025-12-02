import 'package:baithuzakath_app/controllers/shared_preference.dart';
import 'package:baithuzakath_app/core/app_config.dart';
import 'package:baithuzakath_app/models/profile_model.dart';
import 'package:dio/dio.dart';

class UserProfileService {
  final Dio dio = Dio(BaseOptions(baseUrl: AppConfig.baseUrl));
  final UserPreferenceService _sharedPrefs = UserPreferenceService();

  Future<UserProfileModel> getUserProfile(String userId) async {
    try {
      final token = await _sharedPrefs.getToken();

      Response response = await dio.get(
        AppConfig.profile,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          return UserProfileModel.fromJson(response.data);
        } else if (response.data is List &&
            (response.data as List).isNotEmpty) {
          return UserProfileModel.fromJson(response.data[0]);
        } else {
          throw Exception('Invalid response format');
        }
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Please login again');
      } else if (response.statusCode == 404) {
        throw Exception('User profile not found');
      } else {
        throw Exception('Failed to load profile: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Server response timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception('No internet connection');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error fetching user profile: $e');
    }
  }
}
