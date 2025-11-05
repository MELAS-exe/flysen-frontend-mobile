import 'package:dartz/dartz.dart';
import 'package:flysen_frontend_mobile/core/domain/failures/failure.dart';
import 'package:flysen_frontend_mobile/core/domain/usecases/use_case.dart';
import 'package:flysen_frontend_mobile/features/notification_message/domain/repositories/notification_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class InitializeNotifications extends UseCase<void, NoParams> {
  final NotificationRepository _repository;

  InitializeNotifications(this._repository);

  @override
  Future<Either<ServerFailure, void>> call(NoParams params) {
    throw _repository.initialize();
  }
}