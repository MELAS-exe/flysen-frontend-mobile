part of 'flight_bloc.dart';

@immutable
sealed class FlightState extends Equatable {
  const FlightState();

  @override
  List<Object?> get props => [];
}

final class FlightInitial extends FlightState {}

class FlightLoading extends FlightState {}

class FlightLoaded extends FlightState {
  final List<FlightOffer> flightOffers;
  final Map<String, String> carrierNames;
  final Map<String, String> locationNames;
  const FlightLoaded({
    required this.flightOffers,
    required this.carrierNames,
    required this.locationNames,
  });
  @override
  List<Object> get props => [flightOffers, carrierNames, locationNames];
}

class FlightError extends FlightState {
  final String message;
  const FlightError(this.message);
  @override
  List<Object> get props => [message];
}

class FlightPriceLoading extends FlightState {
  final List<FlightOffer> previousOffers;
  const FlightPriceLoading(this.previousOffers);
}

class FlightPriceLoaded extends FlightState {
  final FlightPriceResponse priceResponse;
  const FlightPriceLoaded(this.priceResponse);
  @override
  List<Object> get props => [priceResponse];
}
