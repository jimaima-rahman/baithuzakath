import 'dart:convert';
import 'dart:developer';

import 'package:baithuzakath_app/controllers/shared_preference.dart';
import 'package:baithuzakath_app/core/app_config.dart';
import 'package:baithuzakath_app/models/sent_otp_model.dart';
import 'package:baithuzakath_app/models/verify_otp_model.dart';
import 'package:dio/dio.dart';

class OtpServiceController {
  final Dio dio = Dio(BaseOptions(baseUrl: AppConfig.baseUrl));
  final UserPreferenceService _sharedPrefs = UserPreferenceService();

  Future<OtpResponse?> otpSend(String phone) async {
    log("message$phone");
    try {
      Response response = await dio.post(
        AppConfig.sendOtp,
        data: {"phone": phone},
        options: Options(validateStatus: (status) => true),
      );

      log("${response.statusCode}");
      log(response.statusMessage ?? "No status message");

      if (response.statusCode == 200) {
        var jsonResponse = json.encode(response.data);
        return OtpResponse.fromJson(json.decode(jsonResponse));
      }

      return null;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<LoginResponse?> verifyOtp(String phone, String otp) async {
    log("verify otp called with phone: $phone and otp: $otp");
    try {
      Response response = await dio.post(
        AppConfig.verifyOtp,
        data: {"phone": phone, "otp": otp},
        options: Options(validateStatus: (status) => true),
      );

      log("${response.statusCode}");
      log(response.statusMessage ?? "No status message");

      if (response.statusCode == 200) {
        var jsonResponse = json.encode(response.data);
        LoginResponse loginResponse = LoginResponse.fromJson(
          json.decode(jsonResponse),
        );

        if (loginResponse.success && loginResponse.data != null) {
          _saveUserData(loginResponse);
          log("User data saved successfully");
        }

        return loginResponse;
      }

      return null;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  void _saveUserData(LoginResponse loginResponse) {
    try {
      if (loginResponse.data?.token != null) {
        _sharedPrefs.saveToken(loginResponse.data!.token);
        log("Token saved: ${loginResponse.data!.token}");
      }

      if (loginResponse.data?.user.id != null) {
        _sharedPrefs.saveUserId(loginResponse.data!.user.id);
        log("User ID saved: ${loginResponse.data!.user.id}");
      }
    } catch (e) {
      log("Error saving user data: $e");
    }
  }
}
