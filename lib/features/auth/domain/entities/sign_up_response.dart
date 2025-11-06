// Copyright (c) 2022, Adryan Eka Vandra
// https://github.com/adryanev/flutter-template-architecture-template
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:equatable/equatable.dart';

/// Entity representing a sign up response
class SignUpResponse extends Equatable {
  const SignUpResponse({
    required this.uid,
    required this.message,
  });

  final String uid;
  final String message;

  @override
  List<Object?> get props => [uid, message];
}