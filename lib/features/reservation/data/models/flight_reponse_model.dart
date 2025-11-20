import 'package:flysen_frontend_mobile/features/reservation/data/models/flight_offer_model.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/entities/flight_price_response.dart';

List<T> _parseList<T>(
    List<dynamic>? data, T Function(Map<String, dynamic>) fromJson) {
  return data?.map((item) => fromJson(item as Map<String, dynamic>)).toList() ??
      [];
}

class FlightPriceResponseModel extends FlightPriceResponse {
  const FlightPriceResponseModel({
    required super.flightOffers,
    super.bookingRequirements,
  });

  factory FlightPriceResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return FlightPriceResponseModel(
      flightOffers: _parseList(
        data['flightOffers'] as List<dynamic>?,
            (item) => FlightOfferModel.fromJson(item), // Réutiliser le modèle existant
      ),
      bookingRequirements: data['bookingRequirements'] != null
          ? BookingRequirementsModel.fromJson(
          data['bookingRequirements'] as Map<String, dynamic>)
          : null,
    );
  }
}

class BookingRequirementsModel extends BookingRequirements {
  const BookingRequirementsModel({
    required super.emailAddressRequired,
    required super.mobilePhoneNumberRequired,
  });

  factory BookingRequirementsModel.fromJson(Map<String, dynamic> json) {
    return BookingRequirementsModel(
      emailAddressRequired: json['emailAddressRequired'] as bool,
      mobilePhoneNumberRequired: json['mobilePhoneNumberRequired'] as bool,
    );
  }
}