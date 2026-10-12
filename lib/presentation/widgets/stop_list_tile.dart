import 'package:flutter/material.dart';

import '../../core/utils/geo_utils.dart';
import '../../domain/entities/bus_stop.dart';

class StopListTile extends StatelessWidget {
  const StopListTile({required this.stop, required this.onTap, super.key});

  final BusStop stop;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final distance = stop.distanceMeters;
    return ListTile(
      leading: const Icon(Icons.directions_bus),
      title: Text(stop.name),
      subtitle: distance == null
          ? null
          : Text(GeoUtils.formatDistance(distance)),
      onTap: onTap,
    );
  }
}
