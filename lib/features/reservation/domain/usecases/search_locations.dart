import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flysen_frontend_mobile/core/domain/failures/failure.dart';
import 'package:flysen_frontend_mobile/core/domain/usecases/use_case.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/entities/location_entity.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/repositories/flight_repository.dart';
import 'package:injectable/injectable.dart';

class SearchLocationsParams extends Equatable {
  final String keyword;
  final String subType; // 'CITY' or 'AIRPORT'

  const SearchLocationsParams({required this.keyword, required this.subType});

  @override
  List<Object?> get props => [keyword, subType];
}

@lazySingleton
class SearchLocations
    implements UseCase<List<LocationEntity>, SearchLocationsParams> {
  final FlightRepository repository;

  SearchLocations(this.repository);

  @override
  Future<Either<Failure, List<LocationEntity>>> call(
      SearchLocationsParams params) async {
    return await repository.searchLocations(params.keyword, params.subType);
  }
}
