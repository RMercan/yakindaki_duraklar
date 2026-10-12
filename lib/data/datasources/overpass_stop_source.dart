import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/constants/app_constants.dart';
import '../../core/error/app_exceptions.dart';
import '../models/bus_stop_model.dart';

class OverpassStopSource {
  const OverpassStopSource(this._client);

  final http.Client _client;

  Future<List<BusStopModel>> fetchStops({
    required double latitude,
    required double longitude,
    required int radiusMeters,
  }) async {
    final query =
        '[out:json][timeout:15];'
        'node["highway"="bus_stop"](around:$radiusMeters,$latitude,$longitude);'
        'out body;';
    try {
      final response = await _client
          .post(
            Uri.parse(AppConstants.overpassUrl),
            // Overpass may answer 406 to requests without a User-Agent
            headers: {'User-Agent': AppConstants.packageName},
            body: {'data': query},
          )
          .timeout(AppConstants.requestTimeout);

      if (response.statusCode != 200) {
        throw StopFetchException('Overpass status ${response.statusCode}');
      }
      final body =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      final elements = body['elements'] as List<dynamic>;
      return elements
          .map(
            (element) =>
                BusStopModel.fromOverpass(element as Map<String, dynamic>),
          )
          .toList();
    } on StopFetchException {
      rethrow;
    } catch (error) {
      throw StopFetchException('Stops request failed: $error');
    }
  }
}
