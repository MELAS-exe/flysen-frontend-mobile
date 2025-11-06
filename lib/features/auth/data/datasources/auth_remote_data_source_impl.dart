// Copyright (c) 2022, Adryan Eka Vandra
// https://github.com/adryanev/flutter-template-architecture-template
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:convert';
import 'package:flysen_frontend_mobile/core/domain/failures/exceptions.dart';
import 'package:flysen_frontend_mobile/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flysen_frontend_mobile/features/auth/data/models/anonymous_user_model.dart';
import 'package:flysen_frontend_mobile/features/auth/data/models/sign_in_request.dart';
import 'package:flysen_frontend_mobile/features/auth/data/models/sign_up_request.dart';
import 'package:flysen_frontend_mobile/features/auth/data/models/sign_up_response_model.dart';
import 'package:flysen_frontend_mobile/features/auth/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

/// Implementation of AuthRemoteDataSource using HTTP client
@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client _client;
  final String _baseUrl;

  AuthRemoteDataSourceImpl(
      this._client,
      @Named('baseUrl') this._baseUrl,
      );

  @override
  Future<UserModel> signIn(SignInRequest request) async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/auth/signin/'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
        return UserModel.fromJson(jsonResponse);
      } else {
        throw ServerException(
          message: 'Failed to sign in: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: 'Network error: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> signInAnonymously() async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/auth/signin-anonymous/'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
        return AnonymousUserModel.fromJson(jsonResponse);
      } else {
        throw ServerException(
          message: 'Failed to sign in anonymously: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: 'Network error: ${e.toString()}');
    }
  }

  @override
  Future<SignUpResponseModel> signUp(SignUpRequest request) async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/auth/signup/'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(request.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
        return SignUpResponseModel.fromJson(jsonResponse);
      } else {
        throw ServerException(
          message: 'Failed to sign up: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: 'Network error: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut(String idToken) async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/auth/signout/'),
        headers: {
          'Authorization': 'Bearer $idToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode != 200) {
        throw ServerException(
          message: 'Failed to sign out: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: 'Network error: ${e.toString()}');
    }
  }
}