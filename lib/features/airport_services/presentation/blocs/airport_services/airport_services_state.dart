// airport_services_state.dart
part of 'airport_services_bloc.dart';

sealed class AirportServicesState extends Equatable {
  const AirportServicesState();
  @override
  List<Object> get props => [];
}

final class AirportServicesInitial extends AirportServicesState {}

final class AirportServicesLoading extends AirportServicesState {}

final class AirportServicesLoaded extends AirportServicesState {
  final List<AirportServiceEntity> services;
  const AirportServicesLoaded(this.services);
  @override
  List<Object> get props => [services];
}

final class AirportServicesError extends AirportServicesState {
  final String message;
  const AirportServicesError(this.message);
  @override
  List<Object> get props => [message];
}
