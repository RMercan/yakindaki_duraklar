import '../entities/user_location.dart';

abstract class LocationRepository {
  // Throws LocationException on permission or service problems
  Future<UserLocation> getCurrentLocation();
}
