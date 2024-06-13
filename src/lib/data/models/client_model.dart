import 'car_model.dart';

class Client {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String imageUrl;
  final List<Car>? cars;

  Client({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.imageUrl,
    required this.cars,
  });

  factory Client.fromJson(Map<String, dynamic> json) {

    var list = json['cars'] as List?;
    List<Car>? carsList = list?.map((i) => Car.fromJson(i)).toList();

    return Client(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      imageUrl: json['imageUrl'],
      cars: carsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'imageUrl': imageUrl,
      'parkingSpaces': cars?.map((e) => e.toJson()).toList(),
    };
  }
}
