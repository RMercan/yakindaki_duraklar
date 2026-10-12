import '../entities/bus_stop.dart';
import '../repositories/favorite_repository.dart';

class ToggleFavorite {
  const ToggleFavorite(this._repository);

  final FavoriteRepository _repository;

  Future<List<BusStop>> call(BusStop stop) => _repository.toggleFavorite(stop);
}
