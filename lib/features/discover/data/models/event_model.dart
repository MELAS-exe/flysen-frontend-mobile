import 'package:equatable/equatable.dart';
import 'package:flysen_frontend_mobile/features/discover/domain/entities/event_entity.dart';

// Organizer Model
class OrganizerModel extends Equatable {
  final String? name;
  final String? email;
  final String? phone;
  final String? website;

  const OrganizerModel({this.name, this.email, this.phone, this.website});

  factory OrganizerModel.fromJson(Map<String, dynamic> json) {
    return OrganizerModel(
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      website: json['website'] as String?,
    );
  }

  // --- ADDED: Conversion to entity ---
  OrganizerEntity toEntity() {
    return OrganizerEntity(
      name: name,
      email: email,
      phone: phone,
      website: website,
    );
  }

  @override
  List<Object?> get props => [name, email, phone, website];
}

// Stats Model
class StatsModel extends Equatable {
  final int totalBookings;
  final int totalViews;
  final double averageRating;
  final int totalReviews;

  const StatsModel({
    required this.totalBookings,
    required this.totalViews,
    required this.averageRating,
    required this.totalReviews,
  });

  factory StatsModel.fromJson(Map<String, dynamic> json) {
    return StatsModel(
      totalBookings: json['totalBookings'] as int? ?? 0,
      totalViews: json['totalViews'] as int? ?? 0,
      averageRating: (json['averageRating'] as num? ?? 0.0).toDouble(),
      totalReviews: json['totalReviews'] as int? ?? 0,
    );
  }

  // --- ADDED: Conversion to entity ---
  EventStatsEntity toEntity() {
    return EventStatsEntity(
      averageRating: averageRating,
      totalReviews: totalReviews,
    );
  }

  @override
  List<Object?> get props =>
      [totalBookings, totalViews, averageRating, totalReviews];
}

// Main Event Model
class EventModel extends Equatable {
  final String id;
  final String name;
  final String type;
  final String destinationName;
  final DateTime date;
  final List<String> images;
  final OrganizerModel? organizer;
  final StatsModel stats;
  // --- ADDED: Fields from API response ---
  final String description;
  final String venue;

  const EventModel({
    required this.id,
    required this.name,
    required this.type,
    required this.destinationName,
    required this.date,
    required this.images,
    this.organizer,
    required this.stats,
    // --- ADDED: Fields to constructor ---
    required this.description,
    required this.venue,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Unnamed Event',
      type: json['type'] as String? ?? 'GENERAL',
      destinationName: json['destinationName'] as String? ?? 'Unknown Location',
      date: DateTime.tryParse(json['date'] as String? ?? '') ?? DateTime.now(),
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      organizer: json['organizer'] != null
          ? OrganizerModel.fromJson(json['organizer'] as Map<String, dynamic>)
          : null,
      stats: StatsModel.fromJson(json['stats'] as Map<String, dynamic>),
      // --- ADDED: Parsing from JSON ---
      description: json['description'] as String? ?? '',
      venue: json['venue'] as String? ?? 'Not specified',
    );
  }

  // --- ADDED: Conversion to entity ---
  EventEntity toEntity() {
    return EventEntity(
      id: id,
      name: name,
      destinationName: destinationName,
      date: date,
      images: images,
      description: description,
      venue: venue,
      organizer: organizer?.toEntity(),
      stats: stats.toEntity(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        destinationName,
        date,
        images,
        organizer,
        stats,
        description,
        venue,
      ];
}
