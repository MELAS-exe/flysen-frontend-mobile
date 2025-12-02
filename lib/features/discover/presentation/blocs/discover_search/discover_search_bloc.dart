import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flysen_frontend_mobile/features/discover/domain/entities/destination_entity.dart';
import 'package:flysen_frontend_mobile/features/discover/domain/usecases/search_destinations.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'discover_search_event.dart';
part 'discover_search_state.dart';

@injectable
class DiscoverSearchBloc
    extends Bloc<DiscoverSearchEvent, DiscoverSearchState> {
  final SearchDestinations _searchDestinations;

  DiscoverSearchBloc(this._searchDestinations)
      : super(DiscoverSearchInitial()) {
    on<SearchQueryChanged>(
      _onSearchQueryChanged,
      // Use a debounce transformer to wait for the user to stop typing.
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 400))
          .switchMap(mapper),
    );
    on<ClearSearch>(_onClearSearch);
  }

  Future<void> _onSearchQueryChanged(
      SearchQueryChanged event, Emitter<DiscoverSearchState> emit) async {
    final query = event.query;

    if (query.isEmpty) {
      emit(DiscoverSearchInitial());
      return;
    }

    emit(DiscoverSearchLoading());

    final failureOrDestinations =
        await _searchDestinations(SearchDestinationsParams(query: query));

    failureOrDestinations.fold(
      (failure) => emit(DiscoverSearchError(failure.message)),
      (destinations) => emit(DiscoverSearchLoaded(destinations)),
    );
  }

  void _onClearSearch(ClearSearch event, Emitter<DiscoverSearchState> emit) {
    emit(DiscoverSearchInitial());
  }
}
