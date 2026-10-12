import '../entities/bus_stop.dart';
import '../repositories/stop_repository.dart';

class GetNearbyStops {
  const GetNearbyStops(this._repository);

  final StopRepository _repository;

  Future<List<BusStop>> call({
    required double latitude,
    required double longitude,
    required int radiusMeters,
  }) {
    return _repository.getNearbyStops(
      latitude: latitude,
      longitude: longitude,
      radiusMeters: radiusMeters,
    );
  }
}
