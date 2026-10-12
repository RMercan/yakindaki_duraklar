part of 'location_bloc.dart';

sealed class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object?> get props => [];
}

class LocationInitial extends LocationState {
  const LocationInitial();
}

class LocationLoading extends LocationState {
  const LocationLoading();
}

class LocationLoaded extends LocationState {
  const LocationLoaded(this.location);

  final UserLocation location;

  @override
  List<Object?> get props => [location];
}

class LocationFailure extends LocationState {
  const LocationFailure(this.reason);

  final LocationFailureReason reason;

  @override
  List<Object?> get props => [reason];
}
