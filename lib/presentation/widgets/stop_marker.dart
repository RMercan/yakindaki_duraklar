import 'package:flutter/material.dart';

class StopMarker extends StatelessWidget {
  const StopMarker({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        Icons.directions_bus,
        color: Theme.of(context).colorScheme.primary,
        size: 32,
      ),
    );
  }
}
