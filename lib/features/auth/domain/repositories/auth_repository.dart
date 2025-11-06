// Copyright (c) 2022, Adryan Eka Vandra
// https://github.com/adryanev/flutter-template-architecture-template
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:dartz/dartz.dart';
import 'package:flysen_frontend_mobile/core/domain/failures/failure.dart';
import 'package:flysen_frontend_mobile/features/auth/domain/entities/sign_in_params.dart';
import 'package:flysen_frontend_mobile/features/auth/domain/entities/sign_up_params.dart';
import 'package:flysen_frontend_mobile/features/auth/domain/entities/sign_up_response.dart';
import 'package:flysen_frontend_mobile/features/auth/domain/entities/user.dart';

/// Interface defining authentication repository contract
abstract interface class AuthRepository {
  /// Signs in a user with email and password
  /// Returns [User] on success or [Failure] on error
  Future<Either<ServerFailure, User>> signIn(SignInParams params);

  /// Signs out the current user
  /// Requires [idToken] for backend sign-out
  Future<Either<Failure, void>> signOut(String idToken);

  /// Checks if a user is currently signed in
  Future<Either<LocalFailure, bool>> isSignedIn();

  /// Gets the current user if signed in
  Future<Either<LocalFailure, User>> getCurrentUser();

  /// Signs in anonymously
  /// Returns [User] on success or [Failure] on error
  Future<Either<ServerFailure, User>> signInAnonymously();

  /// Signs up a new user with email and password
  /// Returns [SignUpResponse] on success or [Failure] on error
  Future<Either<ServerFailure, SignUpResponse>> signUp(SignUpParams params);

}