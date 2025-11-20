import 'package:equatable/equatable.dart';

// Helper pour la sérialisation des listes d'objets `toJson`
List<Map<String, dynamic>>? _listToJson(List<dynamic>? list) {
  // Le `?.` gère le cas où la liste est nulle.
  return list?.map((e) => e.toJson() as Map<String, dynamic>).toList();
}

class FlightOffer extends Equatable {
  const FlightOffer({
    required this.id,
    required this.source,
    required this.instantTicketingRequired,
    required this.nonHomogeneous,
    this.oneWay,
    this.isUpsellOffer, // Rendu optionnel car absent de la 2e réponse
    required this.lastTicketingDate,
    this.lastTicketingDateTime, // Rendu optionnel car absent de la 2e réponse
    this.numberOfBookableSeats, // Rendu optionnel car absent de la 2e réponse
    required this.itineraries,
    required this.price,
    this.pricingOptions,
    required this.validatingAirlineCodes,
    required this.travelerPricings,
    this.paymentCardRequired, // NOUVEAU
  });

  final String id;
  final String source;
  final bool instantTicketingRequired;
  final bool nonHomogeneous;
  final bool? oneWay;
  final bool? isUpsellOffer;
  final String lastTicketingDate;
  final String? lastTicketingDateTime;
  final int? numberOfBookableSeats;
  final List<Itinerary> itineraries;
  final Price price;
  final PricingOptions? pricingOptions;
  final List<String> validatingAirlineCodes;
  final List<TravelerPricing> travelerPricings;
  final bool? paymentCardRequired;

  // --- MÉTHODE TOJSON AJOUTÉE ---
  Map<String, dynamic> toJson() {
    return {
      'type': 'flight-offer', // L'API s'attend à ce champ dans le corps de la requête
      'id': id,
      'source': source,
      'instantTicketingRequired': instantTicketingRequired,
      'nonHomogeneous': nonHomogeneous,
      'oneWay': oneWay,
      if (isUpsellOffer != null) 'isUpsellOffer': isUpsellOffer,
      'lastTicketingDate': lastTicketingDate,
      if (lastTicketingDateTime != null)
        'lastTicketingDateTime': lastTicketingDateTime,
      if (numberOfBookableSeats != null)
        'numberOfBookableSeats': numberOfBookableSeats,
      'itineraries': _listToJson(itineraries),
      'price': price.toJson(),
      'pricingOptions': pricingOptions?.toJson(),
      'validatingAirlineCodes': validatingAirlineCodes,
      'travelerPricings': _listToJson(travelerPricings),
      if (paymentCardRequired != null)
        'paymentCardRequired': paymentCardRequired,
    };
  }

  @override
  List<Object?> get props => [
    id,
    source,
    instantTicketingRequired,
    nonHomogeneous,
    oneWay,
    isUpsellOffer,
    lastTicketingDate,
    lastTicketingDateTime,
    numberOfBookableSeats,
    itineraries,
    price,
    pricingOptions,
    validatingAirlineCodes,
    travelerPricings,
    paymentCardRequired,
  ];
}

class Itinerary extends Equatable {
  const Itinerary({
    this.duration, // Rendu optionnel car absent de la 2e réponse
    required this.segments,
  });

  final String? duration;
  final List<Segment> segments;

  Map<String, dynamic> toJson() => {
    if (duration != null) 'duration': duration,
    'segments': _listToJson(segments),
  };

  @override
  List<Object?> get props => [duration, segments];
}

class Segment extends Equatable {
  const Segment({
    required this.departure,
    required this.arrival,
    required this.carrierCode,
    required this.number,
    required this.aircraft,
    required this.operating,
    required this.duration,
    required this.id,
    required this.numberOfStops,
    this.blacklistedInEU, // Rendu optionnel car absent de la 2e réponse
    this.co2Emissions,
  });

  final FlightEndpoint departure;
  final FlightEndpoint arrival;
  final String carrierCode;
  final String number;
  final Aircraft aircraft;
  final Operating operating;
  final String duration;
  final String id;
  final int numberOfStops;
  final bool? blacklistedInEU;
  final List<Co2Emission>? co2Emissions;

  Map<String, dynamic> toJson() => {
    'departure': departure.toJson(),
    'arrival': arrival.toJson(),
    'carrierCode': carrierCode,
    'number': number,
    'aircraft': aircraft.toJson(),
    'operating': operating.toJson(),
    'duration': duration,
    'id': id,
    'numberOfStops': numberOfStops,
    if (blacklistedInEU != null) 'blacklistedInEU': blacklistedInEU,
    if (co2Emissions != null) 'co2Emissions': _listToJson(co2Emissions),
  };

  @override
  List<Object?> get props => [
    departure,
    arrival,
    carrierCode,
    number,
    aircraft,
    operating,
    duration,
    id,
    numberOfStops,
    blacklistedInEU,
    co2Emissions
  ];
}

class Co2Emission extends Equatable {
  const Co2Emission(
      {required this.weight, required this.weightUnit, required this.cabin});

  final int weight;
  final String weightUnit;
  final String cabin;

  Map<String, dynamic> toJson() => {
    'weight': weight,
    'weightUnit': weightUnit,
    'cabin': cabin,
  };

  @override
  List<Object?> get props => [weight, weightUnit, cabin];
}

class FlightEndpoint extends Equatable {
  const FlightEndpoint({
    required this.iataCode,
    required this.at,
    this.terminal,
  });

  final String iataCode;
  final String at;
  final String? terminal;

  Map<String, dynamic> toJson() => {
    'iataCode': iataCode,
    'at': at,
    if (terminal != null) 'terminal': terminal,
  };

  @override
  List<Object?> get props => [iataCode, at, terminal];
}

class Aircraft extends Equatable {
  const Aircraft({required this.code});

  final String code;

  Map<String, dynamic> toJson() => {
    'code': code,
  };

  @override
  List<Object?> get props => [code];
}

class Operating extends Equatable {
  const Operating({required this.carrierCode});

  final String carrierCode;

  Map<String, dynamic> toJson() => {
    'carrierCode': carrierCode,
  };

  @override
  List<Object?> get props => [carrierCode];
}

class Price extends Equatable {
  const Price({
    required this.currency,
    required this.total,
    required this.base,
    this.fees,
    this.grandTotal,
    this.taxes, // NOUVEAU
    this.refundableTaxes, // NOUVEAU
    this.billingCurrency, // NOUVEAU
  });

  final String currency;
  final String total;
  final String base;
  final List<Fee>? fees;
  final String? grandTotal;
  final List<Tax>? taxes;
  final String? refundableTaxes;
  final String? billingCurrency;

  Map<String, dynamic> toJson() => {
    'currency': currency,
    'total': total,
    'base': base,
    if (fees != null) 'fees': _listToJson(fees),
    if (grandTotal != null) 'grandTotal': grandTotal,
    if (taxes != null) 'taxes': _listToJson(taxes),
    if (refundableTaxes != null) 'refundableTaxes': refundableTaxes,
    if (billingCurrency != null) 'billingCurrency': billingCurrency,
  };

  @override
  List<Object?> get props => [
    currency,
    total,
    base,
    fees,
    grandTotal,
    taxes,
    refundableTaxes,
    billingCurrency
  ];
}

class Fee extends Equatable {
  const Fee({
    required this.amount,
    required this.type,
  });

  final String amount;
  final String type;

  Map<String, dynamic> toJson() => {
    'amount': amount,
    'type': type,
  };

  @override
  List<Object?> get props => [amount, type];
}

// NOUVELLE CLASSE
class Tax extends Equatable {
  const Tax({required this.amount, required this.code});

  final String amount;
  final String code;

  Map<String, dynamic> toJson() => {
    'amount': amount,
    'code': code,
  };

  @override
  List<Object?> get props => [amount, code];
}

class PricingOptions extends Equatable {
  const PricingOptions({
    required this.fareType,
    required this.includedCheckedBagsOnly,
  });

  final List<String> fareType;
  final bool includedCheckedBagsOnly;

  Map<String, dynamic> toJson() => {
    'fareType': fareType,
    'includedCheckedBagsOnly': includedCheckedBagsOnly,
  };

  @override
  List<Object?> get props => [fareType, includedCheckedBagsOnly];
}

class TravelerPricing extends Equatable {
  const TravelerPricing({
    required this.travelerId,
    required this.fareOption,
    required this.travelerType,
    required this.price,
    required this.fareDetailsBySegment,
  });

  final String travelerId;
  final String fareOption;
  final String travelerType;
  final Price price;
  final List<FareDetails> fareDetailsBySegment;

  Map<String, dynamic> toJson() => {
    'travelerId': travelerId,
    'fareOption': fareOption,
    'travelerType': travelerType,
    'price': price.toJson(),
    'fareDetailsBySegment': _listToJson(fareDetailsBySegment),
  };

  @override
  List<Object?> get props => [
    travelerId,
    fareOption,
    travelerType,
    price,
    fareDetailsBySegment,
  ];
}

class FareDetails extends Equatable {
  const FareDetails({
    required this.segmentId,
    required this.cabin,
    required this.fareBasis,
    required this.fareClass,
    required this.includedCheckedBags,
    this.includedCabinBags, // Rendu optionnel car absent de la 2e réponse
    this.brandedFare,
    this.brandedFareLabel,
    this.amenities,
  });

  final String segmentId;
  final String cabin;
  final String fareBasis;
  final String fareClass;
  final BagAllowance includedCheckedBags;
  final BagAllowance? includedCabinBags;
  final String? brandedFare;
  final String? brandedFareLabel;
  final List<Amenity>? amenities;

  Map<String, dynamic> toJson() => {
    'segmentId': segmentId,
    'cabin': cabin,
    'fareBasis': fareBasis,
    'class': fareClass, // Attention, 'class' est un mot-clé réservé en JSON
    'includedCheckedBags': includedCheckedBags.toJson(),
    if (includedCabinBags != null)
      'includedCabinBags': includedCabinBags!.toJson(),
    if (brandedFare != null) 'brandedFare': brandedFare,
    if (brandedFareLabel != null) 'brandedFareLabel': brandedFareLabel,
    if (amenities != null) 'amenities': _listToJson(amenities),
  };

  @override
  List<Object?> get props => [
    segmentId,
    cabin,
    fareBasis,
    fareClass,
    includedCheckedBags,
    includedCabinBags,
    brandedFare,
    brandedFareLabel,
    amenities,
  ];
}

class BagAllowance extends Equatable {
  const BagAllowance({required this.quantity});

  final int quantity;

  Map<String, dynamic> toJson() => {
    'quantity': quantity,
  };

  @override
  List<Object?> get props => [quantity];
}

class Amenity extends Equatable {
  const Amenity({
    required this.description,
    required this.isChargeable,
    required this.amenityType,
    required this.amenityProvider,
  });

  final String description;
  final bool isChargeable;
  final String amenityType;
  final AmenityProvider amenityProvider;

  Map<String, dynamic> toJson() => {
    'description': description,
    'isChargeable': isChargeable,
    'amenityType': amenityType,
    'amenityProvider': amenityProvider.toJson(),
  };

  @override
  List<Object?> get props => [
    description,
    isChargeable,
    amenityType,
    amenityProvider,
  ];
}

class AmenityProvider extends Equatable {
  const AmenityProvider({required this.name});

  final String name;

  Map<String, dynamic> toJson() => {
    'name': name,
  };

  @override
  List<Object?> get props => [name];
}

class FlightDictionaries extends Equatable {
  const FlightDictionaries({
    required this.locations,
    this.aircraft,
    this.currencies,
    this.carriers,
  });

  final Map<String, Location> locations;
  final Map<String, String>? aircraft;
  final Map<String, String>? currencies;
  final Map<String, String>? carriers;

  @override
  List<Object?> get props => [locations, aircraft, currencies, carriers];
}

class Location extends Equatable {
  const Location({
    required this.cityCode,
    required this.countryCode,
  });

  final String cityCode;
  final String countryCode;

  @override
  List<Object?> get props => [cityCode, countryCode];
}