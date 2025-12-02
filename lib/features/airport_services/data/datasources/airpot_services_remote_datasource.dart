import 'package:flysen_frontend_mobile/features/airport_services/data/models/airport_service_model.dart';

abstract class AirportServicesRemoteDataSource {
  /// Fetches a list of services for a given airportId.
  /// Throws a [ServerException] for all error codes.
  Future<List<AirportServiceModel>> getServicesForAirport(
      String airportId, String token);
}
