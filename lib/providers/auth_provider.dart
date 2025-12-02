import 'package:baithuzakath_app/controllers/api_service_controller/auth_service_controller.dart';
import 'package:baithuzakath_app/models/sent_otp_model.dart';
import 'package:baithuzakath_app/models/verify_otp_model.dart';
import 'package:flutter/material.dart';

class OtpProvider extends ChangeNotifier {
  final OtpServiceController _otpServiceController = OtpServiceController();

  bool _isSendingOtp = false;
  bool _isVerifyingOtp = false;

  String? _sendOtpError;
  String? _verifyOtpError;

  OtpResponse? _otpResponse;
  LoginResponse? _loginResponse;

  bool get isSendingOtp => _isSendingOtp;
  bool get isVerifyingOtp => _isVerifyingOtp;
  String? get sendOtpError => _sendOtpError;
  String? get verifyOtpError => _verifyOtpError;
  OtpResponse? get otpResponse => _otpResponse;
  LoginResponse? get loginResponse => _loginResponse;

  Future<bool> sendOtp(String phone) async {
    _isSendingOtp = true;
    _sendOtpError = null;
    _otpResponse = null;
    notifyListeners();

    try {
      final response = await _otpServiceController.otpSend(phone);

      if (response != null && response.success) {
        _otpResponse = response;
        _isSendingOtp = false;
        notifyListeners();
        return true;
      } else {
        _sendOtpError = response?.message ?? 'Failed to send OTP';
        _isSendingOtp = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _sendOtpError = 'An error occurred while sending OTP';
      _isSendingOtp = false;
      notifyListeners();
      return false;
    }
  }

  // Verify OTP
  Future<bool> verifyOtp(String phone, String otp) async {
    _isVerifyingOtp = true;
    _verifyOtpError = null;
    _loginResponse = null;
    notifyListeners();

    try {
      final response = await _otpServiceController.verifyOtp(phone, otp);

      if (response != null && response.success) {
        _loginResponse = response;
        _isVerifyingOtp = false;
        notifyListeners();
        return true;
      } else {
        _verifyOtpError = response?.message ?? 'Failed to verify OTP';
        _isVerifyingOtp = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _verifyOtpError = 'An error occurred while verifying OTP';
      _isVerifyingOtp = false;
      notifyListeners();
      return false;
    }
  }

  // Get user token
  String? get userToken => _loginResponse?.data?.token;

  // Get user data
  User? get userData => _loginResponse?.data?.user;

  // Clear errors
  void clearErrors() {
    _sendOtpError = null;
    _verifyOtpError = null;
    notifyListeners();
  }

  // Clear all data
  void clearData() {
    _otpResponse = null;
    _loginResponse = null;
    _sendOtpError = null;
    _verifyOtpError = null;
    _isSendingOtp = false;
    _isVerifyingOtp = false;
    notifyListeners();
  }

  // Reset provider
  void reset() {
    clearData();
  }
}
