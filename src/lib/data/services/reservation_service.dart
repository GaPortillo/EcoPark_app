
import '../../domain/interfaces/ireservation_repository.dart';

class ReservationService {
  final IReservationRepository _reservationRepository;

  ReservationService(this._reservationRepository);

  Future<void> reserveParkingSpace(String parkingSpaceId, DateTime reservationDate) async {
    await _reservationRepository.reserveParkingSpace(parkingSpaceId, reservationDate);
  }

  Future<String> getCarId(String token) async {
    return await _reservationRepository.getCarId(token);
  }
}
