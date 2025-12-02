class OtpResponse {
  final bool success;
  final String message;
  final OtpData? data;

  OtpResponse({required this.success, required this.message, this.data});

  factory OtpResponse.fromJson(Map<String, dynamic> json) {
    return OtpResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? OtpData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data?.toJson()};
  }
}

class OtpData {
  final String phone;
  final int expiresIn;
  final String messageId;
  final String deliveryMethod;
  final String staticOTP;

  OtpData({
    required this.phone,
    required this.expiresIn,
    required this.messageId,
    required this.deliveryMethod,
    required this.staticOTP,
  });

  factory OtpData.fromJson(Map<String, dynamic> json) {
    return OtpData(
      phone: json['phone'] ?? '',
      expiresIn: json['expiresIn'] ?? 0,
      messageId: json['messageId'] ?? '',
      deliveryMethod: json['deliveryMethod'] ?? '',
      staticOTP: json['staticOTP'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'expiresIn': expiresIn,
      'messageId': messageId,
      'deliveryMethod': deliveryMethod,
      'staticOTP': staticOTP,
    };
  }
}
