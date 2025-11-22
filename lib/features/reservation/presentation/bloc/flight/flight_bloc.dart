import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flysen_frontend_mobile/core/domain/failures/failure.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/entities/flight_offer.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/entities/flight_price_params.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/entities/flight_price_response.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/entities/flight_search_params.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/usecases/get_flight_price_usecase.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/usecases/get_flights_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'flight_event.dart';
part 'flight_state.dart';

@injectable
class FlightBloc extends Bloc<FlightEvent, FlightState> {
  final GetFlightsUseCase getFlightsUseCase;
  final GetFlightPriceUseCase getFlightPriceUseCase;

  FlightBloc(this.getFlightsUseCase, this.getFlightPriceUseCase) : super(FlightInitial()) {
    on<SearchFlights>(_onSearchFlights);
    on<PriceFlight>(_onPriceFlight);
  }

  Future<void> _onPriceFlight(
      PriceFlight event, Emitter<FlightState> emit) async {
    final currentState = state;
    if (currentState is FlightLoaded) {
      emit(FlightPriceLoading(currentState.flightOffers));
    } else {
      emit(FlightLoading()); // Fallback
    }

    final params = FlightPriceParams(flightOffers: [event.flightOffer]);
    final result = await getFlightPriceUseCase(params);

    result.fold(
          (failure) {
            if (failure is ServerFailure) {
              emit(FlightError(failure.message));
            }

            if (failure is LocalFailure) {
              emit(FlightError(failure.message));
            }
          },
          (priceResponse) => emit(FlightPriceLoaded(priceResponse)),
    );
  }

  Future<void> _onSearchFlights(
      SearchFlights event, Emitter<FlightState> emit) async {
    emit(FlightLoading());
    final result = await getFlightsUseCase(event.params);
    result.fold(
          (failure) {
        if (failure is ServerFailure) {
          emit(FlightError(failure.message));
        } else if (failure is LocalFailure) {
          emit(FlightError(failure.message));
        }
        else {
          emit(FlightError(failure.message));
        }
      },
          (responseWrapper) {
            final allLocationNames = {...event.locationNames};
            emit(
              FlightLoaded(
                flightOffers: responseWrapper.flightOffers,
                carrierNames: responseWrapper.carrierNames,
                locationNames: allLocationNames, // Pass the map to the state
              ),
            );
          }
    );
  }
}
