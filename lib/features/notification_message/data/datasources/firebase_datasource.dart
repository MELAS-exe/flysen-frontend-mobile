// This function MUST be a top-level function (not a class method)
// to be used as the background message handler.
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flysen_frontend_mobile/features/notification_message/data/datasources/notification_datasource.dart';
import 'package:injectable/injectable.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you need to do something with background messages, do it here.
  // For now, we can just print it.
  print("Handling a background message: ${message.messageId}");
}


@LazySingleton(as: NotificationDatasource)
class NotificationDatasourceImpl implements NotificationDatasource {
  NotificationDatasourceImpl({required FirebaseMessaging firebaseMessaging}) : _firebaseMessaging = firebaseMessaging;

  final FirebaseMessaging _firebaseMessaging;

  @override
  Future<void> initialize() async {
    // 1. Request Permission
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');

    // 2. Get the FCM token
    final fcmToken = await _firebaseMessaging.getToken();
    print('FCM Token: $fcmToken');
    // TODO: Send this token to your server

    // 3. Set up background message handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  @override
  Stream<RemoteMessage> get onMessage => FirebaseMessaging.onMessage;

  @override
  Stream<RemoteMessage> get onMessageOpenedApp =>
      FirebaseMessaging.onMessageOpenedApp;

  @override
  Future<String?> getFCMToken() async {
    final token = await _firebaseMessaging.getToken();
    print('----------- FCM TOKEN -----------');
    print(token);
    print('---------------------------------');
    return token;
  }
}