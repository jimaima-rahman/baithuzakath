class ApplicationTrackModel {
  final bool success;
  final ApplicationData? data;

  ApplicationTrackModel({required this.success, this.data});

  factory ApplicationTrackModel.fromJson(Map<String, dynamic> json) {
    return ApplicationTrackModel(
      success: json['success'] ?? false,
      data: json['data'] != null
          ? ApplicationData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'data': data?.toJson()};
  }
}

class ApplicationData {
  final ApplicationDetail? application;

  ApplicationData({this.application});

  factory ApplicationData.fromJson(Map<String, dynamic> json) {
    return ApplicationData(
      application: json['application'] != null
          ? ApplicationDetail.fromJson(json['application'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'application': application?.toJson()};
  }
}

class ApplicationDetail {
  final String id;
  final String applicationId;
  final String applicationNumber;
  final SchemeModel scheme;
  final String status;
  final DateTime? submittedAt;
  final int requestedAmount;
  final int approvedAmount;

  ApplicationDetail({
    required this.id,
    required this.applicationId,
    required this.applicationNumber,
    required this.scheme,
    required this.status,
    this.submittedAt,
    required this.requestedAmount,
    required this.approvedAmount,
  });

  factory ApplicationDetail.fromJson(Map<String, dynamic> json) {
    return ApplicationDetail(
      id: json['_id'] ?? '',
      applicationId: json['applicationId'] ?? '',
      applicationNumber: json['applicationNumber'] ?? '',
      scheme: SchemeModel.fromJson(json['scheme']),
      status: json['status'] ?? '',
      submittedAt: json['submittedAt'] != null
          ? DateTime.parse(json['submittedAt'])
          : null,
      requestedAmount: json['requestedAmount'] ?? 0,
      approvedAmount: json['approvedAmount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'applicationId': applicationId,
      'applicationNumber': applicationNumber,
      'scheme': scheme.toJson(),
      'status': status,
      'submittedAt': submittedAt?.toIso8601String(),
      'requestedAmount': requestedAmount,
      'approvedAmount': approvedAmount,
    };
  }
}

class SchemeModel {
  final String id;
  final String name;
  final String category;

  SchemeModel({required this.id, required this.name, required this.category});

  factory SchemeModel.fromJson(Map<String, dynamic> json) {
    return SchemeModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'_id': id, 'name': name, 'category': category};
  }
}
