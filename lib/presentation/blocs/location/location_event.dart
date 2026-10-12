part of 'location_bloc.dart';

sealed class LocationEvent {
  const LocationEvent();
}

class LocationRequested extends LocationEvent {
  const LocationRequested();
}
