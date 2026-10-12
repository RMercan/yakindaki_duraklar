import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/datasources/device_location_source.dart';
import '../../data/datasources/favorites_local_source.dart';
import '../../data/datasources/overpass_stop_source.dart';
import '../../data/repositories/favorite_repository_impl.dart';
import '../../data/repositories/location_repository_impl.dart';
import '../../data/repositories/stop_repository_impl.dart';
import '../../domain/repositories/favorite_repository.dart';
import '../../domain/repositories/location_repository.dart';
import '../../domain/repositories/stop_repository.dart';
import '../../domain/usecases/get_current_location.dart';
import '../../domain/usecases/get_favorites.dart';
import '../../domain/usecases/get_nearby_stops.dart';
import '../../domain/usecases/toggle_favorite.dart';
import '../../presentation/blocs/favorites/favorites_bloc.dart';
import '../../presentation/blocs/location/location_bloc.dart';
import '../../presentation/blocs/nearby_stops/nearby_stops_bloc.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  final preferences = await SharedPreferences.getInstance();

  // Data sources
  getIt
    ..registerLazySingleton(() => OverpassStopSource(http.Client()))
    ..registerLazySingleton(() => FavoritesLocalSource(preferences))
    ..registerLazySingleton(() => const DeviceLocationSource());

  // Repositories
  getIt
    ..registerLazySingleton<StopRepository>(() => StopRepositoryImpl(getIt()))
    ..registerLazySingleton<FavoriteRepository>(
      () => FavoriteRepositoryImpl(getIt()),
    )
    ..registerLazySingleton<LocationRepository>(
      () => LocationRepositoryImpl(getIt()),
    );

  // Use cases
  getIt
    ..registerLazySingleton(() => GetNearbyStops(getIt()))
    ..registerLazySingleton(() => GetFavorites(getIt()))
    ..registerLazySingleton(() => ToggleFavorite(getIt()))
    ..registerLazySingleton(() => GetCurrentLocation(getIt()));

  // Blocs are created as new instances for each widget tree
  getIt
    ..registerFactory(() => LocationBloc(getIt()))
    ..registerFactory(() => NearbyStopsBloc(getIt()))
    ..registerFactory(() => FavoritesBloc(getIt(), getIt()));
}
