import 'package:dartz/dartz.dart';
import 'package:flysen_frontend_mobile/core/domain/failures/exceptions.dart';
import 'package:flysen_frontend_mobile/core/domain/failures/failure.dart';
import 'package:flysen_frontend_mobile/features/auth/auth.dart';
import 'package:flysen_frontend_mobile/features/discover/data/datasources/discover_remote_datasource.dart';
import 'package:flysen_frontend_mobile/features/discover/domain/entities/destination.dart';
import 'package:flysen_frontend_mobile/features/discover/domain/repositories/discover_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DiscoverRepository)
class DiscoverRepositoryImpl implements DiscoverRepository {
  final DiscoverRemoteDataSource remoteDataSource;
  final AuthRepository authRepository; // 1. Inject AuthRepository

  DiscoverRepositoryImpl({
    required this.remoteDataSource,
    required this.authRepository, // 2. Add to constructor
  });

  @override
  Future<Either<Failure, List<Destination>>> getDestinations({
    required int limit,
    String? lastDocumentId,
  }) async {
    try {
      // 3. Get the current user and their token
      final userResult = await authRepository.getCurrentUser();

      return await userResult.fold(
        // If getting user fails, return the failure
            (failure) => Left(failure),
        // If successful, proceed to get destinations with the token
            (user) async {
          final destinationModels = await remoteDataSource.getDestinations(
            idToken: user.idToken, // 4. Pass the token
            limit: limit,
            lastDocumentId: lastDocumentId,
          );

          final destinations =
          destinationModels.map((model) => model.toEntity()).toList();

          return Right(destinations);
        },
      );
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}