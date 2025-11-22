// Copyright (c) 2022, Adryan Eka Vandra
// https://github.com/adryanev/flutter-template-architecture-template
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:dartz/dartz.dart';
import 'package:flysen_frontend_mobile/core/domain/failures/exceptions.dart';
import 'package:flysen_frontend_mobile/core/domain/failures/failure.dart';
import 'package:flysen_frontend_mobile/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:flysen_frontend_mobile/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flysen_frontend_mobile/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:flysen_frontend_mobile/features/auth/data/models/sign_in_request.dart';
import 'package:flysen_frontend_mobile/features/auth/data/models/sign_up_request.dart';
import 'package:flysen_frontend_mobile/features/auth/domain/entities/sign_in_params.dart';
import 'package:flysen_frontend_mobile/features/auth/domain/entities/sign_up_params.dart';
import 'package:flysen_frontend_mobile/features/auth/domain/entities/sign_up_response.dart';
import 'package:flysen_frontend_mobile/features/auth/domain/entities/user.dart';
import 'package:flysen_frontend_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

/// Implementation of AuthRepository
@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl(
      this._remoteDataSource,
      this._localDataSource,
      );

  @override
  Future<Either<ServerFailure, User>> signIn(SignInParams params) async {
    try {
      // Create request from params
      final request = SignInRequest.fromParams(params);

      // Call remote data source
      final userModel = await _remoteDataSource.signIn(request);

      // Cache the user locally
      await _localDataSource.saveUser(userModel);

      // Return the user entity
      return Right(userModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<LocalFailure, bool>> isSignedIn() async {
    try {
      final hasUser = await _localDataSource.hasUser();
      return Right(hasUser);
    } catch (e) {
      return Left(
        LocalFailure(message: 'Failed to check sign in status: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<LocalFailure, User>> getCurrentUser() async {
    try {
      final userModel = await _localDataSource.getCachedUser();
      if (userModel != null) {
        return Right(userModel.toEntity());
      }
      return const Left(
        LocalFailure(message: 'No user found'),
      );
    } catch (e) {
      return Left(
        LocalFailure(message: 'Failed to get current user: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<ServerFailure, User>> signInAnonymously() async {
    try {
      // Call remote data source for anonymous sign-in
      final userModel = await _remoteDataSource.signInAnonymously();

      // Cache the user locally
      await _localDataSource.saveUser(userModel);

      // Return the user entity
      return Right(userModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<ServerFailure, SignUpResponse>> signUp(SignUpParams params) async {
    try {
      // Create request from params
      final request = SignUpRequest.fromParams(params);

      // Call remote data source
      final responseModel = await _remoteDataSource.signUp(request);

      // Return the response entity
      return Right(responseModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> signOut(String idToken) async {
    try {
      // Attempt to sign out from the backend.
      await _remoteDataSource.signOut(idToken);
    } on AuthException {
      // If we get an AuthException (e.g., 403 Forbidden), it means the token
      // is already invalid. From the app's perspective, the user is effectively
      // signed out on the backend. We can ignore this error and proceed with
      // local cleanup.
    } on ServerException catch (e) {
      // For other server errors, we still proceed with local cleanup
      // but return the failure to let the caller know something went wrong.
      await _localDataSource.removeUser();
      return Left(ServerFailure(message: e.message));
    } on Exception catch (e) {
      // For any other exception (e.g., network error), we still clean up locally.
      await _localDataSource.removeUser();
      return Left(LocalFailure(message: 'Failed to sign out: ${e.toString()}'));
    }
    await _localDataSource.removeUser();

    // Return success.
    return const Right(null);
  }
}