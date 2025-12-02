import 'package:dartz/dartz.dart';
import 'package:flysen_frontend_mobile/core/domain/failures/failure.dart';
import 'package:flysen_frontend_mobile/features/airport_services/domain/entities/airport_service_entity.dart';

abstract class AirportServicesRepository {
  Future<Either<Failure, List<AirportServiceEntity>>> getServicesForAirport(
      String airportId);
}
