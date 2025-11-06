// Copyright (c) 2022, Adryan Eka Vandra
// https://github.com/adryanev/flutter-template-architecture-template
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flysen_frontend_mobile/features/auth/data/models/user_model.dart';

/// Interface for authentication local data source
abstract interface class AuthLocalDataSource {
  /// Saves user data locally
  Future<void> saveUser(UserModel user);

  /// Gets cached user data
  Future<UserModel?> getCachedUser();

  /// Removes cached user data
  Future<void> removeUser();

  /// Checks if user is cached
  Future<bool> hasUser();
}