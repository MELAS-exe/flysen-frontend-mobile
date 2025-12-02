import 'dart:convert';
import 'package:flysen_frontend_mobile/features/airport_services/data/datasources/airpot_services_remote_datasource.dart';
import 'package:http/http.dart' as http;
import 'package:flysen_frontend_mobile/core/domain/failures/exceptions.dart';
import 'package:flysen_frontend_mobile/features/airport_services/data/models/airport_service_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AirportServicesRemoteDataSource)
class AirportServicesRemoteDataSourceImpl
    implements AirportServicesRemoteDataSource {
  final http.Client _client;
  final String _baseUrl;
  AirportServicesRemoteDataSourceImpl(
      this._client, @Named('airportBaseUrl') this._baseUrl);

  @override
  Future<List<AirportServiceModel>> getServicesForAirport(
      String airportId, String token) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/airport-services/airport/$airportId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);
      final List<dynamic> serviceList =
          decodedResponse['data'] as List<dynamic>;
      return serviceList
          .map((json) =>
              AirportServiceModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(message: 'Failed to load airport services');
    }
  }
}
