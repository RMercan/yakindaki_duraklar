import '../entities/bus_stop.dart';

abstract class StopRepository {
  // Results are sorted from nearest to farthest
  Future<List<BusStop>> getNearbyStops({
    required double latitude,
    required double longitude,
    required int radiusMeters,
  });
}
