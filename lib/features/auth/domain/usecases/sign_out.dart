// Copyright (c) 2022, Adryan Eka Vandra
// https://github.com/adryanev/flutter-template-architecture-template
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flysen_frontend_mobile/core/domain/failures/failure.dart';
import 'package:flysen_frontend_mobile/core/domain/usecases/use_case.dart';
import 'package:flysen_frontend_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

/// Parameters for sign out
class SignOutParams extends Equatable {
  const SignOutParams(this.idToken);

  final String idToken;

  @override
  List<Object?> get props => [idToken];
}

/// Use case for signing out a user
@lazySingleton
class SignOut extends UseCase<void, SignOutParams> {
  final AuthRepository _repository;

  SignOut(this._repository);

  @override
  Future<Either<Failure, void>> call(SignOutParams params) {
    return _repository.signOut(params.idToken);
  }
}