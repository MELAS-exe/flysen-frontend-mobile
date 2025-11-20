import 'package:equatable/equatable.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/entities/flight_offer.dart';

class FlightPriceParams extends Equatable {
  final String type;
  final List<FlightOffer> flightOffers;

  const FlightPriceParams({
    this.type = "flight-offers-pricing",
    required this.flightOffers,
  });

  Map<String, dynamic> toJson() => {
    'data': {
      'type': type,
      'flightOffers': flightOffers.map((e) => e.toJson()).toList(),
    }
  };

  @override
  List<Object?> get props => [type, flightOffers];
}