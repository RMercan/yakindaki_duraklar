import '../../domain/entities/user_location.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/device_location_source.dart';

class LocationRepositoryImpl implements LocationRepository {
  const LocationRepositoryImpl(this._source);

  final DeviceLocationSource _source;

  @override
  Future<UserLocation> getCurrentLocation() => _source.readCurrentLocation();
}
