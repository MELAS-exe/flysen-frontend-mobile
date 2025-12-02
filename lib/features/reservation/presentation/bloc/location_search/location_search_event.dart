part of 'location_search_bloc.dart';

abstract class LocationSearchEvent extends Equatable {
  const LocationSearchEvent();

  @override
  List<Object> get props => [];
}

/// Event triggered when the user types in the search field.
class KeywordChanged extends LocationSearchEvent {
  final String keyword;
  final String subType; // e.g., 'CITY' or 'AIRPORT'

  const KeywordChanged({required this.keyword, required this.subType});

  @override
  List<Object> get props => [keyword, subType];
}

/// Event to clear the search results and return to the initial state.
class ClearSearch extends LocationSearchEvent {}

/// Event triggered when the text field loses focus, to auto-select the first result.
class FetchAndSelectFirst extends LocationSearchEvent {
  final String keyword;
  final String subType;

  const FetchAndSelectFirst({required this.keyword, required this.subType});

  @override
  List<Object> get props => [keyword, subType];
}

class SimpleSearch extends LocationSearchEvent {
  SimpleSearch({required this.keyword, required this.subType});

  final String keyword;
  final String subType;

  @override
  List<Object> get props => [keyword, subType];
}
