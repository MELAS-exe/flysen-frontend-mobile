import 'package:equatable/equatable.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/entities/flight_offer.dart';

class FlightPriceResponse extends Equatable {
  final List<FlightOffer> flightOffers;
  final BookingRequirements? bookingRequirements;

  const FlightPriceResponse({
    required this.flightOffers,
    this.bookingRequirements,
  });

  @override
  List<Object?> get props => [flightOffers, bookingRequirements];
}

class BookingRequirements extends Equatable {
  final bool emailAddressRequired;
  final bool mobilePhoneNumberRequired;

  const BookingRequirements({
    required this.emailAddressRequired,
    required this.mobilePhoneNumberRequired,
  });

  @override
  List<Object?> get props => [emailAddressRequired, mobilePhoneNumberRequired];
}