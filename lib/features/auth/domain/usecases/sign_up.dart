// Copyright (c) 2022, Adryan Eka Vandra
// https://github.com/adryanev/flutter-template-architecture-template
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:dartz/dartz.dart';
import 'package:flysen_frontend_mobile/core/domain/failures/failure.dart';
import 'package:flysen_frontend_mobile/core/domain/usecases/use_case.dart';
import 'package:flysen_frontend_mobile/features/auth/domain/entities/sign_up_params.dart';
import 'package:flysen_frontend_mobile/features/auth/domain/entities/sign_up_response.dart';
import 'package:flysen_frontend_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

/// Use case for signing up a new user
@lazySingleton
class SignUp extends UseCase<SignUpResponse, SignUpParams> {
  final AuthRepository _repository;

  SignUp(this._repository);

  @override
  Future<Either<ServerFailure, SignUpResponse>> call(SignUpParams params) {
    return _repository.signUp(params);
  }
}