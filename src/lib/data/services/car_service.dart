// lib/data/services/car_service.dart

import '../../domain/interfaces/icar_repository.dart';
import '../models/car_model.dart';
import '../models/query_models/car_query_model.dart';

class CarService {
  final ICarRepository _carRepository;

  CarService(this._carRepository);

  Future<void> addCar(CarQueryModel car) async {
    await _carRepository.insertCar(car);
  }

  Future<void> updateCar(String carId, CarQueryModel car) async {
    await _carRepository.updateCar(carId, car);
  }

  Future<List<Car>?> fetchCars() async {
    return await _carRepository.getCars();
  }
}
