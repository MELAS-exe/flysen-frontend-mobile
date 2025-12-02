import 'package:equatable/equatable.dart';

// Entity for the event organizer
class OrganizerEntity extends Equatable {
  final String? name;
  final String? email;
  final String? phone;
  final String? website;

  const OrganizerEntity({
    this.name,
    this.email,
    this.phone,
    this.website,
  });

  @override
  List<Object?> get props => [name, email, phone, website];
}

// Entity for event statistics
class EventStatsEntity extends Equatable {
  final double averageRating;
  final int totalReviews;

  const EventStatsEntity({
    required this.averageRating,
    required this.totalReviews,
  });

  @override
  List<Object?> get props => [averageRating, totalReviews];
}

class EventEntity extends Equatable {
  final String id;
  final String name;
  final String destinationName;
  final DateTime date;
  final List<String> images;
  final String description;
  final String venue;
  final OrganizerEntity? organizer;
  final EventStatsEntity stats;

  const EventEntity({
    required this.id,
    required this.name,
    required this.destinationName,
    required this.date,
    required this.images,
    required this.description,
    required this.venue,
    required this.organizer,
    required this.stats,
  });

  String get firstImage => images.isNotEmpty ? images.first : '';

  @override
  List<Object?> get props => [
        id,
        name,
        destinationName,
        date,
        images,
        description,
        venue,
        organizer,
        stats,
      ];
}
