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

final class DiscoverLoaded extends DiscoverState {
  final List<DestinationEntity> destinations;
  final List<EventEntity> featuredEvents; // Add this
  final bool hasReachedMax;

  const DiscoverLoaded({
    required this.destinations,
    required this.featuredEvents, // Add this
    this.hasReachedMax = false,
  });

  // ... copyWith method and props update ...
  DiscoverLoaded copyWith({
    List<DestinationEntity>? destinations,
    List<EventEntity>? featuredEvents, // Add this
    bool? hasReachedMax,
  }) {
    return DiscoverLoaded(
      destinations: destinations ?? this.destinations,
      featuredEvents: featuredEvents ?? this.featuredEvents, // Add this
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [destinations, featuredEvents, hasReachedMax];
}

class DiscoverLoadingMore extends DiscoverState {
  final List<DestinationEntity> destinations;

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
