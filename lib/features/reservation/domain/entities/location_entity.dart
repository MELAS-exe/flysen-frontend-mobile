import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  final String iataCode;
  final String name;
  final String detailedName;
  final String subType;

  const LocationEntity({
    required this.iataCode,
    required this.name,
    required this.detailedName,
    required this.subType,
  });

  @override
  List<Object?> get props => [iataCode, name, detailedName, subType];
}
