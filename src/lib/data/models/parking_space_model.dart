class ParkingSpace {
  final String id;
  final int floor;
  final String name;
  final bool isOccupied;
  final String type;

  ParkingSpace({
    required this.id,
    required this.floor,
    required this.name,
    required this.isOccupied,
    required this.type,
  });

  factory ParkingSpace.fromJson(Map<String, dynamic> json) {
    return ParkingSpace(
      id: json['id'],
      floor: json['floor'],
      name: json['name'],
      isOccupied: json['isOccupied'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'floor': floor,
      'name': name,
      'isOccupied': isOccupied,
      'type': type,
    };
  }
}
