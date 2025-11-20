import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flysen_frontend_mobile/core/domain/failures/failure.dart';
import 'package:flysen_frontend_mobile/core/domain/usecases/use_case.dart';
import 'package:flysen_frontend_mobile/features/discover/domain/entities/destination.dart';
import 'package:flysen_frontend_mobile/features/discover/domain/repositories/discover_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetDestinations extends UseCase<List<Destination>, GetDestinationsParams> {
  final DiscoverRepository _repository;

  GetDestinations(this._repository);

  @override
  Future<Either<Failure, List<Destination>>> call(GetDestinationsParams params) {
    return _repository.getDestinations(
      limit: params.limit,
      lastDocumentId: params.lastDocumentId,
    );
  }
}

class GetDestinationsParams extends Equatable {
  final int limit;
  final String? lastDocumentId;

  const GetDestinationsParams({
    required this.limit,
    this.lastDocumentId,
  });

  @override
  List<Object?> get props => [limit, lastDocumentId];
}