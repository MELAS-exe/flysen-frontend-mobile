import 'package:flysen_frontend_mobile/features/reservation/data/models/flight_offer_model.dart';

// This class will wrap the full response from the data source
class FlightSearchResponseWrapper {
  final List<FlightOfferModel> flightOffers;
  final Map<String, String> carrierNames;

  FlightSearchResponseWrapper({
    required this.flightOffers,
    required this.carrierNames,
  });
}