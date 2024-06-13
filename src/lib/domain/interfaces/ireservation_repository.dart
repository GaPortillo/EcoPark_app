abstract class IReservationRepository {
  Future<void> reserveParkingSpace(String parkingSpaceId, DateTime reservationDate);
  Future<String> getCarId(String token);
}
