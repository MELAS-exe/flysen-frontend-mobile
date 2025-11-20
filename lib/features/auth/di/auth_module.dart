import 'package:injectable/injectable.dart';

@module
abstract class AuthModule {
  @Named('baseUrl')
  @lazySingleton
  String get baseUrl => 'http://10.0.2.2:8004';
}