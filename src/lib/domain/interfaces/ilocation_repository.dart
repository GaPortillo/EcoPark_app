import '../../data/models/location_model.dart';

abstract class ILocationRepository {
  Future<List<Location>> getLocation(String id);
  Future<List<Location>> listLocations(List<String>? locationIds, bool includeParkingSpaces);
}
