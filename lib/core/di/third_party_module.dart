import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:flysen_frontend_mobile/firebase_options.dart';

@module
abstract class ThirdPartyModule {
  // 1. Enregistrer le Future<FirebaseApp>
  @preResolve // <-- C'est la clé !
  Future<FirebaseApp> get firebaseApp =>
      Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

  // 2. Enregistrer FirebaseMessaging, qui dépend de FirebaseApp
  @lazySingleton
  FirebaseMessaging get firebaseMessaging => FirebaseMessaging.instance;
}