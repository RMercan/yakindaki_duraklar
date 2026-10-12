import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../core/constants/app_constants.dart';
import '../../domain/entities/user_location.dart';
import '../blocs/location/location_bloc.dart';
import '../blocs/nearby_stops/nearby_stops_bloc.dart';
import '../pages/stop_detail_page.dart';
import 'stop_marker.dart';
import 'user_marker.dart';

class StopsMap extends StatelessWidget {
  const StopsMap({required this.userLocation, super.key});

  final UserLocation userLocation;

  @override
  Widget build(BuildContext context) {
    final center = LatLng(userLocation.latitude, userLocation.longitude);
    final stopsState = context.watch<NearbyStopsBloc>().state;

    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            initialCenter: center,
            initialZoom: AppConstants.defaultZoom,
          ),
          children: [
            TileLayer(
              urlTemplate: AppConstants.tileUrl,
              userAgentPackageName: AppConstants.packageName,
            ),
            MarkerLayer(
              markers: [
                if (stopsState is NearbyStopsLoaded)
                  for (final stop in stopsState.stops)
                    Marker(
                      point: LatLng(stop.latitude, stop.longitude),
                      width: 40,
                      height: 40,
                      child: StopMarker(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => StopDetailPage(stop: stop),
                          ),
                        ),
                      ),
                    ),
                Marker(
                  point: center,
                  width: 24,
                  height: 24,
                  child: const UserMarker(),
                ),
              ],
            ),
          ],
        ),
        if (stopsState is NearbyStopsLoading) const LinearProgressIndicator(),
        if (stopsState is NearbyStopsFailure)
          Positioned(
            left: 16,
            right: 16,
            top: 16,
            child: Card(
              child: ListTile(
                leading: const Icon(Icons.error_outline),
                title: Text(stopsState.message),
                trailing: TextButton(
                  onPressed: () => context.read<NearbyStopsBloc>().add(
                    NearbyStopsRequested(
                      latitude: userLocation.latitude,
                      longitude: userLocation.longitude,
                    ),
                  ),
                  child: const Text('Tekrar'),
                ),
              ),
            ),
          ),
        Positioned(
          right: 16,
          bottom: 16,
          child: FloatingActionButton(
            tooltip: 'Konumumu yenile',
            onPressed: () =>
                context.read<LocationBloc>().add(const LocationRequested()),
            child: const Icon(Icons.my_location),
          ),
        ),
      ],
    );
  }
}
