import 'dart:io';

import 'package:baithuzakath_app/controllers/shared_preference.dart';
import 'package:baithuzakath_app/core/app_config.dart';
import 'package:baithuzakath_app/models/get_application_model.dart';
import 'package:dio/dio.dart';

class ApplicationServiceController {
  final Dio dio = Dio(BaseOptions(baseUrl: AppConfig.baseUrl));
  final UserPreferenceService _sharedPrefs = UserPreferenceService();

  void setAuthToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void removeAuthToken() {
    dio.options.headers.remove('Authorization');
  }

  Future<GetMyApplicationModel> getUserApplications(
    String? status,
    int? page,
    int? limit,
  ) async {
    try {
      final queryParameters = <String, dynamic>{};

      if (status != null) queryParameters['status'] = status;
      if (page != null) queryParameters['page'] = page;
      if (limit != null) queryParameters['limit'] = limit;

      Response response = await dio.get(
        AppConfig.applications,
        queryParameters: queryParameters,
        options: Options(
          headers: {'Authorization': 'Bearer ${await _sharedPrefs.getToken()}'},
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200) {
        return GetMyApplicationModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Please login again');
      } else if (response.statusCode == 404) {
        throw Exception('No applications found');
      } else {
        throw Exception('Failed to load user applications');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception('No internet connection');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error fetching user applications: $e');
    }
  }

  Future<String?> postapplication(File file, String documentType) async {
    try {
      final fileName = file.path.split("/").last;

      FormData formData = FormData.fromMap({
        "documentType": documentType,
        "file": await MultipartFile.fromFile(file.path, filename: fileName),
      });

      final response = await dio.post(
        "/application/upload-document",
        data: formData,
      );

      if (response.statusCode == 200) {
        return response.data["fileUrl"];
      }
      return null;
    } catch (e) {
      print("Upload Doc Error: $e");
      return null;
    }
  }
}
