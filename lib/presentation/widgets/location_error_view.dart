import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../core/error/app_exceptions.dart';
import '../blocs/location/location_bloc.dart';

class LocationErrorView extends StatelessWidget {
  const LocationErrorView({required this.reason, super.key});

  final LocationFailureReason reason;

  String get _message => switch (reason) {
    LocationFailureReason.serviceDisabled => 'Konum servisi kapalı. Lütfen aç.',
    LocationFailureReason.permissionDenied =>
      'Yakındaki durakları göstermek için konum izni gerekli.',
    LocationFailureReason.permissionDeniedForever =>
      'Konum izni kalıcı olarak reddedildi. Ayarlardan izin ver.',
    LocationFailureReason.unknown => 'Konum alınamadı. Tekrar dene.',
  };

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.location_off, size: 56),
            const SizedBox(height: 16),
            Text(_message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () =>
                  context.read<LocationBloc>().add(const LocationRequested()),
              child: const Text('Tekrar dene'),
            ),
            if (reason == LocationFailureReason.permissionDeniedForever)
              const TextButton(
                onPressed: Geolocator.openAppSettings,
                child: Text('Ayarları aç'),
              ),
            if (reason == LocationFailureReason.serviceDisabled)
              const TextButton(
                onPressed: Geolocator.openLocationSettings,
                child: Text('Konum ayarlarını aç'),
              ),
          ],
        ),
      ),
    );
  }
}
