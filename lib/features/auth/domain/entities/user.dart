// Copyright (c) 2022, Adryan Eka Vandra
// https://github.com/adryanev/flutter-template-architecture-template
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:equatable/equatable.dart';

/// Business entity representing a User
class User extends Equatable {
  const User({
    required this.idToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.email,
  });

  final String idToken;
  final String refreshToken;
  final String expiresIn;
  final String email;

  @override
  List<Object?> get props => [idToken, refreshToken, expiresIn, email];
}