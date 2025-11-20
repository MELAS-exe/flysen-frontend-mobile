part of 'flight_bloc.dart';

@immutable
sealed class FlightEvent extends Equatable{
  const FlightEvent();

  @override
  List<Object?> get props => [];
}


class SearchFlights extends FlightEvent {
  final FlightSearchParams params;
  const SearchFlights(this.params);
  @override
  List<Object> get props => [params];
}

class PriceFlight extends FlightEvent {
  final FlightOffer flightOffer;
  const PriceFlight(this.flightOffer);
  @override
  List<Object> get props => [flightOffer];
}
