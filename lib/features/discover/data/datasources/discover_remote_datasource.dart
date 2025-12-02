import 'package:flysen_frontend_mobile/features/discover/data/models/destination_model.dart';
import 'package:flysen_frontend_mobile/features/discover/data/models/event_model.dart';

abstract interface class DiscoverRemoteDataSource {
  Future<List<DestinationModel>> getDestinations({
    required String idToken,
    required int limit,
    String? lastDocumentId,
  });

  Future<List<DestinationModel>> searchDestinations(
      {required String query, required String token});

  Future<List<EventModel>> getFeaturedEvents(
      {required String token, int limit = 5});
}
