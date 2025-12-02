part of 'discover_search_bloc.dart';

@immutable
sealed class DiscoverSearchEvent {}

/// Event triggered when the user types in the search bar.
class SearchQueryChanged extends DiscoverSearchEvent {
  final String query;

  SearchQueryChanged(this.query);
}

/// Event to clear the search results and return to an initial state.
class ClearSearch extends DiscoverSearchEvent {}
