// Copyright (c) 2022, Adryan Eka Vandra
// https://github.com/adryanev/flutter-template-architecture-template
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:convert';
import 'package:flysen_frontend_mobile/core/domain/failures/exceptions.dart';
import 'package:flysen_frontend_mobile/features/discover/data/datasources/discover_remote_datasource.dart';
import 'package:flysen_frontend_mobile/features/discover/data/models/destination_model.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

/// Implementation of DiscoverRemoteDataSource using HTTP client
@LazySingleton(as: DiscoverRemoteDataSource)
class DiscoverRemoteDataSourceImpl implements DiscoverRemoteDataSource {
  final http.Client _client;
  final String _baseUrl;

  DiscoverRemoteDataSourceImpl(
      this._client,
      @Named('discoverBaseUrl') this._baseUrl,
      );

  @override
  Future<List<DestinationModel>> getDestinations({
    required String idToken, // 1. Token parameter added
    required int limit,
    String? lastDocumentId,
  }) async {
    try {
      final queryParams = {
        'limit': limit.toString(),
        if (lastDocumentId != null) 'lastDocumentId': lastDocumentId,
      };

      final uri =
      Uri.parse('$_baseUrl/destinations').replace(queryParameters: queryParams);

      final response = await _client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $idToken', // 2. Token added to headers
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse =
        json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
        final dataList = jsonResponse['data'] as List;
        return dataList
            .map((item) =>
            DestinationModel.fromJson(item as Map<String, dynamic>))
            .toList();
      } else if (response.statusCode == 403) {
        // Lève une exception spécifique pour l'erreur 403
        throw AuthException(message: 'Accès non autorisé ou token expiré');
      } else {
        // Gère les autres erreurs serveur
        throw ServerException(
          message:
          'Échec du chargement de la page Découvrir: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is ServerException || e is AuthException) {
        rethrow; // Fait remonter l'exception personnalisée
      }
      // Gère les erreurs réseau (pas de connexion, etc.)
      throw ServerException(message: 'Erreur réseau: ${e.toString()}');
    }
  }
}