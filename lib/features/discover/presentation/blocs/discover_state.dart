part of 'discover_bloc.dart';

@immutable
abstract class DiscoverState extends Equatable {
  const DiscoverState();

  @override
  List<Object?> get props => [];
}

class DiscoverInitial extends DiscoverState {
  const DiscoverInitial();
}

class DiscoverLoading extends DiscoverState {
  const DiscoverLoading();
}

class DiscoverLoaded extends DiscoverState {
  final List<Destination> destinations;
  final bool hasMore;

  const DiscoverLoaded({
    required this.destinations,
    this.hasMore = true,
  });

  @override
  List<Object?> get props => [destinations, hasMore];
}

class DiscoverLoadingMore extends DiscoverState {
  final List<Destination> destinations;

  const DiscoverLoadingMore({required this.destinations});

  @override
  List<Object?> get props => [destinations];
}

class DiscoverError extends DiscoverState {
  final String message;

  const DiscoverError({required this.message});

  @override
  List<Object?> get props => [message];
}