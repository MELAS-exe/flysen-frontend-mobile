import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';

abstract interface class NotificationDatasource {
  Future<void> initialize();

  Stream<RemoteMessage> get onMessage;

  Stream<RemoteMessage> get onMessageOpenedApp;

  Future<String?> getFCMToken();
}