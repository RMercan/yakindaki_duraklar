import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_constants.dart';
import '../../core/error/app_exceptions.dart';
import '../models/bus_stop_model.dart';

class FavoritesLocalSource {
  const FavoritesLocalSource(this._preferences);

  final SharedPreferences _preferences;

  List<BusStopModel> readFavorites() {
    final raw =
        _preferences.getStringList(AppConstants.favoritesStorageKey) ??
        const [];
    return raw
        .map(
          (item) =>
              BusStopModel.fromJson(jsonDecode(item) as Map<String, dynamic>),
        )
        .toList();
  }

  Future<void> writeFavorites(List<BusStopModel> stops) async {
    final raw = stops.map((stop) => jsonEncode(stop.toJson())).toList();
    final isSaved = await _preferences.setStringList(
      AppConstants.favoritesStorageKey,
      raw,
    );
    if (!isSaved) throw const StorageException();
  }
}
