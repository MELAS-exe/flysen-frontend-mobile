import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flysen_frontend_mobile/core/domain/failures/failure.dart';
import 'package:flysen_frontend_mobile/core/domain/usecases/use_case.dart';
import 'package:flysen_frontend_mobile/features/discover/domain/entities/destination_entity.dart';
import 'package:flysen_frontend_mobile/features/discover/domain/entities/event_entity.dart';
import 'package:flysen_frontend_mobile/features/discover/domain/usecases/get_destinations.dart';
import 'package:flysen_frontend_mobile/features/discover/domain/usecases/get_featured_events.dart';
import 'package:injectable/injectable.dart';

part 'discover_event.dart';
part 'discover_state.dart';

@injectable
class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  final GetDestinations _getDestinations;
  final GetFeaturedEvents _getFeaturedEvents;

  DiscoverBloc(this._getDestinations, this._getFeaturedEvents)
      : super(const DiscoverInitial()) {
    on<LoadInitialData>(_onLoadInitialData);
    on<LoadMoreDestinations>(_onLoadMoreDestinations);
  }

  Future<void> _onLoadInitialData(
      LoadInitialData event, Emitter<DiscoverState> emit) async {
    emit(DiscoverLoading());

    // Fetch both featured events and destinations in parallel
    final results = await Future.wait([
      _getFeaturedEvents(NoParams()),
      _getDestinations(const GetDestinationsParams(limit: 10)),
    ]);

    final eventsResult = results[0] as Either<Failure, List<EventEntity>>;
    final destinationsResult =
        results[1] as Either<Failure, List<DestinationEntity>>;

    // Handle potential failures
    Failure? anyFailure;
    eventsResult.fold((f) => anyFailure = f, (r) => null);
    destinationsResult.fold((f) => anyFailure = f, (r) => null);

    if (anyFailure is AuthFailure) {
      emit(DiscoverAuthenticationError(anyFailure!.message));
      return;
    }
    if (anyFailure != null) {
      emit(DiscoverError(message: anyFailure!.message));
      return;
    }

    // Both succeeded, emit the loaded state
    emit(DiscoverLoaded(
      featuredEvents: eventsResult.getOrElse(() => []),
      destinations: destinationsResult.getOrElse(() => []),
      hasReachedMax: destinationsResult.getOrElse(() => []).length < 10,
    ));
  }

  Future<void> _onLoadMoreDestinations(
    LoadMoreDestinations event,
    Emitter<DiscoverState> emit,
  ) async {
    final currentState = state;
    if (currentState is! DiscoverLoaded || currentState.hasReachedMax) return;

    final result = await _getDestinations(
      GetDestinationsParams(
        limit: event.limit,
        lastDocumentId: event.lastDocumentId,
      ),
    );

    result.fold(
      (failure) => emit(DiscoverError(message: failure.message)),
      (newDestinations) {
        emit(
          currentState.copyWith(
            destinations: currentState.destinations + newDestinations,
            hasReachedMax: newDestinations.length < event.limit,
          ),
        );
      },
    );
  }
}
