import 'package:dartz/dartz.dart';
import 'package:flysen_frontend_mobile/core/domain/failures/failure.dart';
import 'package:flysen_frontend_mobile/core/domain/usecases/use_case.dart';
import 'package:flysen_frontend_mobile/features/auth/auth.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class RefreshToken implements UseCase<User, NoParams> {
  RefreshToken({required this.repository});

  final AuthRepository repository;
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.refreshToken();
  }
}
