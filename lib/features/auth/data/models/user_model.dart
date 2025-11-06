// Copyright (c) 2022, Adryan Eka Vandra
// https://github.com/adryanev/flutter-template-architecture-template
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flysen_frontend_mobile/features/auth/domain/entities/user.dart';

/// Data Transfer Object for User
class UserModel extends User {
  const UserModel({
    required super.idToken,
    required super.refreshToken,
    required super.expiresIn,
    required super.email,
  });

  /// Creates a UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      idToken: json['idToken'] as String,
      refreshToken: json['refreshToken'] as String,
      expiresIn: json['expiresIn'] as String,
      email: json['email'] as String,
    );
  }

  /// Converts UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'idToken': idToken,
      'refreshToken': refreshToken,
      'expiresIn': expiresIn,
      'email': email,
    };
  }

  /// Converts UserModel to User entity
  User toEntity() {
    return User(
      idToken: idToken,
      refreshToken: refreshToken,
      expiresIn: expiresIn,
      email: email,
    );
  }

  /// Creates UserModel from User entity
  factory UserModel.fromEntity(User user) {
    return UserModel(
      idToken: user.idToken,
      refreshToken: user.refreshToken,
      expiresIn: user.expiresIn,
      email: user.email,
    );
  }
}