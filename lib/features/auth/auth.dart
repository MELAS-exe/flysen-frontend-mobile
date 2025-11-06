// Copyright (c) 2022, Adryan Eka Vandra
// https://github.com/adryanev/flutter-template-architecture-template
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

// Domain Layer Exports
export 'domain/entities/user.dart';
export 'domain/entities/anonymous_user.dart';
export 'domain/entities/sign_in_params.dart';
export 'domain/entities/sign_up_params.dart';
export 'domain/entities/sign_up_response.dart';
export 'domain/repositories/auth_repository.dart';
export 'domain/usecases/sign_in.dart';
export 'domain/usecases/sign_up.dart';
export 'domain/usecases/sign_in_anonymously.dart';
export 'domain/usecases/sign_out.dart';
export 'domain/usecases/get_current_user.dart';

// Data Layer Exports
export 'data/models/user_model.dart';
export 'data/models/anonymous_user_model.dart';
export 'data/models/sign_in_request.dart';
export 'data/models/sign_up_request.dart';
export 'data/models/sign_up_response_model.dart';
export 'data/datasources/auth_remote_data_source.dart';
export 'data/datasources/auth_remote_data_source_impl.dart';
export 'data/datasources/auth_local_data_source.dart';
export 'data/datasources/auth_local_data_source_impl.dart';
export 'data/repositories/auth_repository_impl.dart';

// Presentation Layer Exports
export 'presentation/blocs/auth/auth_bloc.dart';

// DI Module
export 'di/auth_module.dart';