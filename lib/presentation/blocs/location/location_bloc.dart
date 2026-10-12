import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/error/app_exceptions.dart';
import '../../../domain/entities/user_location.dart';
import '../../../domain/usecases/get_current_location.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc(this._getCurrentLocation) : super(const LocationInitial()) {
    on<LocationRequested>(_onLocationRequested);
  }

  final GetCurrentLocation _getCurrentLocation;

  Future<void> _onLocationRequested(
    LocationRequested event,
    Emitter<LocationState> emit,
  ) async {
    emit(const LocationLoading());
    try {
      emit(LocationLoaded(await _getCurrentLocation()));
    } on LocationException catch (error) {
      emit(LocationFailure(error.reason));
    }
  }
}
