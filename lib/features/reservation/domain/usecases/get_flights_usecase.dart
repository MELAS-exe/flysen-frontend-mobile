import 'package:dartz/dartz.dart';
import 'package:flysen_frontend_mobile/core/domain/failures/failure.dart';
import 'package:flysen_frontend_mobile/core/domain/usecases/use_case.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/entities/flight_offer.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/entities/flight_search_params.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/repositories/flight_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetFlightsUseCase implements UseCase<List<FlightOffer>, FlightSearchParams> {
  final FlightRepository repository;

  GetFlightsUseCase(this.repository);

  @override
  Future<Either<Failure, List<FlightOffer>>> call(
      FlightSearchParams params,
      ) async {
    return await repository.getFlights(params);
  }
}