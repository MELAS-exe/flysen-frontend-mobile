part of 'location_search_bloc.dart';

abstract class LocationSearchState extends Equatable {
  const LocationSearchState();

  @override
  List<Object> get props => [];
}

/// The initial state, no search performed or search cleared.
class LocationSearchInitial extends LocationSearchState {}

/// State while fetching data from the API.
class LocationSearchLoading extends LocationSearchState {}

/// State when the locations have been successfully loaded.
class LocationSearchLoaded extends LocationSearchState {
  final List<LocationEntity> locations;

  const LocationSearchLoaded(this.locations);

  @override
  List<Object> get props => [locations];
}

/// State when an error occurs during the fetch.
class LocationSearchError extends LocationSearchState {
  final String message;

  const LocationSearchError(this.message);

  @override
  List<Object> get props => [message];
}

/// State when a single location has been auto-selected.
class LocationAutoSelected extends LocationSearchState {
  final LocationEntity location;

  const LocationAutoSelected(this.location);

  @override
  List<Object> get props => [location];
}
