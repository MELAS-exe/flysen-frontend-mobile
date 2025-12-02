// airport_services_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flysen_frontend_mobile/features/airport_services/domain/entities/airport_service_entity.dart';
import 'package:flysen_frontend_mobile/features/airport_services/domain/usecases/get_airport_services.dart';
import 'package:injectable/injectable.dart';

part 'airport_services_event.dart';
part 'airport_services_state.dart';

@injectable
class AirportServicesBloc
    extends Bloc<AirportServicesEvent, AirportServicesState> {
  final GetAirportServices _getAirportServices;

  AirportServicesBloc(this._getAirportServices)
      : super(AirportServicesInitial()) {
    on<LoadAirportServices>(_onLoadAirportServices);
  }

  Future<void> _onLoadAirportServices(
    LoadAirportServices event,
    Emitter<AirportServicesState> emit,
  ) async {
    emit(AirportServicesLoading());
    final result = await _getAirportServices(
        GetAirportServicesParams(airportId: event.airportId));
    result.fold(
      (failure) => emit(AirportServicesError(failure.message)),
      (services) => emit(AirportServicesLoaded(services)),
    );
  }
}
