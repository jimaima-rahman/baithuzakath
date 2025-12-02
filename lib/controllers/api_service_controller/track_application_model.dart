import 'package:baithuzakath_app/controllers/shared_preference.dart';
import 'package:baithuzakath_app/core/app_config.dart';
import 'package:baithuzakath_app/models/applocation_track_model.dart';
import 'package:dio/dio.dart';

class ApplicationTrackService {
  final Dio _dio = Dio(BaseOptions(baseUrl: AppConfig.baseUrl));
  final UserPreferenceService _sharedPrefs = UserPreferenceService();

  Future<Map<String, String>> _authHeader() async {
    final token = await _sharedPrefs.getToken();
    return {"Authorization": "Bearer $token"};
  }

  Future<ApplicationTrackModel> getApplicationTrack(
    String applicationId,
  ) async {
    try {
      final response = await _dio.get(
        "${AppConfig.applications}/$applicationId",
        options: Options(
          headers: await _authHeader(),
          validateStatus: (_) => true,
        ),
      );

      if (response.statusCode == 200) {
        return ApplicationTrackModel.fromJson(response.data);
      } else {
        throw Exception(
          "Failed to fetch tracking details: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("Error fetching application track: $e");
    }
  }
}
