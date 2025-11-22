part of 'flight_bloc.dart';

@immutable
sealed class FlightEvent extends Equatable{
  const FlightEvent();

  @override
  List<Object?> get props => [];
}


class SearchFlights extends FlightEvent {
  final FlightSearchParams params;
  final Map<String, String> locationNames;
  const SearchFlights(this.params, this.locationNames);
  @override
  List<Object> get props => [params, locationNames];
}

class PriceFlight extends FlightEvent {
  final FlightOffer flightOffer;
  const PriceFlight(this.flightOffer);
  @override
  List<Object> get props => [flightOffer];
}
