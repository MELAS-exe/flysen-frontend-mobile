import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flysen_frontend_mobile/core/domain/failures/failure.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/entities/location_entity.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/usecases/search_locations.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

part 'location_search_event.dart';
part 'location_search_state.dart';

@injectable // Make this BLoC injectable
class LocationSearchBloc
    extends Bloc<LocationSearchEvent, LocationSearchState> {
  final SearchLocations _searchLocations;

  LocationSearchBloc(this._searchLocations) : super(LocationSearchInitial()) {
    on<KeywordChanged>(
      _onKeywordChanged,
      // Apply a debounce transformer to avoid excessive API calls
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 300))
          .switchMap(mapper),
    );
    on<ClearSearch>(_onClearSearch);
    on<FetchAndSelectFirst>(_onFetchAndSelectFirst);
    on<SimpleSearch>(_onSimpleSearch);
  }

  Future<void> _onSimpleSearch(
      SimpleSearch event, Emitter<LocationSearchState> emit) async {
    emit(LocationSearchLoading());
    final params =
        SearchLocationsParams(keyword: event.keyword, subType: event.subType);
    final failureOrLocations = await _searchLocations(params);

    failureOrLocations.fold(
      (failure) => emit(LocationSearchError(failure.message)),
      (locations) => emit(LocationSearchLoaded(locations)),
    );
  }

  Future<void> _onKeywordChanged(
      KeywordChanged event, Emitter<LocationSearchState> emit) async {
    if (event.keyword.length < 2) {
      emit(LocationSearchInitial());
      return;
    }

    emit(LocationSearchLoading());

    final params =
        SearchLocationsParams(keyword: event.keyword, subType: event.subType);
    final failureOrLocations = await _searchLocations(params);

    failureOrLocations.fold(
      (failure) => emit(LocationSearchError(failure.message)),
      (locations) => emit(LocationSearchLoaded(locations)),
    );
  }

  void _onClearSearch(ClearSearch event, Emitter<LocationSearchState> emit) {
    emit(LocationSearchInitial());
  }

  // New handler method
  Future<void> _onFetchAndSelectFirst(
      FetchAndSelectFirst event, Emitter<LocationSearchState> emit) async {
    if (event.keyword.length < 2) {
      return; // Do nothing if keyword is too short
    }

    emit(LocationSearchLoading());

    final params =
        SearchLocationsParams(keyword: event.keyword, subType: event.subType);
    final failureOrLocations = await _searchLocations(params);

    failureOrLocations.fold(
      (failure) => emit(LocationSearchError(failure.message)),
      (locations) {
        if (locations.isNotEmpty) {
          // If we found locations, emit the special state with the first one.
          emit(LocationAutoSelected(locations.first));
        } else {
          // Otherwise, indicate an error or that nothing was found.
          emit(const LocationSearchError('No location found for this name.'));
        }
      },
    );
  }
}
