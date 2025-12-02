import 'package:baithuzakath_app/controllers/api_service_controller/track_application_model.dart';
import 'package:baithuzakath_app/models/applocation_track_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final applicationTrackServiceProvider = Provider<ApplicationTrackService>((
  ref,
) {
  return ApplicationTrackService();
});

final applicationTrackProvider =
    FutureProvider.family<ApplicationTrackModel, String>((
      ref,
      applicationId,
    ) async {
      final service = ref.read(applicationTrackServiceProvider);
      return service.getApplicationTrack(applicationId);
    });
