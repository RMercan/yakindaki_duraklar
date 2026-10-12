import '../entities/bus_stop.dart';
import '../repositories/favorite_repository.dart';

class GetFavorites {
  const GetFavorites(this._repository);

  final FavoriteRepository _repository;

  Future<List<BusStop>> call() => _repository.getFavorites();
}
