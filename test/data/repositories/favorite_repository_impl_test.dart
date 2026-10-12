import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yakindaki_duraklar/data/datasources/favorites_local_source.dart';
import 'package:yakindaki_duraklar/data/repositories/favorite_repository_impl.dart';
import 'package:yakindaki_duraklar/domain/entities/bus_stop.dart';

void main() {
  const stop = BusStop(id: '1', name: 'Test', latitude: 41, longitude: 29);
  late FavoriteRepositoryImpl repository;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    repository = FavoriteRepositoryImpl(FavoritesLocalSource(preferences));
  });

  test('returns an empty list when nothing is saved', () async {
    expect(await repository.getFavorites(), isEmpty);
  });

  test('adds a stop on first toggle and persists it', () async {
    final result = await repository.toggleFavorite(stop);

    // Repository returns models, so compare by id
    expect(result.map((favorite) => favorite.id), ['1']);
    final saved = await repository.getFavorites();
    expect(saved.map((favorite) => favorite.id), ['1']);
  });

  test('removes the stop on second toggle', () async {
    await repository.toggleFavorite(stop);
    final result = await repository.toggleFavorite(stop);

    expect(result, isEmpty);
  });
}
