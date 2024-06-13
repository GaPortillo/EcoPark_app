class Car {
  final String id;
  final String plate;
  final String type;
  final String brand;
  final String model;
  final String color;
  final int year;
  final String fuelType;
  final double fuelConsumptionPerLiter;

  Car({
    required this.id,
    required this.plate,
    required this.type,
    required this.brand,
    required this.model,
    required this.color,
    required this.year,
    required this.fuelType,
    required this.fuelConsumptionPerLiter,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      plate: json['plate'],
      type: json['type'],
      brand: json['brand'],
      model: json['model'],
      color: json['color'],
      year: json['year'],
      fuelType: json['fuelType'],
      fuelConsumptionPerLiter: json['fuelConsumptionPerLiter'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plate': plate,
      'type': type,
      'brand': brand,
      'model': model,
      'color': color,
      'year': year,
      'fuelType': fuelType,
      'fuelConsumptionPerLiter': fuelConsumptionPerLiter,
    };
  }

  Map<String, dynamic> toJsonForQueryBody() {
    return {
      'plate': plate,
      'type': type,
      'brand': brand,
      'model': model,
      'color': color,
      'year': year,
      'fuelType': fuelType,
      'fuelConsumptionPerLiter': fuelConsumptionPerLiter,
    };
  }
}
