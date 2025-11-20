part of 'discover_bloc.dart';

@immutable
abstract class DiscoverEvent extends Equatable {
  const DiscoverEvent();

  @override
  List<Object?> get props => [];
}

class DiscoverAuthenticationError extends DiscoverState {
  final String message;
  const DiscoverAuthenticationError(this.message);

  @override
  List<Object> get props => [message];
}

class LoadDestinations extends DiscoverEvent {
  final int limit;
  final String? lastDocumentId;

  const LoadDestinations({
    this.limit = 20,
    this.lastDocumentId,
  });

  @override
  List<Object?> get props => [limit, lastDocumentId];
}

class LoadMoreDestinations extends DiscoverEvent {
  final int limit;
  final String lastDocumentId;

  const LoadMoreDestinations({
    this.limit = 20,
    required this.lastDocumentId,
  });

  @override
  List<Object?> get props => [limit, lastDocumentId];
}