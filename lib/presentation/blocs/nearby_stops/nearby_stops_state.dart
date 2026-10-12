part of 'nearby_stops_bloc.dart';

sealed class NearbyStopsState extends Equatable {
  const NearbyStopsState();

  @override
  List<Object?> get props => [];
}

class NearbyStopsInitial extends NearbyStopsState {
  const NearbyStopsInitial();
}

class NearbyStopsLoading extends NearbyStopsState {
  const NearbyStopsLoading();
}

class NearbyStopsLoaded extends NearbyStopsState {
  const NearbyStopsLoaded(this.stops);

  final List<BusStop> stops;

  @override
  List<Object?> get props => [stops];
}

class NearbyStopsFailure extends NearbyStopsState {
  const NearbyStopsFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
