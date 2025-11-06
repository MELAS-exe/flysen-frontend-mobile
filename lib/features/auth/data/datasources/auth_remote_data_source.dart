// Copyright (c) 2022, Adryan Eka Vandra
// https://github.com/adryanev/flutter-template-architecture-template
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flysen_frontend_mobile/features/auth/data/models/sign_in_request.dart';
import 'package:flysen_frontend_mobile/features/auth/data/models/sign_up_request.dart';
import 'package:flysen_frontend_mobile/features/auth/data/models/sign_up_response_model.dart';
import 'package:flysen_frontend_mobile/features/auth/data/models/user_model.dart';

/// Interface for authentication remote data source
abstract interface class AuthRemoteDataSource {
  /// Signs in user with email and password
  /// Returns [UserModel] on success
  /// Throws [ServerException] on error
  Future<UserModel> signIn(SignInRequest request);


  Future<UserModel> signInAnonymously();
  /// Signs up a new user with email and password
  /// Returns [SignUpResponseModel] on success
  /// Throws [ServerException] on error
  Future<SignUpResponseModel> signUp(SignUpRequest request);

  /// Signs out user with token
  /// Throws [ServerException] on error
  Future<void> signOut(String idToken);
}