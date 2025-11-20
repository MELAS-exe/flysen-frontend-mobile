import 'package:dartz/dartz.dart';
import 'package:flysen_frontend_mobile/core/domain/failures/failure.dart';
import 'package:flysen_frontend_mobile/features/discover/domain/entities/destination.dart';

abstract interface class DiscoverRepository {
  Future<Either<Failure, List<Destination>>> getDestinations({
    required int limit,
    String? lastDocumentId,
  });
}