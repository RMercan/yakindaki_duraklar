import 'package:flutter_test/flutter_test.dart';
import 'package:yakindaki_duraklar/core/utils/geo_utils.dart';

void main() {
  group('GeoUtils.distanceMeters', () {
    test('returns zero for the same point', () {
      final distance = GeoUtils.distanceMeters(
        fromLatitude: 41.0,
        fromLongitude: 29.0,
        toLatitude: 41.0,
        toLongitude: 29.0,
      );
      expect(distance, 0);
    });

    test('returns about 111 km for one degree of latitude', () {
      final distance = GeoUtils.distanceMeters(
        fromLatitude: 40.0,
        fromLongitude: 29.0,
        toLatitude: 41.0,
        toLongitude: 29.0,
      );
      expect(distance, closeTo(111195, 200));
    });
  });

  group('GeoUtils.formatDistance', () {
    test('formats under one kilometer as meters', () {
      expect(GeoUtils.formatDistance(249.6), '250 m');
    });

    test('formats one kilometer and above as kilometers', () {
      expect(GeoUtils.formatDistance(1500), '1.5 km');
    });
  });
}
