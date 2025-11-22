import 'package:dartz/dartz.dart';
import 'package:flysen_frontend_mobile/core/domain/failures/failure.dart';
import 'package:flysen_frontend_mobile/features/reservation/data/models/flight_search_response_wrapper.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/entities/flight_offer.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/entities/flight_price_params.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/entities/flight_price_response.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/entities/flight_search_params.dart';

abstract interface class FlightRepository {
  /// Fetches flight offers based on the provided search criteria.
  ///
  /// Returns a [Failure] on error or a list of [FlightOffer] on success.
  Future<Either<Failure, FlightSearchResponseWrapper>> getFlights(
      FlightSearchParams params,
      );

  Future<Either<Failure, FlightPriceResponse>> getFlightPrice(
      FlightPriceParams params,
      );
}
