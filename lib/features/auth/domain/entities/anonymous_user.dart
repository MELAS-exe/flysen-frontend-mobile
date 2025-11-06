// Copyright (c) 2022, Adryan Eka Vandra
// https://github.com/adryanev/flutter-template-architecture-template
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flysen_frontend_mobile/features/auth/domain/entities/user.dart';

/// Entity representing an anonymous user
class AnonymousUser extends User {
  const AnonymousUser({
    required super.idToken,
    required super.refreshToken,
    required super.expiresIn,
    required this.uid,
  }) : super(email: 'anonymous');

  final String uid;

  @override
  List<Object?> get props => [idToken, refreshToken, expiresIn, uid];
}