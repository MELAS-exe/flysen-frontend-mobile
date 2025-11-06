// Copyright (c) 2022, Adryan Eka Vandra
// https://github.com/adryanev/flutter-template-architecture-template
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:dartz/dartz.dart';
import 'package:flysen_frontend_mobile/core/domain/failures/failure.dart';
import 'package:flysen_frontend_mobile/core/domain/usecases/use_case.dart';
import 'package:flysen_frontend_mobile/features/auth/domain/entities/user.dart';
import 'package:flysen_frontend_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

/// Use case for getting the current signed in user
@lazySingleton
class GetCurrentUser extends UseCase<User, NoParams> {
  final AuthRepository _repository;

  GetCurrentUser(this._repository);

  @override
  Future<Either<LocalFailure, User>> call(NoParams params) {
    return _repository.getCurrentUser();
  }
}