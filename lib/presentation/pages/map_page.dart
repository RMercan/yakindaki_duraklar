import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/app_constants.dart';
import '../blocs/location/location_bloc.dart';
import '../blocs/nearby_stops/nearby_stops_bloc.dart';
import '../widgets/location_error_view.dart';
import '../widgets/stops_map.dart';
import 'favorites_page.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appTitle),
        actions: [
          IconButton(
            tooltip: 'Favoriler',
            icon: const Icon(Icons.favorite),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => const FavoritesPage()),
            ),
          ),
        ],
      ),
      body: BlocConsumer<LocationBloc, LocationState>(
        // Load nearby stops as soon as the location arrives
        listener: (context, state) {
          if (state is LocationLoaded) {
            context.read<NearbyStopsBloc>().add(
              NearbyStopsRequested(
                latitude: state.location.latitude,
                longitude: state.location.longitude,
              ),
            );
          }
        },
        builder: (context, state) {
          return switch (state) {
            LocationInitial() || LocationLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            LocationFailure(:final reason) => LocationErrorView(reason: reason),
            LocationLoaded(:final location) => StopsMap(userLocation: location),
          };
        },
      ),
    );
  }
}
