import '../../domain/entities/bus_stop.dart';
import '../../domain/repositories/favorite_repository.dart';
import '../datasources/favorites_local_source.dart';
import '../models/bus_stop_model.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  const FavoriteRepositoryImpl(this._source);

  final FavoritesLocalSource _source;

  @override
  Future<List<BusStop>> getFavorites() async => _source.readFavorites();

  @override
  Future<List<BusStop>> toggleFavorite(BusStop stop) async {
    final favorites = _source.readFavorites();
    final wasFavorite = favorites.any((favorite) => favorite.id == stop.id);
    if (wasFavorite) {
      favorites.removeWhere((favorite) => favorite.id == stop.id);
    } else {
      favorites.add(BusStopModel.fromEntity(stop));
    }
    await _source.writeFavorites(favorites);
    return favorites;
  }
}
