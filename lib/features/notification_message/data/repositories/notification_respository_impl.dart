
import 'package:dartz/dartz.dart';
import 'package:flysen_frontend_mobile/core/domain/failures/failure.dart';
import 'package:flysen_frontend_mobile/features/notification_message/data/datasources/notification_datasource.dart';
import 'package:flysen_frontend_mobile/features/notification_message/domain/entities/notification_message.dart';
import 'package:flysen_frontend_mobile/features/notification_message/domain/repositories/notification_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: NotificationRepository)
class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationDatasource datasource;

  NotificationRepositoryImpl(this.datasource);

  @override
  Future<Either<ServerFailure, String?>> getFCMToken() async {
    try {
      final token = await datasource.getFCMToken();
      return Right(token);
    } catch (e) {
      // Retourne une Failure si quelque chose se passe mal
      return Left(ServerFailure(message: 'Could not get FCM token'));
    }
  }

  @override
  Future<Either<ServerFailure, void>> initialize() {
    // TODO: implement initialize
    throw UnimplementedError();
  }

  @override
  // TODO: implement onMessage
  Stream<NotificationMessage> get onMessage => throw UnimplementedError();

  @override
  // TODO: implement onMessageOpenedApp
  Stream<NotificationMessage> get onMessageOpenedApp => throw UnimplementedError();
}