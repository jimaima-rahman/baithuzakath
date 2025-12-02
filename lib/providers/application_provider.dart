import 'dart:io';

import 'package:baithuzakath_app/controllers/api_service_controller/application_service_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final applicationServiceProvider = Provider<ApplicationServiceController>((
  ref,
) {
  return ApplicationServiceController();
});

class UserApplicationQuery {
  final String? status;
  final int? page;
  final int? limit;

  const UserApplicationQuery({this.status, this.page, this.limit});
}

final uploadDocumentProvider =
    FutureProvider.family<String?, UploadDocumentParams>((ref, params) async {
      final service = ref.read(applicationServiceProvider);
      return service.postapplication(params.file, params.documentType);
    });

class UploadDocumentParams {
  final File file;
  final String documentType;

  UploadDocumentParams({required this.file, required this.documentType});
}
