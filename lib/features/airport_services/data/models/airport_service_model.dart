import 'package:equatable/equatable.dart';

// --- Nested Models ---

class OpeningHoursDetailModel extends Equatable {
  final String openTime;
  final String closeTime;

  const OpeningHoursDetailModel(
      {required this.openTime, required this.closeTime});

  factory OpeningHoursDetailModel.fromJson(Map<String, dynamic> json) {
    return OpeningHoursDetailModel(
      openTime: json['openTime'] as String? ?? 'N/A',
      closeTime: json['closeTime'] as String? ?? 'N/A',
    );
  }
  @override
  List<Object?> get props => [openTime, closeTime];
}

class ContactInfoModel extends Equatable {
  final String? email;
  final String? phone;
  final String? website;

  const ContactInfoModel({this.email, this.phone, this.website});

  factory ContactInfoModel.fromJson(Map<String, dynamic> json) {
    return ContactInfoModel(
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      website: json['website'] as String?,
    );
  }
  @override
  List<Object?> get props => [email, phone, website];
}

class ProductModel extends Equatable {
  final String name;
  final double price;
  final String? image;

  const ProductModel({required this.name, required this.price, this.image});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'] as String? ?? 'Unnamed Product',
      price: (json['price'] as num? ?? 0.0).toDouble(),
      image: json['image'] as String?,
    );
  }
  @override
  List<Object?> get props => [name, price, image];
}

// --- Main Airport Service Model ---

class AirportServiceModel extends Equatable {
  final String id;
  final String airportId;
  final String name;
  final String category;
  final String description;
  final String locationMap;
  final ContactInfoModel? contactInfo;
  final List<String> images;
  final String? logo;
  final List<ProductModel> products;
  final List<String> amenities;
  final double rating;
  final int reviewsCount;

  const AirportServiceModel({
    required this.id,
    required this.airportId,
    required this.name,
    required this.category,
    required this.description,
    required this.locationMap,
    this.contactInfo,
    required this.images,
    this.logo,
    required this.products,
    required this.amenities,
    required this.rating,
    required this.reviewsCount,
  });

  factory AirportServiceModel.fromJson(Map<String, dynamic> json) {
    return AirportServiceModel(
      id: json['id'] as String,
      airportId: json['airportId'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      locationMap: json['locationMap'] as String,
      contactInfo: json['contactInfo'] != null
          ? ContactInfoModel.fromJson(
              json['contactInfo'] as Map<String, dynamic>)
          : null,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      logo: json['logo'] as String?,
      products: (json['products'] as List<dynamic>?)
              ?.map((p) => ProductModel.fromJson(p as Map<String, dynamic>))
              .toList() ??
          [],
      amenities: (json['amenities'] as List<dynamic>?)
              ?.map((a) => a.toString())
              .toList() ??
          [],
      rating: (json['rating'] as num? ?? 0.0).toDouble(),
      reviewsCount: json['reviewsCount'] as int? ?? 0,
    );
  }

  @override
  List<Object?> get props =>
      [id, name, category, description, rating, reviewsCount];
}
