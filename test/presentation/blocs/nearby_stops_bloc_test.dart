import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yakindaki_duraklar/core/error/app_exceptions.dart';
import 'package:yakindaki_duraklar/domain/entities/bus_stop.dart';
import 'package:yakindaki_duraklar/domain/usecases/get_nearby_stops.dart';
import 'package:yakindaki_duraklar/presentation/blocs/nearby_stops/nearby_stops_bloc.dart';

class MockGetNearbyStops extends Mock implements GetNearbyStops {}

void main() {
  late MockGetNearbyStops getNearbyStops;
  const stop = BusStop(id: '1', name: 'Test', latitude: 41, longitude: 29);
  const request = NearbyStopsRequested(latitude: 41, longitude: 29);

  setUp(() => getNearbyStops = MockGetNearbyStops());

  blocTest<NearbyStopsBloc, NearbyStopsState>(
    'emits [Loading, Loaded] when stops are fetched',
    setUp: () {
      when(
        () => getNearbyStops(
          latitude: any(named: 'latitude'),
          longitude: any(named: 'longitude'),
          radiusMeters: any(named: 'radiusMeters'),
        ),
      ).thenAnswer((_) async => [stop]);
    },
    build: () => NearbyStopsBloc(getNearbyStops),
    act: (bloc) => bloc.add(request),
    expect: () => [
      const NearbyStopsLoading(),
      const NearbyStopsLoaded([stop]),
    ],
  );

  blocTest<NearbyStopsBloc, NearbyStopsState>(
    'emits [Loading, Failure] when fetching throws',
    setUp: () {
      when(
        () => getNearbyStops(
          latitude: any(named: 'latitude'),
          longitude: any(named: 'longitude'),
          radiusMeters: any(named: 'radiusMeters'),
        ),
      ).thenThrow(const StopFetchException());
    },
    build: () => NearbyStopsBloc(getNearbyStops),
    act: (bloc) => bloc.add(request),
    expect: () => [const NearbyStopsLoading(), isA<NearbyStopsFailure>()],
  );
}
