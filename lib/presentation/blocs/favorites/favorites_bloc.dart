import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/error/app_exceptions.dart';
import '../../../domain/entities/bus_stop.dart';
import '../../../domain/usecases/get_favorites.dart';
import '../../../domain/usecases/toggle_favorite.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc(this._getFavorites, this._toggleFavorite)
    : super(const FavoritesState()) {
    on<FavoritesStarted>(_onFavoritesStarted);
    on<FavoriteToggled>(_onFavoriteToggled);
  }

  final GetFavorites _getFavorites;
  final ToggleFavorite _toggleFavorite;

  Future<void> _onFavoritesStarted(
    FavoritesStarted event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(FavoritesState(stops: await _getFavorites()));
  }

  Future<void> _onFavoriteToggled(
    FavoriteToggled event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      emit(FavoritesState(stops: await _toggleFavorite(event.stop)));
    } on AppException {
      // Keep the old list when saving fails; the UI warns via hasError
      emit(FavoritesState(stops: state.stops, hasError: true));
    }
  }
}
