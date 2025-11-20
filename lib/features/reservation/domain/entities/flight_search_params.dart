import 'package:equatable/equatable.dart';

class FlightSearchParams extends Equatable {
  final String currencyCode;
  final List<OriginDestination> originDestinations;
  final List<Traveler> travelers;
  final List<String> sources;
  final SearchCriteria searchCriteria;

  const FlightSearchParams({
    required this.currencyCode,
    required this.originDestinations,
    required this.travelers,
    required this.sources,
    required this.searchCriteria,
  });

  // Méthode pour convertir l'objet en JSON pour la requête HTTP
  Map<String, dynamic> toJson() {
    return {
      'currencyCode': currencyCode,
      'originDestinations': originDestinations.map((x) => x.toJson()).toList(),
      'travelers': travelers.map((x) => x.toJson()).toList(),
      'sources': sources,
      'searchCriteria': searchCriteria.toJson(),
    };
  }

  @override
  List<Object?> get props => [
    currencyCode,
    originDestinations,
    travelers,
    sources,
    searchCriteria
  ];
}

class OriginDestination extends Equatable {
  final String id;
  final String originLocationCode;
  final String destinationLocationCode;
  final DepartureDateTimeRange departureDateTimeRange;

  const OriginDestination({
    required this.id,
    required this.originLocationCode,
    required this.destinationLocationCode,
    required this.departureDateTimeRange,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'originLocationCode': originLocationCode,
    'destinationLocationCode': destinationLocationCode,
    'departureDateTimeRange': departureDateTimeRange.toJson(),
  };

  @override
  List<Object?> get props => [
    id,
    originLocationCode,
    destinationLocationCode,
    departureDateTimeRange
  ];
}

class DepartureDateTimeRange extends Equatable {
  final String date;
  const DepartureDateTimeRange({required this.date});

  Map<String, dynamic> toJson() => {'date': date};

  @override
  List<Object?> get props => [date];
}

class Traveler extends Equatable {
  final String id;
  final String travelerType;

  const Traveler({required this.id, required this.travelerType});

  Map<String, dynamic> toJson() => {'id': id, 'travelerType': travelerType};

  @override
  List<Object?> get props => [id, travelerType];
}

class SearchCriteria extends Equatable {
  final int maxFlightOffers;

  const SearchCriteria({required this.maxFlightOffers});

  Map<String, dynamic> toJson() => {'maxFlightOffers': maxFlightOffers};

  @override
  List<Object?> get props => [maxFlightOffers];
}