enum LocationFailureReason {
  serviceDisabled,
  permissionDenied,
  permissionDeniedForever,
  unknown,
}

sealed class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => message;
}

class LocationException extends AppException {
  const LocationException(this.reason) : super('Location could not be read');

  final LocationFailureReason reason;
}

class StopFetchException extends AppException {
  const StopFetchException([super.message = 'Stops could not be fetched']);
}

class StorageException extends AppException {
  const StorageException([super.message = 'Local storage failed']);
}
