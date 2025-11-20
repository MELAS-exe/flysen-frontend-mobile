import 'package:injectable/injectable.dart';

@module
abstract class DiscoverModule {
  @Named('discoverBaseUrl')
  String get baseUrl => 'http://10.0.2.2:8004';
}