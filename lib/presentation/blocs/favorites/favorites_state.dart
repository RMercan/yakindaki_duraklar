part of 'favorites_bloc.dart';

class FavoritesState extends Equatable {
  const FavoritesState({this.stops = const [], this.hasError = false});

  final List<BusStop> stops;
  final bool hasError;

  bool isFavorite(String stopId) => stops.any((stop) => stop.id == stopId);

  @override
  List<Object?> get props => [stops, hasError];
}
