import 'package:flysen_frontend_mobile/features/discover/data/models/destination_model.dart';

abstract interface class DiscoverRemoteDataSource {
  Future<List<DestinationModel>> getDestinations({
    required String idToken,
    required int limit,
    String? lastDocumentId,
  });
}