import 'package:dartz/dartz.dart';
import 'package:flysen_frontend_mobile/core/domain/failures/exceptions.dart';
import 'package:flysen_frontend_mobile/core/domain/failures/failure.dart';
import 'package:flysen_frontend_mobile/features/airport_services/data/datasources/airpot_services_remote_datasource.dart';
import 'package:flysen_frontend_mobile/features/airport_services/domain/entities/airport_service_entity.dart';
import 'package:flysen_frontend_mobile/features/airport_services/domain/repositories/airport_services_repository.dart';
import 'package:flysen_frontend_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AirportServicesRepository)
class AirportServicesRepositoryImpl implements AirportServicesRepository {
  final AirportServicesRemoteDataSource remoteDataSource;
  final AuthRepository authRepository;

  AirportServicesRepositoryImpl(
      {required this.remoteDataSource, required this.authRepository});

  @override
  Future<Either<Failure, List<AirportServiceEntity>>> getServicesForAirport(
      String airportId) async {
    try {
      final userResult = await authRepository.getCurrentUser();

      return await userResult.fold((failure) => Left(failure), (user) async {
        final serviceModels = await remoteDataSource.getServicesForAirport(
            airportId, user.idToken);
        final serviceEntities = serviceModels.map((model) {
          return AirportServiceEntity(
            id: model.id,
            name: model.name,
            category: model.category,
            description: model.description,
            logo: model.logo,
            images: model.images,
            rating: model.rating,
            reviewsCount: model.reviewsCount,
          );
        }).toList();
        return Right(serviceEntities);
      });
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
