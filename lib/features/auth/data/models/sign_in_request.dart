// Copyright (c) 2022, Adryan Eka Vandra
// https://github.com/adryanev/flutter-template-architecture-template
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flysen_frontend_mobile/features/auth/domain/entities/sign_in_params.dart';

/// Request payload for sign in
class SignInRequest {
  const SignInRequest({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  /// Creates SignInRequest from SignInParams entity
  factory SignInRequest.fromParams(SignInParams params) {
    return SignInRequest(
      email: params.email,
      password: params.password,
    );
  }

  /// Converts to JSON for API request
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}