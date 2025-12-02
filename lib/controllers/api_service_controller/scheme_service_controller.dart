import 'package:baithuzakath_app/controllers/shared_preference.dart';
import 'package:baithuzakath_app/core/app_config.dart';
import 'package:baithuzakath_app/models/scheme_model.dart';
import 'package:dio/dio.dart';

class SchemeApiService {
  final Dio dio = Dio(BaseOptions(baseUrl: AppConfig.baseUrl));
  final UserPreferenceService _sharedPrefs = UserPreferenceService();
  Future<List<SchemeResponse>> getAllSchemes({
    String? category,
    int? page,
    int? limit,
  }) async {
    try {
      Map<String, dynamic> queryParams = {};
      if (category != null) queryParams['category'] = category;
      if (page != null) queryParams['page'] = page;
      if (limit != null) queryParams['limit'] = limit;

      Response response = await dio.get(
        AppConfig.listSchemes,
        queryParameters: queryParams,
        options: Options(
          headers: {'Authorization': 'Bearer ${await _sharedPrefs.getToken()}'},
          validateStatus: (status) => true,
        ),
      );

      if (response.statusCode == 200) {
        var jsonResponse = response.data as List;
        return jsonResponse
            .map((schemeJson) => SchemeResponse.fromJson(schemeJson))
            .toList();
      } else {
        throw Exception('Failed to load schemes');
      }
    } catch (e) {
      throw Exception('Error fetching schemes: $e');
    }
  }

  Future<SchemeResponse?> getSchemeById(String id) async {
    try {
      Response response = await dio.get(
        '${AppConfig.schemeDetails}/$id',
        options: Options(
          headers: {'Authorization': 'Bearer ${await _sharedPrefs.getToken()}'},
          validateStatus: (status) => true,
        ),
      );

      if (response.statusCode == 200) {
        var jsonResponse = response.data;
        return SchemeResponse.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load scheme details');
      }
    } catch (e) {
      throw Exception('Error fetching scheme details: $e');
    }
  }
}
