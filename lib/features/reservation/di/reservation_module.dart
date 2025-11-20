import 'package:injectable/injectable.dart';

@module
abstract class ReservationModule {
  @Named('flightBaseUrl')
  String get baseUrl => 'http://10.0.2.2:8003';
}