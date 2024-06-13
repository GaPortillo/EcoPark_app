// lib/data/repositories/car_repository_interface.dart

import '../../data/models/car_model.dart';
import '../../data/models/query_models/car_query_model.dart';

abstract class ICarRepository {
  Future<void> insertCar(CarQueryModel car);
  Future<void> updateCar(String carId, CarQueryModel car);
  Future<List<Car>?> getCars();
}
