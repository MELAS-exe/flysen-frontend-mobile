import 'package:injectable/injectable.dart';

@module
abstract class AirportServicesModule {
  @Named('airportBaseUrl')
  String get baseUrl => 'http://10.0.2.2:8004';
}
