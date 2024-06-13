// lib/presentation/screens/car_registration_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/app_theme.dart';
import '../../data/models/car_model.dart';
import '../../data/models/query_models/car_query_model.dart';
import '../../data/services/car_service.dart';

class CarRegistrationScreen extends StatefulWidget {
  const CarRegistrationScreen({super.key});

  @override
  _CarRegistrationScreenState createState() => _CarRegistrationScreenState();
}

class _CarRegistrationScreenState extends State<CarRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  late CarService _carService;
  List<Car> _cars = [];
  Car? _selectedCar;

  final _plateController = TextEditingController();
  final _modelController = TextEditingController();
  final _brandController = TextEditingController();
  final _colorController = TextEditingController();
  final _yearController = TextEditingController();

  String? _selectedVehicleType;
  String? _selectedFuelType;
  int _selectedFuelTypeInt = 0;

  @override
  void initState() {
    super.initState();
    _carService = Provider.of<CarService>(context, listen: false);
    _loadCars();
  }

  Future<void> _loadCars() async {
    final cars = await _carService.fetchCars();
    setState(() {
      _cars = cars ?? [];
    });
  }

  void _onCarSelected(Car? car) {
    setState(() {
      _selectedCar = car;
      if (car != null) {
        _plateController.text = car.plate;
        _modelController.text = car.model;
        _brandController.text = car.brand;
        _colorController.text = car.color;
        _yearController.text = car.year.toString();
        _selectedVehicleType = car.type.toString();
        _selectedFuelType = car.fuelType;
        _selectedFuelTypeInt = _selectedVehicleType == "Electric" ? 0 :
        _selectedVehicleType == 'Combustion' ? 1 :
        _selectedVehicleType == 'Pcd' ? 2 :
        _selectedVehicleType == 'Hybrid' ? 3 : 1;
      } else {
        _plateController.clear();
        _modelController.clear();
        _brandController.clear();
        _colorController.clear();
        _yearController.clear();
        _selectedVehicleType = null;
        _selectedFuelTypeInt = 1;
        _selectedFuelType = 'Gasolina';
      }
    });
  }

  Future<void> _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      final car = CarQueryModel(
        plate: _plateController.text,
        model: _modelController.text,
        brand: _brandController.text,
        color: _colorController.text,
        year: int.parse(_yearController.text),
        type: _selectedFuelTypeInt,
        fuelType: 0, // Atualize conforme necessário
        fuelConsumptionPerLiter: 10, // Atualize conforme necessário
      );

      if (_selectedCar == null) {
        await _carService.addCar(car);
      } else {
        await _carService.updateCar(_selectedCar!.id, car);
      }

      _loadCars(); // Reload cars after insert/update
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: AppTheme.primaryColor),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Cadastro de veículo',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'Cadastre seu veículo',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 18,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<Car>(
                  decoration: const InputDecoration(
                    labelText: 'Veículos cadastrados',
                    border: OutlineInputBorder(),
                  ),
                  items: _cars.map((Car car) {
                    return DropdownMenuItem<Car>(
                      value: car,
                      child: Text('${car.brand} ${car.model}\nplaca: ${car.plate}'),
                    );
                  }).toList(),
                  onChanged: (Car? newValue) {
                    _onCarSelected(newValue);
                  },
                  value: _cars.contains(_selectedCar) ? _selectedCar : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _plateController,
                  decoration: const InputDecoration(
                    labelText: 'Placa do veículo',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || !RegExp(r'^[A-Z]{3}-\d{4}$|^[A-Z]{3}-\d{1}[A-Z]{1}\d{2}$').hasMatch(value)) {
                      return 'Formato da placa inválido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _modelController,
                  decoration: const InputDecoration(
                    labelText: 'Modelo do veículo',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Tipo do veículo',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: '0', child: Text('Elétrico')),
                    DropdownMenuItem(value: '1', child: Text('Combustão')),
                    DropdownMenuItem(value: '2', child: Text('PCD')),
                    DropdownMenuItem(value: '3', child: Text('Híbrido')),
                  ],
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedVehicleType = newValue;
                    });
                  },
                  value: _selectedFuelTypeInt.toString(),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _yearController,
                  decoration: const InputDecoration(
                    labelText: 'Ano',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _colorController,
                  decoration: const InputDecoration(
                    labelText: 'Cor',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _brandController,
                  decoration: const InputDecoration(
                    labelText: 'Marca',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _onSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                  ),
                  child: Text(_selectedCar == null ? 'Cadastrar' : 'Atualizar cadastro'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
