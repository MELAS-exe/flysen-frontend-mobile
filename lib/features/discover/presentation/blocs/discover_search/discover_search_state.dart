part of 'discover_search_bloc.dart';

@immutable
sealed class DiscoverSearchState extends Equatable {
  const DiscoverSearchState();

  @override
  List<Object> get props => [];
}

/// The initial state before any search is performed.
final class DiscoverSearchInitial extends DiscoverSearchState {}

/// State indicating that a search is in progress.
final class DiscoverSearchLoading extends DiscoverSearchState {}

/// State indicating that the destinations have been successfully loaded.
final class DiscoverSearchLoaded extends DiscoverSearchState {
  final List<DestinationEntity> destinations;

  const DiscoverSearchLoaded(this.destinations);

  @override
  List<Object> get props => [destinations];
}

/// State indicating that an error occurred during the search.
final class DiscoverSearchError extends DiscoverSearchState {
  final String message;

  const DiscoverSearchError(this.message);

  @override
  List<Object> get props => [message];
}
