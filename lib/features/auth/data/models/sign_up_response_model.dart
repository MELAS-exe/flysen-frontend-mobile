// Copyright (c) 2022, Adryan Eka Vandra
// https://github.com/adryanev/flutter-template-architecture-template
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flysen_frontend_mobile/features/auth/domain/entities/sign_up_response.dart';

/// Data Transfer Object for SignUpResponse
class SignUpResponseModel extends SignUpResponse {
  const SignUpResponseModel({
    required super.uid,
    required super.message,
  });

  /// Creates a SignUpResponseModel from JSON
  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) {
    return SignUpResponseModel(
      uid: json['uid'] as String,
      message: json['message'] as String,
    );
  }

  /// Converts SignUpResponseModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'message': message,
    };
  }

  /// Converts SignUpResponseModel to SignUpResponse entity
  SignUpResponse toEntity() {
    return SignUpResponse(
      uid: uid,
      message: message,
    );
  }

  /// Creates SignUpResponseModel from SignUpResponse entity
  factory SignUpResponseModel.fromEntity(SignUpResponse response) {
    return SignUpResponseModel(
      uid: response.uid,
      message: response.message,
    );
  }
}