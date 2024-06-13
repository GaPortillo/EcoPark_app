class CarQueryModel {
  final String plate;
  final int type;
  final String brand;
  final String model;
  final String color;
  final int year;
  final int fuelType;
  final double fuelConsumptionPerLiter;

  CarQueryModel({
    required this.plate,
    required this.type,
    required this.brand,
    required this.model,
    required this.color,
    required this.year,
    required this.fuelType,
    required this.fuelConsumptionPerLiter,
  });

  Map<String, dynamic> toJson() {
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
