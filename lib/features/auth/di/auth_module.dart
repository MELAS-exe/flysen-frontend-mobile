// Copyright (c) 2022, Adryan Eka Vandra
// https://github.com/adryanev/flutter-template-architecture-template
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

/// Dependency injection module for authentication feature
@module
abstract class AuthModule {
  /// Provides HTTP client instance
  @lazySingleton
  http.Client get httpClient => http.Client();

  /// Provides base URL for API
  @Named('baseUrl')
  @lazySingleton
  String get baseUrl => 'http://10.0.2.2:8000';
}