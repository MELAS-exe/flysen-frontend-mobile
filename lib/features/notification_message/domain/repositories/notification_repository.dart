import 'package:dartz/dartz.dart';
import 'package:flysen_frontend_mobile/core/domain/failures/failure.dart';
import 'package:flysen_frontend_mobile/features/notification_message/domain/entities/notification_message.dart';

abstract interface class NotificationRepository {
  /// Initializes FCM, requests permissions, and sets up listeners.
  Future<Either<ServerFailure, void>> initialize();

  /// A stream of notifications received while the app is in the foreground.
  Stream<NotificationMessage> get onMessage;

  /// A stream of notifications that were tapped to open the app.
  Stream<NotificationMessage> get onMessageOpenedApp;

  Future<Either<ServerFailure, String?>> getFCMToken();
}