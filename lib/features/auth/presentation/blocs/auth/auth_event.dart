// Copyright (c) 2022, Adryan Eka Vandra
// https://github.com/adryanev/flutter-template-architecture-template
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

part of 'auth_bloc.dart';

/// Base class for all authentication events
sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Event to sign in a user
class SignInRequested extends AuthEvent {
  const SignInRequested({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

/// Event to sign in anonymously
class SignInAnonymouslyRequested extends AuthEvent {
  const SignInAnonymouslyRequested();
}

/// Event to sign out the current user
class SignOutRequested extends AuthEvent {
  const SignOutRequested();
}

/// Event to check if user is signed in
class CheckAuthStatus extends AuthEvent {
  const CheckAuthStatus();
}

/// Event to get the current user
class GetCurrentUserRequested extends AuthEvent {
  const GetCurrentUserRequested();
}

/// Event to sign up a new user
class SignUpRequested extends AuthEvent {
  const SignUpRequested({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}