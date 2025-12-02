// airport_services_event.dart
part of 'airport_services_bloc.dart';

sealed class AirportServicesEvent extends Equatable {
  const AirportServicesEvent();
  @override
  List<Object> get props => [];
}

final class LoadAirportServices extends AirportServicesEvent {
  final String airportId;
  const LoadAirportServices(this.airportId);
  @override
  List<Object> get props => [airportId];
}
