import 'package:dartz/dartz.dart';
import 'package:flysen_frontend_mobile/core/domain/failures/failure.dart';
import 'package:flysen_frontend_mobile/features/discover/domain/entities/destination_entity.dart';
import 'package:flysen_frontend_mobile/features/discover/domain/entities/event_entity.dart';

abstract interface class DiscoverRepository {
  Future<Either<Failure, List<DestinationEntity>>> getDestinations({
    required int limit,
    String? lastDocumentId,
  });

  Future<Either<Failure, List<DestinationEntity>>> searchDestinations(
      String query);

  Future<Either<Failure, List<EventEntity>>> getFeaturedEvents({int limit = 5});
}
