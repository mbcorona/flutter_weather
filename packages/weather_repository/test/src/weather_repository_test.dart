import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:weather_api/weather_api.dart' as weather_api;
import 'package:weather_repository/weather_repository.dart';

import '../data.dart';

class MockWeatherApiClient extends Mock
    implements weather_api.WeatherApiClient {}

class FakeCoord extends Fake implements weather_api.Coord {}

void main() {
  group('WeatherRepository', () {
    final fakeApi = "fakeApi";
    late weather_api.WeatherApiClient weatherApiClient;
    late WeatherRepository weatherRepository;

    setUp(() {
      weatherApiClient = MockWeatherApiClient();
      weatherRepository = WeatherRepository(
          apiKey: fakeApi, weatherApiClient: weatherApiClient);
    });
    setUpAll(() {
      registerFallbackValue(FakeCoord());
    });

    void validateResponse(Weather response) {
      expect(
        response,
        isA<Weather>()
            .having(
              (w) => w.main,
              'main',
              currentWeatherResponse.weather.main,
            )
            .having((w) => w.name, 'name', currentWeatherResponse.name)
            .having((w) => w.temp, 'temp', currentWeatherResponse.main.temp)
            .having(
                (w) => w.tempMin, 'min', currentWeatherResponse.main.tempMin)
            .having(
                (w) => w.tempMax, 'max', currentWeatherResponse.main.tempMax)
            .having((w) => w.feelsLike, 'feelsLike',
                currentWeatherResponse.main.feelsLike)
            .having((w) => w.hourly.length, 'hourly',
                onecallWeatherResponse.hourly.length)
            .having((w) => w.daily.length, 'daily',
                onecallWeatherResponse.daily.length),
      );
    }

    test('instantiates WeatherApiClient when no injected', () {
      expect(WeatherRepository(apiKey: fakeApi), isNotNull);
    });

    test('throws assertion error when city or coord is not provided', () async {
      expect(() async => await weatherRepository.getWeather(),
          throwsA(isA<AssertionError>()));
    });

    test('get weather by city', () async {
      when(() => weatherApiClient.currentWeatherByCity(city: 'city'))
          .thenAnswer(
        (invocation) async => currentWeatherResponse,
      );
      when(() => weatherApiClient.oneCallWeather(
          coord: currentWeatherResponse.coord)).thenAnswer(
        (invocation) async => onecallWeatherResponse,
      );
      when(() => weatherApiClient.getIconUrl(any()))
          .thenAnswer((invocation) => 'iconUrl');
      final response = await weatherRepository.getWeather(city: 'city');
      validateResponse(response);
    });

    test('get weather by coord', () async {
      final Coord coord = Coord(lat: 100, lon: 100);
      when(() => weatherApiClient.currentWeatherByCoordinates(any()))
          .thenAnswer(
        (invocation) async => currentWeatherResponse,
      );
      when(() => weatherApiClient.oneCallWeather(
          coord: currentWeatherResponse.coord)).thenAnswer(
        (invocation) async => onecallWeatherResponse,
      );
      when(() => weatherApiClient.getIconUrl(any()))
          .thenAnswer((invocation) => 'iconUrl');
      final response = await weatherRepository.getWeather(coord: coord);

      validateResponse(response);
    });
  });
}
