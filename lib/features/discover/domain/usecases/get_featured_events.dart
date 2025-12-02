import 'package:dartz/dartz.dart';
import 'package:flysen_frontend_mobile/core/domain/failures/failure.dart';
import 'package:flysen_frontend_mobile/core/domain/usecases/use_case.dart';
import 'package:flysen_frontend_mobile/features/discover/domain/entities/event_entity.dart';
import 'package:flysen_frontend_mobile/features/discover/domain/repositories/discover_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetFeaturedEvents implements UseCase<List<EventEntity>, NoParams> {
  final DiscoverRepository repository;

  GetFeaturedEvents(this.repository);

  @override
  Future<Either<Failure, List<EventEntity>>> call(NoParams params) async {
    return await repository.getFeaturedEvents();
  }
}
