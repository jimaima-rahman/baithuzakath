class AppConfig {
  static const String baseUrl =
      'https://baithuzakath-api-uie39.ondigitalocean.app/api';

  //Endpoints
  static const String sendOtp = '/beneficiary/auth/send-otp';
  static const String verifyOtp = '/beneficiary/auth/verify-otp';
  static const String listSchemes = '/beneficiary/schemes';
  static const String schemeDetails = '/beneficiary/schemes/';
  static const String applications = '/beneficiary/applications';
  static const String trackApplication = '/beneficiary/track/';
  static const String profile = '/beneficiary/auth/profile';
}
