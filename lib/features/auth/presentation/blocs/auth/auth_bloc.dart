// Copyright (c) 2022, Adryan Eka Vandra
// https://github.com/adryanev/flutter-template-architecture-template
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flysen_frontend_mobile/core/domain/failures/failure.dart';
import 'package:flysen_frontend_mobile/core/domain/usecases/use_case.dart';
import 'package:flysen_frontend_mobile/features/auth/domain/entities/sign_in_params.dart';
import 'package:flysen_frontend_mobile/features/auth/domain/entities/sign_up_params.dart';
import 'package:flysen_frontend_mobile/features/auth/domain/entities/user.dart';
import 'package:flysen_frontend_mobile/features/auth/domain/usecases/get_current_user.dart';
import 'package:flysen_frontend_mobile/features/auth/domain/usecases/sign_in.dart';
import 'package:flysen_frontend_mobile/features/auth/domain/usecases/sign_in_anonymously.dart';
import 'package:flysen_frontend_mobile/features/auth/domain/usecases/sign_out.dart';
import 'package:flysen_frontend_mobile/features/auth/domain/usecases/sign_up.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// BLoC for managing authentication state
@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignIn _signIn;
  final SignUp _signUp;
  final SignInAnonymously _signInAnonymously;
  final SignOut _signOut;
  final GetCurrentUser _getCurrentUser;

  AuthBloc(
    this._signIn,
    this._signUp,
    this._signInAnonymously,
    this._signOut,
    this._getCurrentUser,
  ) : super(const AuthInitial()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<SignInAnonymouslyRequested>(_onSignInAnonymouslyRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<GetCurrentUserRequested>(_onGetCurrentUserRequested);
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final params = SignInParams(
      email: event.email,
      password: event.password,
    );

    final result = await _signIn(params);

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(Authenticated(user)),
    );
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final params = SignUpParams(
      email: event.email,
      password: event.password,
    );

    final result = await _signUp(params);

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (response) => emit(SignUpSuccess(response.uid, response.message)),
    );
  }

  Future<void> _onSignInAnonymouslyRequested(
    SignInAnonymouslyRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await _signInAnonymously(NoParams());

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(Authenticated(user)),
    );
  }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    // Get current user to retrieve token
    final userResult = await _getCurrentUser(NoParams());

    await userResult.fold(
      (failure) async {
        // If can't get user, just emit unauthenticated
        emit(const Unauthenticated());
      },
      (user) async {
        // Sign out with token
        final params = SignOutParams(user.idToken);
        final result = await _signOut(params);

        result.fold(
          (failure) {
            if (failure is ServerFailure) {
              emit(AuthError(failure.message));
            }
            if (failure is LocalFailure) {
              emit(AuthError(failure.message));
            }
          },
          (_) {
            emit(const Unauthenticated());},
        );
      },
    );
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await _getCurrentUser(NoParams());

    result.fold(
      (_) => emit(const Unauthenticated()),
      (user) => emit(Authenticated(user)),
    );
  }

  Future<void> _onGetCurrentUserRequested(
    GetCurrentUserRequested event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _getCurrentUser(NoParams());

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(Authenticated(user)),
    );
  }
}
