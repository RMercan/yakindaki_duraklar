import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/error/app_exceptions.dart';
import '../../../domain/entities/bus_stop.dart';
import '../../../domain/usecases/get_nearby_stops.dart';

part 'nearby_stops_event.dart';
part 'nearby_stops_state.dart';

class NearbyStopsBloc extends Bloc<NearbyStopsEvent, NearbyStopsState> {
  NearbyStopsBloc(this._getNearbyStops) : super(const NearbyStopsInitial()) {
    on<NearbyStopsRequested>(_onNearbyStopsRequested);
  }

  final GetNearbyStops _getNearbyStops;

  Future<void> _onNearbyStopsRequested(
    NearbyStopsRequested event,
    Emitter<NearbyStopsState> emit,
  ) async {
    emit(const NearbyStopsLoading());
    try {
      final stops = await _getNearbyStops(
        latitude: event.latitude,
        longitude: event.longitude,
        radiusMeters: event.radiusMeters,
      );
      emit(NearbyStopsLoaded(stops));
    } on AppException {
      emit(
        const NearbyStopsFailure(
          'Duraklar yüklenemedi. Bağlantını kontrol et.',
        ),
      );
    }
  }
}
