// Copyright (c) 2022, Adryan Eka Vandra
// https://github.com/adryanev/flutter-template-architecture-template
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:convert';
import 'package:flysen_frontend_mobile/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:flysen_frontend_mobile/features/auth/data/models/user_model.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Implementation of AuthLocalDataSource using SharedPreferences
@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences _sharedPreferences;
  static const String _userKey = 'cached_user';

  AuthLocalDataSourceImpl(this._sharedPreferences);

  @override
  Future<UserModel?> getCachedUser() async {
    final userJson = _sharedPreferences.getString(_userKey);
    if (userJson != null) {
      return UserModel.fromJson(
        json.decode(userJson) as Map<String, dynamic>,
      );
    }
    return null;
  }

  @override
  Future<bool> hasUser() async {
    return _sharedPreferences.containsKey(_userKey);
  }

  @override
  Future<void> removeUser() async {
    await _sharedPreferences.remove(_userKey);
  }

  @override
  Future<void> saveUser(UserModel user) async {
    await _sharedPreferences.setString(
      _userKey,
      json.encode(user.toJson()),
    );
  }
}