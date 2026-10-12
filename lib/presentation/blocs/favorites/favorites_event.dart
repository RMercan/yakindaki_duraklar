part of 'favorites_bloc.dart';

sealed class FavoritesEvent {
  const FavoritesEvent();
}

class FavoritesStarted extends FavoritesEvent {
  const FavoritesStarted();
}

class FavoriteToggled extends FavoritesEvent {
  const FavoriteToggled(this.stop);

  final BusStop stop;
}
