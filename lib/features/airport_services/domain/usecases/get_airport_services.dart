import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flysen_frontend_mobile/core/domain/failures/failure.dart';
import 'package:flysen_frontend_mobile/core/domain/usecases/use_case.dart';
import 'package:flysen_frontend_mobile/features/airport_services/domain/entities/airport_service_entity.dart';
import 'package:flysen_frontend_mobile/features/airport_services/domain/repositories/airport_services_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetAirportServices
    implements UseCase<List<AirportServiceEntity>, GetAirportServicesParams> {
  final AirportServicesRepository repository;

  GetAirportServices(this.repository);

  @override
  Future<Either<Failure, List<AirportServiceEntity>>> call(
      GetAirportServicesParams params) async {
    return await repository.getServicesForAirport(params.airportId);
  }
}

class GetAirportServicesParams extends Equatable {
  GetAirportServicesParams({required this.airportId});

  final String airportId;

  @override
  List<Object?> get props => [airportId];
}
