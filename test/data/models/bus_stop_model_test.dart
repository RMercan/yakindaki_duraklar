import 'package:flutter_test/flutter_test.dart';
import 'package:yakindaki_duraklar/core/constants/app_constants.dart';
import 'package:yakindaki_duraklar/data/models/bus_stop_model.dart';

void main() {
  group('BusStopModel.fromOverpass', () {
    test('parses a node with tags', () {
      final model = BusStopModel.fromOverpass({
        'id': 42,
        'lat': 41.01,
        'lon': 28.97,
        'tags': {'name': 'Taksim', 'route_ref': '30D;40'},
      });

      expect(model.id, '42');
      expect(model.name, 'Taksim');
      expect(model.latitude, 41.01);
      expect(model.longitude, 28.97);
      expect(model.routes, '30D;40');
    });

    test('falls back to the unnamed label when name is missing', () {
      final model = BusStopModel.fromOverpass({'id': 1, 'lat': 41, 'lon': 29});

      expect(model.name, AppConstants.unnamedStop);
      expect(model.routes, isNull);
    });
  });

  group('BusStopModel json', () {
    test('toJson and fromJson round trip keeps the stop equal', () {
      const original = BusStopModel(
        id: '7',
        name: 'Kadıköy',
        latitude: 40.99,
        longitude: 29.02,
        routes: '14',
      );

      expect(BusStopModel.fromJson(original.toJson()), original);
    });
  });
}
