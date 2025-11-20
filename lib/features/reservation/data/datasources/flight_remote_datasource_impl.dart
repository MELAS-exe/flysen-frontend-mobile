import 'dart:convert';

import 'package:flysen_frontend_mobile/core/domain/failures/exceptions.dart';
import 'package:flysen_frontend_mobile/features/reservation/data/models/flight_reponse_model.dart';
import 'package:flysen_frontend_mobile/features/reservation/data/datasources/flight_remote_datasource.dart';
import 'package:flysen_frontend_mobile/features/reservation/data/models/flight_offer_model.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/entities/flight_price_params.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/entities/flight_search_params.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@LazySingleton(as: FlightRemoteDataSource)
class FlightRemoteDataSourceImpl implements FlightRemoteDataSource {
  final http.Client _client;
  final String _baseUrl;

  FlightRemoteDataSourceImpl(
      this._client,
      @Named('flightBaseUrl') this._baseUrl,
      );

  @override
  Future<List<FlightOfferModel>> getFlights(
      FlightSearchParams params, String authToken) async {
    try {
      final uri = Uri.parse('$_baseUrl/flights/get_flights/');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      };
      final body = json.encode(params.toJson());

      // print('--- HTTP Request ---');
      // print('URL: $uri');
      // print('Method: POST');
      // print('Headers: $headers');
      // print('Body: $body');
      // print('--------------------');

      final response = await _client.post(
        uri,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final jsonResponse =
        json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

        if (jsonResponse.containsKey('data')) {
          final dataList = jsonResponse['data'] as List;
          return dataList
              .map((item) =>
              FlightOfferModel.fromJson(item as Map<String, dynamic>))
              .toList();
        } else {
          throw ServerException(
              message: 'Format de réponse invalide : clé "data" manquante');
        }
      } else {
        throw ServerException(
          message: 'Échec du chargement des vols: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(
          message:
          'Erreur réseau durant la recherche de vols: ${e.toString()}');
    }
  }

  @override
  Future<FlightPriceResponseModel> getFlightPrice(
      FlightPriceParams params, String authToken) async {
    try {
      final uri = Uri.parse('$_baseUrl/flights/get_price/');

      final response = await _client.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: json.encode(params.toJson()),
      );

      if (response.statusCode == 200) {
        final jsonResponse =
        json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
        // On passe le corps entier de la réponse au modèle pour le parsing
        return FlightPriceResponseModel.fromJson(jsonResponse);
      } else {
        throw ServerException(
          message: 'Échec de la tarification du vol: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(
          message:
          'Erreur réseau durant la tarification: ${e.toString()}');
    }
  }
}