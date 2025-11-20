import 'package:equatable/equatable.dart';

class Destination extends Equatable {
  const Destination({
    required this.id,
    required this.name,
    required this.region,
    this.nearestAirportId,
    this.nearestAirportCode,
    this.description,
    this.highlights,
    this.images,
    this.videos,
    this.virtualTourUrl,
    this.bestSeason,
    this.averageStayDuration,
    this.popularityScore,
    this.latitude,
    this.longitude,
    this.currentWeather,
    this.stats,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.lastModifiedBy,
    required this.active,
  });

  final String id;
  final String name;
  final String region;
  final String? nearestAirportId;
  final String? nearestAirportCode;
  final String? description;
  final List<String>? highlights;
  final List<String>? images;
  final List<String>? videos;
  final String? virtualTourUrl;
  final String? bestSeason;
  final int? averageStayDuration;
  final double? popularityScore;
  final double? latitude;
  final double? longitude;
  final CurrentWeather? currentWeather;
  final dynamic stats;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? createdBy;
  final String? lastModifiedBy;
  final bool active;

  @override
  List<Object?> get props => [
    id,
    name,
    region,
    nearestAirportId,
    nearestAirportCode,
    description,
    highlights,
    images,
    videos,
    virtualTourUrl,
    bestSeason,
    averageStayDuration,
    popularityScore,
    latitude,
    longitude,
    currentWeather,
    stats,
    createdAt,
    updatedAt,
    createdBy,
    lastModifiedBy,
    active,
  ];
}

class CurrentWeather extends Equatable {
  const CurrentWeather({
    required this.temperature,
    required this.condition,
    required this.humidity,
    required this.description,
    required this.lastUpdated,
  });

  final double temperature;
  final String condition;
  final int humidity;
  final String description;
  final DateTime lastUpdated;

  @override
  List<Object?> get props => [
    temperature,
    condition,
    humidity,
    description,
    lastUpdated,
  ];
}