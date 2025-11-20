import 'package:dartz/dartz.dart';
import 'package:flysen_frontend_mobile/core/domain/failures/failure.dart';
import 'package:flysen_frontend_mobile/core/domain/usecases/use_case.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/entities/flight_price_params.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/entities/flight_price_response.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/repositories/flight_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetFlightPriceUseCase implements UseCase<FlightPriceResponse, FlightPriceParams> {
  final FlightRepository repository;

  GetFlightPriceUseCase(this.repository);

  @override
  Future<Either<Failure, FlightPriceResponse>> call(
      FlightPriceParams params,
      ) async {
    return await repository.getFlightPrice(params);
  }
}