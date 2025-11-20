import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flysen_frontend_mobile/core/domain/failures/failure.dart';
import 'package:flysen_frontend_mobile/features/discover/domain/entities/destination.dart';
import 'package:flysen_frontend_mobile/features/discover/domain/usecases/get_destinations.dart';
import 'package:injectable/injectable.dart';

part 'discover_event.dart';
part 'discover_state.dart';

@injectable
class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  final GetDestinations _getDestinations;

  DiscoverBloc(this._getDestinations) : super(const DiscoverInitial()) {
    on<LoadDestinations>(_onLoadDestinations);
    on<LoadMoreDestinations>(_onLoadMoreDestinations);
  }

  Future<void> _onLoadDestinations(
      LoadDestinations event,
      Emitter<DiscoverState> emit,
      ) async {
    emit(const DiscoverLoading());

    final result = await _getDestinations(
      GetDestinationsParams(
        limit: event.limit,
        lastDocumentId: event.lastDocumentId,
      ),
    );

    result.fold(
          (failure) {
        if (failure is AuthFailure) {
          emit(DiscoverAuthenticationError(failure.message));
        } else {
          emit(DiscoverError(message: failure.message,));
        }},
          (destinations) => emit(
        DiscoverLoaded(
          destinations: destinations,
          hasMore: destinations.length >= event.limit,
        ),
      ),
    );
  }

  Future<void> _onLoadMoreDestinations(
      LoadMoreDestinations event,
      Emitter<DiscoverState> emit,
      ) async {
    final currentState = state;
    if (currentState is! DiscoverLoaded) return;

    emit(DiscoverLoadingMore(destinations: currentState.destinations));

    final result = await _getDestinations(
      GetDestinationsParams(
        limit: event.limit,
        lastDocumentId: event.lastDocumentId,
      ),
    );

    result.fold(
          (failure) => emit(DiscoverError(message: failure.message)),
          (newDestinations) {
        final allDestinations = [
          ...currentState.destinations,
          ...newDestinations,
        ];
        emit(
          DiscoverLoaded(
            destinations: allDestinations,
            hasMore: newDestinations.length >= event.limit,
          ),
        );
      },
    );
  }
}