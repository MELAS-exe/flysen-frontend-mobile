import 'package:flysen_frontend_mobile/features/reservation/data/models/flight_reponse_model.dart';
import 'package:flysen_frontend_mobile/features/reservation/data/models/flight_offer_model.dart';
import 'package:flysen_frontend_mobile/features/reservation/data/models/flight_search_response_wrapper.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/entities/flight_price_params.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/entities/flight_search_params.dart';

abstract class FlightRemoteDataSource {
  Future<FlightSearchResponseWrapper> getFlights(
      FlightSearchParams params, String authToken);

  Future<FlightPriceResponseModel> getFlightPrice(
      FlightPriceParams params, String authToken);
}