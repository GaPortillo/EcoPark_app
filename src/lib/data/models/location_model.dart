import 'package:ecopark/data/models/parking_space_model.dart';

class Location {
  final String id;
  final String name;
  final String address;
  final int reservationGraceInMinutes;
  final int cancellationFeeRate;
  final int reservationFeeRate;
  final int hourlyParkingRate;
  final List<ParkingSpace>? parkingSpaces;

  Location({
    required this.id,
    required this.name,
    required this.address,
    required this.reservationGraceInMinutes,
    required this.cancellationFeeRate,
    required this.reservationFeeRate,
    required this.hourlyParkingRate,
    required this.parkingSpaces,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    var list = json['parkingSpaces'] as List?;
    List<ParkingSpace>? parkingSpaceList = list?.map((i) => ParkingSpace.fromJson(i)).toList();

    return Location(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      reservationGraceInMinutes: json['reservationGraceInMinutes'],
      cancellationFeeRate: json['cancellationFeeRate'],
      reservationFeeRate: json['reservationFeeRate'],
      hourlyParkingRate: json['hourlyParkingRate'],
      parkingSpaces: parkingSpaceList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'reservationGraceInMinutes': reservationGraceInMinutes,
      'cancellationFeeRate': cancellationFeeRate,
      'reservationFeeRate': reservationFeeRate,
      'hourlyParkingRate': hourlyParkingRate,
      'parkingSpaces': parkingSpaces?.map((e) => e.toJson()).toList(),
    };
  }
}
