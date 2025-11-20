import 'package:flysen_frontend_mobile/features/discover/domain/entities/destination.dart';

class DestinationModel {
  DestinationModel({
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
  final CurrentWeatherModel? currentWeather;
  final dynamic stats;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? createdBy;
  final String? lastModifiedBy;
  final bool active;

  factory DestinationModel.fromJson(Map<String, dynamic> json) {
    return DestinationModel(
      id: json['id'] as String,
      name: json['name'] as String,
      region: json['region'] as String,
      nearestAirportId: json['nearestAirportId'] as String?,
      nearestAirportCode: json['nearestAirportCode'] as String?,
      description: json['description'] as String?,
      highlights: json['highlights'] != null
          ? List<String>.from(json['highlights'] as List)
          : null,
      images: json['images'] != null
          ? List<String>.from(json['images'] as List)
          : null,
      videos: json['videos'] != null
          ? List<String>.from(json['videos'] as List)
          : null,
      virtualTourUrl: json['virtualTourUrl'] as String?,
      bestSeason: json['bestSeason'] as String?,
      averageStayDuration: json['averageStayDuration'] as int?,
      popularityScore: json['popularityScore'] != null
          ? (json['popularityScore'] as num).toDouble()
          : null,
      latitude: json['latitude'] != null
          ? (json['latitude'] as num).toDouble()
          : null,
      longitude: json['longitude'] != null
          ? (json['longitude'] as num).toDouble()
          : null,
      currentWeather: json['currentWeather'] != null
          ? CurrentWeatherModel.fromJson(
          json['currentWeather'] as Map<String, dynamic>)
          : null,
      stats: json['stats'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      createdBy: json['createdBy'] as String?,
      lastModifiedBy: json['lastModifiedBy'] as String?,
      active: json['active'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'region': region,
      'nearestAirportId': nearestAirportId,
      'nearestAirportCode': nearestAirportCode,
      'description': description,
      'highlights': highlights,
      'images': images,
      'videos': videos,
      'virtualTourUrl': virtualTourUrl,
      'bestSeason': bestSeason,
      'averageStayDuration': averageStayDuration,
      'popularityScore': popularityScore,
      'latitude': latitude,
      'longitude': longitude,
      'currentWeather': currentWeather?.toJson(),
      'stats': stats,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'createdBy': createdBy,
      'lastModifiedBy': lastModifiedBy,
      'active': active,
    };
  }

  Destination toEntity() {
    return Destination(
      id: id,
      name: name,
      region: region,
      nearestAirportId: nearestAirportId,
      nearestAirportCode: nearestAirportCode,
      description: description,
      highlights: highlights,
      images: images,
      videos: videos,
      virtualTourUrl: virtualTourUrl,
      bestSeason: bestSeason,
      averageStayDuration: averageStayDuration,
      popularityScore: popularityScore,
      latitude: latitude,
      longitude: longitude,
      currentWeather: currentWeather?.toEntity(),
      stats: stats,
      createdAt: createdAt,
      updatedAt: updatedAt,
      createdBy: createdBy,
      lastModifiedBy: lastModifiedBy,
      active: active,
    );
  }
}

class CurrentWeatherModel {
  CurrentWeatherModel({
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

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherModel(
      temperature: (json['temperature'] as num).toDouble(),
      condition: json['condition'] as String,
      humidity: json['humidity'] as int,
      description: json['description'] as String,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'condition': condition,
      'humidity': humidity,
      'description': description,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  CurrentWeather toEntity() {
    return CurrentWeather(
      temperature: temperature,
      condition: condition,
      humidity: humidity,
      description: description,
      lastUpdated: lastUpdated,
    );
  }
}