// Copyright (c) 2022, Adryan Eka Vandra
// https://github.com/adryanev/flutter-template-architecture-template
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flysen_frontend_mobile/features/auth/data/models/user_model.dart';
import 'package:flysen_frontend_mobile/features/auth/domain/entities/anonymous_user.dart';

/// Data Transfer Object for AnonymousUser
class AnonymousUserModel extends UserModel {
  const AnonymousUserModel({
    required super.idToken,
    required super.refreshToken,
    required super.expiresIn,
    required this.uid,
  }) : super(email: 'anonymous');

  final String uid;

  /// Creates an AnonymousUserModel from JSON
  factory AnonymousUserModel.fromJson(Map<String, dynamic> json) {
    return AnonymousUserModel(
      idToken: json['idToken'] as String,
      refreshToken: json['refreshToken'] as String,
      expiresIn: json['expiresIn'] as String,
      uid: json['uid'] as String,
    );
  }

  /// Converts AnonymousUserModel to JSON
  @override
  Map<String, dynamic> toJson() {
    return {
      'idToken': idToken,
      'refreshToken': refreshToken,
      'expiresIn': expiresIn,
      'email': 'anonymous',
      'uid': uid,
    };
  }

  /// Converts AnonymousUserModel to AnonymousUser entity
  AnonymousUser toAnonymousEntity() {
    return AnonymousUser(
      idToken: idToken,
      refreshToken: refreshToken,
      expiresIn: expiresIn,
      uid: uid,
    );
  }

  /// Creates AnonymousUserModel from AnonymousUser entity
  factory AnonymousUserModel.fromEntity(AnonymousUser user) {
    return AnonymousUserModel(
      idToken: user.idToken,
      refreshToken: user.refreshToken,
      expiresIn: user.expiresIn,
      uid: user.uid,
    );
  }
}