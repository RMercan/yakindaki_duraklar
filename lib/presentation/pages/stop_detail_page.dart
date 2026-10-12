import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/geo_utils.dart';
import '../../domain/entities/bus_stop.dart';
import '../blocs/favorites/favorites_bloc.dart';

class StopDetailPage extends StatelessWidget {
  const StopDetailPage({required this.stop, super.key});

  final BusStop stop;

  @override
  Widget build(BuildContext context) {
    final distance = stop.distanceMeters;
    final routes = stop.routes;

    return Scaffold(
      appBar: AppBar(title: Text(stop.name)),
      body: ListView(
        children: [
          if (distance != null)
            ListTile(
              leading: const Icon(Icons.near_me),
              title: const Text('Uzaklık'),
              subtitle: Text(GeoUtils.formatDistance(distance)),
            ),
          if (routes != null)
            ListTile(
              leading: const Icon(Icons.route),
              title: const Text('Hatlar'),
              subtitle: Text(routes),
            ),
          ListTile(
            leading: const Icon(Icons.place),
            title: const Text('Koordinat'),
            subtitle: Text(
              '${stop.latitude.toStringAsFixed(5)}, ${stop.longitude.toStringAsFixed(5)}',
            ),
          ),
        ],
      ),
      floatingActionButton: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          final isFavorite = state.isFavorite(stop.id);
          return FloatingActionButton.extended(
            onPressed: () =>
                context.read<FavoritesBloc>().add(FavoriteToggled(stop)),
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
            label: Text(isFavorite ? 'Favorilerden çıkar' : 'Favorilere ekle'),
          );
        },
      ),
    );
  }
}
