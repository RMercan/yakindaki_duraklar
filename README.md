# Yakındaki Duraklar

Kullanıcının GPS konumuna göre çevredeki otobüs duraklarını haritada gösteren Flutter uygulaması.

## Özellikler
- Konum izni isteme ve GPS ile mevcut konumu alma
- OpenStreetMap haritası üzerinde yakındaki durakları gösterme (Overpass API, anahtar gerekmez)
- Durak detayı (uzaklık, hatlar, koordinat)
- Favorilere ekleme/çıkarma, yerel depolamada kalıcı saklama

## Teknolojiler
Flutter, Bloc (`flutter_bloc`), `flutter_map`, `geolocator`, `shared_preferences`, `get_it`, `bloc_test` + `mocktail`, GitHub Actions.

## Mimari
```
lib/
  core/           tema, sabitler, hata sınıfları, yardımcılar, DI
  domain/         entities, repository arayüzleri, use case'ler
  data/           models, datasources, repository implementasyonları
  presentation/   blocs, pages, widgets
```
Bağımlılık yönü: `presentation -> domain <- data`. Kod kuralları yerel `RULES.md` dosyasında tutulur (repoda yer almaz).

## Çalıştırma
```bash
flutter pub get
flutter run
```

## Test ve kalite
```bash
dart format .
flutter analyze
flutter test
```
Aynı adımlar `.github/workflows/ci.yml` ile her push/PR'da çalışır.

## Git akışı
`main` kararlı sürüm, `dev` geliştirme dalı; yeni işler gerekirse `dev`'den `feature/*` ile açılır.

## Yol haritası
- Google Maps ve Google Places verisine geçiş değerlendirmesi
- Hat bilgisi ve yaklaşan sefer verisi
- Çoklu dil (l10n)
