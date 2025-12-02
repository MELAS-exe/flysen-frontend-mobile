import 'package:equatable/equatable.dart';

// Using a simplified entity for the list view.
// A more detailed entity can be created for a detail page.
class AirportServiceEntity extends Equatable {
  final String id;
  final String name;
  final String category;
  final String description;
  final String? logo;
  final List<String> images;
  final double rating;
  final int reviewsCount;

  const AirportServiceEntity({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    this.logo,
    required this.images,
    required this.rating,
    required this.reviewsCount,
  });

  String get firstImage => images.isNotEmpty ? images.first : '';

  @override
  List<Object?> get props => [id, name, category, logo, rating, reviewsCount];
}
