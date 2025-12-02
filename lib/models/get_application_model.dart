class GetMyApplicationModel {
  final bool success;
  final ApplicationData? data;

  GetMyApplicationModel({required this.success, this.data});

  factory GetMyApplicationModel.fromJson(Map<String, dynamic> json) {
    return GetMyApplicationModel(
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
  final List<Application> applications;

  ApplicationData({required this.applications});

  factory ApplicationData.fromJson(Map<String, dynamic> json) {
    return ApplicationData(
      applications: json['applications'] != null
          ? (json['applications'] as List)
                .map((app) => Application.fromJson(app))
                .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'applications': applications.map((app) => app.toJson()).toList()};
  }
}

class Application {
  final String id;
  final String? applicationId;
  final String? applicationNumber;
  final SchemeInfo? scheme;
  final String? status;
  final String? submittedAt;
  final double? requestedAmount;
  final double? approvedAmount;

  Application({
    required this.id,
    this.applicationId,
    this.applicationNumber,
    this.scheme,
    this.status,
    this.submittedAt,
    this.requestedAmount,
    this.approvedAmount,
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      id: json['_id'] ?? '',
      applicationId: json['applicationId'],
      applicationNumber: json['applicationNumber'],
      scheme: json['scheme'] != null
          ? SchemeInfo.fromJson(json['scheme'])
          : null,
      status: json['status'],
      submittedAt: json['submittedAt'],
      requestedAmount: json['requestedAmount'] != null
          ? (json['requestedAmount'] as num).toDouble()
          : null,
      approvedAmount: json['approvedAmount'] != null
          ? (json['approvedAmount'] as num).toDouble()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'applicationId': applicationId,
      'applicationNumber': applicationNumber,
      'scheme': scheme?.toJson(),
      'status': status,
      'submittedAt': submittedAt,
      'requestedAmount': requestedAmount,
      'approvedAmount': approvedAmount,
    };
  }

  String getFormattedSubmittedDate() {
    if (submittedAt == null) return 'N/A';
    try {
      final date = DateTime.parse(submittedAt!);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return submittedAt!;
    }
  }

  // Helper method to get status color
  String getStatusColor() {
    switch (status?.toLowerCase()) {
      case 'pending':
        return 'orange';
      case 'approved':
        return 'green';
      case 'rejected':
        return 'red';
      case 'under_review':
        return 'blue';
      default:
        return 'grey';
    }
  }

  // Helper method to get formatted status text
  String getFormattedStatus() {
    if (status == null) return 'Unknown';
    return status!
        .replaceAll('_', ' ')
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
}

class SchemeInfo {
  final String id;
  final String? name;
  final String? category;

  SchemeInfo({required this.id, this.name, this.category});

  factory SchemeInfo.fromJson(Map<String, dynamic> json) {
    return SchemeInfo(
      id: json['_id'] ?? '',
      name: json['name'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'_id': id, 'name': name, 'category': category};
  }
}
