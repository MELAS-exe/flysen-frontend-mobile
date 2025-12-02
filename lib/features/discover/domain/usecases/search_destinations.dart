import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flysen_frontend_mobile/core/domain/failures/failure.dart';
import 'package:flysen_frontend_mobile/core/domain/usecases/use_case.dart';
import 'package:flysen_frontend_mobile/features/discover/domain/entities/destination_entity.dart';
import 'package:flysen_frontend_mobile/features/discover/domain/repositories/discover_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SearchDestinations
    implements UseCase<List<DestinationEntity>, SearchDestinationsParams> {
  final DiscoverRepository repository;

  SearchDestinations(this.repository);

  @override
  Future<Either<Failure, List<DestinationEntity>>> call(
      SearchDestinationsParams params) async {
    if (params.query.isEmpty) {
      return const Right([]);
    }
    return await repository.searchDestinations(params.query);
  }
}

class SearchDestinationsParams extends Equatable {
  SearchDestinationsParams({required this.query});

  final String query;

  @override
  List<Object?> get props => [query];
}
