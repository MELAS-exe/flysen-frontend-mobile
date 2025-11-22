import 'package:dartz/dartz.dart';
import 'package:flysen_frontend_mobile/core/domain/failures/exceptions.dart';
import 'package:flysen_frontend_mobile/core/domain/failures/failure.dart';
import 'package:flysen_frontend_mobile/features/auth/domain/repositories/auth_repository.dart'; // Pour obtenir le token
import 'package:flysen_frontend_mobile/features/reservation/data/datasources/flight_remote_datasource.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/entities/flight_offer.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/entities/flight_price_params.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/entities/flight_price_response.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/entities/flight_search_params.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/repositories/flight_repository.dart';
import 'package:injectable/injectable.dart';

// --- Import the new wrapper from the data layer ---
import 'package:flysen_frontend_mobile/features/reservation/data/models/flight_search_response_wrapper.dart';


@LazySingleton(as: FlightRepository)
class ReservationRepositoryImpl implements FlightRepository {
  final FlightRemoteDataSource remoteDataSource;
  final AuthRepository authRepository;

  ReservationRepositoryImpl({
    required this.remoteDataSource,
    required this.authRepository,
  });

  @override
  Future<Either<Failure, FlightSearchResponseWrapper>> getFlights(
      FlightSearchParams params) async {
    try {
      // Obtenir le token d'authentification
      final tokenResult = await authRepository.getCurrentUser();

      return await tokenResult.fold(
            (failure) => Left(failure),
            (user) async {
          if (user == null) {
            return Left(ServerFailure(message: 'Utilisateur non authentifié'));
          }
          // --- The data source now returns the wrapper object ---
          final responseWrapper =
          await remoteDataSource.getFlights(params, user.idToken);

          // --- Return the wrapper directly ---
          return Right(responseWrapper);
        },
      );
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, FlightPriceResponse>> getFlightPrice(
      FlightPriceParams params) async {
    try {
      final tokenResult = await authRepository.getCurrentUser();
      return await tokenResult.fold(
            (failure) => Left(failure),
            (user) async {
          if (user == null) {
            return Left(ServerFailure(message: 'Utilisateur non authentifié'));
          }
          final priceResponseModel =
          await remoteDataSource.getFlightPrice(params, user.idToken);
          return Right(priceResponseModel);
        },
      );
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}