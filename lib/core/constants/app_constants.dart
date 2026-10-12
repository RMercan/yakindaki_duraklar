class AppConstants {
  const AppConstants._();

  static const String appTitle = 'Yakındaki Duraklar';
  static const String packageName = 'com.rmercan.yakindaki_duraklar';

  static const String overpassUrl = 'https://overpass-api.de/api/interpreter';
  static const String tileUrl =
      'https://tile.openstreetmap.org/{z}/{x}/{y}.png';

  static const int defaultRadiusMeters = 500;
  static const double defaultZoom = 16;
  static const Duration requestTimeout = Duration(seconds: 20);

  static const String unnamedStop = 'İsimsiz Durak';
  static const String favoritesStorageKey = 'favorite_stops';
}
