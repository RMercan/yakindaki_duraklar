import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yakindaki_duraklar/core/error/app_exceptions.dart';
import 'package:yakindaki_duraklar/domain/entities/bus_stop.dart';
import 'package:yakindaki_duraklar/domain/usecases/get_favorites.dart';
import 'package:yakindaki_duraklar/domain/usecases/toggle_favorite.dart';
import 'package:yakindaki_duraklar/presentation/blocs/favorites/favorites_bloc.dart';

class MockGetFavorites extends Mock implements GetFavorites {}

class MockToggleFavorite extends Mock implements ToggleFavorite {}

void main() {
  late MockGetFavorites getFavorites;
  late MockToggleFavorite toggleFavorite;
  const stop = BusStop(id: '1', name: 'Test', latitude: 41, longitude: 29);

  setUp(() {
    getFavorites = MockGetFavorites();
    toggleFavorite = MockToggleFavorite();
  });

  setUpAll(() => registerFallbackValue(stop));

  blocTest<FavoritesBloc, FavoritesState>(
    'emits saved favorites on start',
    setUp: () => when(() => getFavorites()).thenAnswer((_) async => [stop]),
    build: () => FavoritesBloc(getFavorites, toggleFavorite),
    act: (bloc) => bloc.add(const FavoritesStarted()),
    expect: () => [
      const FavoritesState(stops: [stop]),
    ],
  );

  blocTest<FavoritesBloc, FavoritesState>(
    'emits the updated list when a favorite is toggled',
    setUp: () =>
        when(() => toggleFavorite(any())).thenAnswer((_) async => [stop]),
    build: () => FavoritesBloc(getFavorites, toggleFavorite),
    act: (bloc) => bloc.add(const FavoriteToggled(stop)),
    expect: () => [
      const FavoritesState(stops: [stop]),
    ],
  );

  blocTest<FavoritesBloc, FavoritesState>(
    'keeps the old list and flags an error when saving fails',
    setUp: () =>
        when(() => toggleFavorite(any())).thenThrow(const StorageException()),
    build: () => FavoritesBloc(getFavorites, toggleFavorite),
    act: (bloc) => bloc.add(const FavoriteToggled(stop)),
    expect: () => [const FavoritesState(hasError: true)],
  );
}
