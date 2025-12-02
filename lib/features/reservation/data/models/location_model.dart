import 'package:equatable/equatable.dart';

class LocationModel extends Equatable {
  final String iataCode;
  final String name;
  final String detailedName;
  final String subType;

  const LocationModel({
    required this.iataCode,
    required this.name,
    required this.detailedName,
    required this.subType,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      iataCode: json['iataCode']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Unknown',
      detailedName: json['detailedName']?.toString() ??
          json['name']?.toString() ??
          'Unknown',
      subType: json['subType']?.toString() ?? 'UNKNOWN',
    );
  }

  static List<LocationModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => LocationModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  List<Object?> get props => [iataCode, name, detailedName, subType];
}
