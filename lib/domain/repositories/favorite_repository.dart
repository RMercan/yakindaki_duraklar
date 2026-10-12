import '../entities/bus_stop.dart';

abstract class FavoriteRepository {
  Future<List<BusStop>> getFavorites();

  // Removes the stop if it is a favorite, adds it otherwise; returns the updated list
  Future<List<BusStop>> toggleFavorite(BusStop stop);
}
