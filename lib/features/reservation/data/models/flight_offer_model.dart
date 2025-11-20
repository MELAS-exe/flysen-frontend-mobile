import 'package:flysen_frontend_mobile/features/reservation/domain/entities/flight_offer.dart';

List<T> _parseList<T>(
    List<dynamic>? data, T Function(Map<String, dynamic>) fromJson) {
  return data?.map((item) => fromJson(item as Map<String, dynamic>)).toList() ??
      [];
}

class FlightOfferModel extends FlightOffer {
  const FlightOfferModel({
    required super.id,
    required super.source,
    required super.instantTicketingRequired,
    required super.nonHomogeneous,
    super.oneWay,
    required super.isUpsellOffer,
    required super.lastTicketingDate,
    required super.lastTicketingDateTime,
    required super.numberOfBookableSeats,
    required super.itineraries,
    required super.price,
    required super.pricingOptions,
    required super.validatingAirlineCodes,
    required super.travelerPricings,
  });

  factory FlightOfferModel.fromJson(Map<String, dynamic> json) {
    return FlightOfferModel(
        id: json['id'] as String,
        source: json['source'] as String,
        instantTicketingRequired: json['instantTicketingRequired'] as bool,
        nonHomogeneous: json['nonHomogeneous'] as bool,
        oneWay: json['oneWay'] as bool,
        isUpsellOffer: json['isUpsellOffer'] as bool,
        lastTicketingDate: json['lastTicketingDate'] as String,
        lastTicketingDateTime: json['lastTicketingDateTime'] as String,
        numberOfBookableSeats: json['numberOfBookableSeats'] as int,
        itineraries: _parseList(
            json['itineraries'] as List<dynamic>?, ItineraryModel.fromJson),
        price: PriceModel.fromJson(json['price'] as Map<String, dynamic>),
        pricingOptions: PricingOptionsModel.fromJson(
            json['pricingOptions'] as Map<String, dynamic>),
        validatingAirlineCodes:
            List<String>.from(json['validatingAirlineCodes'] as List),
        travelerPricings: _parseList(json['travelerPricings'] as List<dynamic>?,
            TravelerPricingModel.fromJson)
    );
  }
}

// Sous-modèles pour chaque objet imbriqué
class ItineraryModel extends Itinerary {
  const ItineraryModel({required super.duration, required super.segments});

  factory ItineraryModel.fromJson(Map<String, dynamic> json) {
    return ItineraryModel(
      duration: json['duration'] as String,
      segments: _parseList(json['segments'] as List<dynamic>?, SegmentModel.fromJson),
    );
  }
}

class SegmentModel extends Segment {
  const SegmentModel(
      {required super.departure,
      required super.arrival,
      required super.carrierCode,
      required super.number,
      required super.aircraft,
      required super.operating,
      required super.duration,
      required super.id,
      required super.numberOfStops,
      required super.blacklistedInEU});

  factory SegmentModel.fromJson(Map<String, dynamic> json) {
    return SegmentModel(
      departure: FlightEndpointModel.fromJson(
          json['departure'] as Map<String, dynamic>),
      arrival:
          FlightEndpointModel.fromJson(json['arrival'] as Map<String, dynamic>),
      carrierCode: json['carrierCode'] as String,
      number: json['number'] as String,
      aircraft:
          AircraftModel.fromJson(json['aircraft'] as Map<String, dynamic>),
      operating:
          OperatingModel.fromJson(json['operating'] as Map<String, dynamic>),
      duration: json['duration'] as String,
      id: json['id'] as String,
      numberOfStops: json['numberOfStops'] as int,
      blacklistedInEU: json['blacklistedInEU'] as bool,
    );
  }
}

class FlightEndpointModel extends FlightEndpoint {
  const FlightEndpointModel(
      {required super.iataCode, required super.at, super.terminal});

  factory FlightEndpointModel.fromJson(Map<String, dynamic> json) {
    return FlightEndpointModel(
      iataCode: json['iataCode'] as String,
      at: json['at'] as String,
      terminal: json['terminal'] as String?,
    );
  }
}

class AircraftModel extends Aircraft {
  const AircraftModel({required super.code});

  factory AircraftModel.fromJson(Map<String, dynamic> json) {
    return AircraftModel(code: json['code'] as String);
  }
}

class OperatingModel extends Operating {
  const OperatingModel({required super.carrierCode});

  factory OperatingModel.fromJson(Map<String, dynamic> json) {
    return OperatingModel(carrierCode: json['carrierCode'] as String);
  }
}

class PriceModel extends Price {
  const PriceModel(
      {required super.currency,
      required super.total,
      required super.base,
      required super.fees,
      super.grandTotal}); // grandTotal est parfois absent

  factory PriceModel.fromJson(Map<String, dynamic> json) {
    return PriceModel(
      currency: json['currency'] as String,
      total: json['total'] as String,
      base: json['base'] as String,
      fees: _parseList(json['fees'] as List<dynamic>?, FeeModel.fromJson),
      grandTotal: json['grandTotal'] as String?,
    );
  }
}

class FeeModel extends Fee {
  const FeeModel({required super.amount, required super.type});

  factory FeeModel.fromJson(Map<String, dynamic> json) {
    return FeeModel(
      amount: json['amount'] as String,
      type: json['type'] as String,
    );
  }
}

class PricingOptionsModel extends PricingOptions {
  const PricingOptionsModel(
      {required super.fareType, required super.includedCheckedBagsOnly});

  factory PricingOptionsModel.fromJson(Map<String, dynamic> json) {
    return PricingOptionsModel(
      fareType: List<String>.from(json['fareType'] as List),
      includedCheckedBagsOnly: json['includedCheckedBagsOnly'] as bool,
    );
  }
}

class TravelerPricingModel extends TravelerPricing {
  const TravelerPricingModel(
      {required super.travelerId,
      required super.fareOption,
      required super.travelerType,
      required super.price,
      required super.fareDetailsBySegment});

  factory TravelerPricingModel.fromJson(Map<String, dynamic> json) {
    return TravelerPricingModel(
      travelerId: json['travelerId'] as String,
      fareOption: json['fareOption'] as String,
      travelerType: json['travelerType'] as String,
      price: PriceModel.fromJson(json['price'] as Map<String, dynamic>),
      fareDetailsBySegment: _parseList(
          json['fareDetailsBySegment'] as List<dynamic>?, FareDetailsModel.fromJson),
    );
  }
}

class FareDetailsModel extends FareDetails {
  const FareDetailsModel(
      {required super.segmentId,
      required super.cabin,
      required super.fareBasis,
      required super.fareClass,
      required super.includedCheckedBags,
      required super.includedCabinBags,
      super.brandedFare,
      super.brandedFareLabel,
      super.amenities});

  factory FareDetailsModel.fromJson(Map<String, dynamic> json) {
    return FareDetailsModel(
      segmentId: json['segmentId'] as String,
      cabin: json['cabin'] as String,
      fareBasis: json['fareBasis'] as String,
      fareClass: json['class']
          as String, // 'class' est un mot clé, on le mappe depuis le json
      includedCheckedBags: BagAllowanceModel.fromJson(
          json['includedCheckedBags'] as Map<String, dynamic>),
      includedCabinBags: BagAllowanceModel.fromJson(
          json['includedCabinBags'] as Map<String, dynamic>),
      brandedFare: json['brandedFare'] as String?,
      brandedFareLabel: json['brandedFareLabel'] as String?,
      amenities: _parseList(json['amenities'] as List<dynamic>?, AmenityModel.fromJson),
    );
  }
}

class BagAllowanceModel extends BagAllowance {
  const BagAllowanceModel({required super.quantity});

  factory BagAllowanceModel.fromJson(Map<String, dynamic> json) {
    return BagAllowanceModel(quantity: json['quantity'] as int);
  }
}

class AmenityModel extends Amenity {
  const AmenityModel(
      {required super.description,
      required super.isChargeable,
      required super.amenityType,
      required super.amenityProvider});

  factory AmenityModel.fromJson(Map<String, dynamic> json) {
    return AmenityModel(
      description: json['description'] as String,
      isChargeable: json['isChargeable'] as bool,
      amenityType: json['amenityType'] as String,
      amenityProvider: AmenityProviderModel.fromJson(
          json['amenityProvider'] as Map<String, dynamic>),
    );
  }
}

class AmenityProviderModel extends AmenityProvider {
  const AmenityProviderModel({required super.name});

  factory AmenityProviderModel.fromJson(Map<String, dynamic> json) {
    return AmenityProviderModel(name: json['name'] as String);
  }
}
