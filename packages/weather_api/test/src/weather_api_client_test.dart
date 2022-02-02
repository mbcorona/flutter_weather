import 'dart:convert';

import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:weather_api/weather_api.dart';
import 'package:http/http.dart' as http;

import '../data.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('weather_api', () {
    final fakeApiKey = 'FakeAPi';
    late http.Client httpClient;
    late WeatherApiClient weatherApiClient;

    setUp(() {
      httpClient = MockHttpClient();
      weatherApiClient =
          WeatherApiClient(apiKey: fakeApiKey, httpClient: httpClient);
    });

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });
    test('constructor does not need an http client', () async {
      expect(WeatherApiClient(apiKey: fakeApiKey), isNotNull);
    });

    group('get weather by city', () {
      test('correct parameters on Api call', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('[]');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        final city = 'Morelia';
        try {
          await weatherApiClient.currentWeatherByCity(city: city);
        } catch (_) {
          verify(
            () => httpClient.get(
              Uri.https(
                'api.openweathermap.org',
                '/data/2.5/weather',
                <String, String>{
                  'q': city,
                  'appid': fakeApiKey,
                  'units': 'metric',
                },
              ),
            ),
          ).called(1);
        }
      });

      test('throws WeatherNotFoundException whet status is 404', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await weatherApiClient.currentWeatherByCity(city: 'any'),
          throwsA(isA<WeatherNotFoundException>()),
        );
      });

      test('throws WeatherRequestExeption whet status is 404', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(503);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await weatherApiClient.currentWeatherByCity(city: 'any'),
          throwsA(isA<WeatherRequestExeption>()),
        );
      });

      test('returns CurrentWeatherResponse when the call is successful',
          () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body)
            .thenReturn(jsonEncode(currentWeatherResponse.toJson()));
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        final weather =
            await weatherApiClient.currentWeatherByCity(city: 'any');

        expect(
          weather,
          isA<CurrentWeatherResponse>()
              .having((cw) => cw.name, 'name', currentWeatherResponse.name)
              .having((cw) => cw.dateTime, 'dateTime',
                  currentWeatherResponse.dateTime)
              .having((cw) => cw.main.temp, 'main.temp',
                  currentWeatherResponse.main.temp)
              .having((cw) => cw.main.tempMax, 'main.tempMax',
                  currentWeatherResponse.main.tempMax)
              .having((cw) => cw.weather.main, 'weather.main',
                  currentWeatherResponse.weather.main)
              .having((cw) => cw.weather.description, 'weather.main',
                  currentWeatherResponse.weather.description),
        );
      });
    });

    group('get weather by geoLocation', () {
      test('correct parameters on Api call', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        try {
          await weatherApiClient
              .currentWeatherByCoordinates(Coord(lon: 100, lat: 100));
        } catch (_) {
          verify(
            () => httpClient.get(
              Uri.https(
                'api.openweathermap.org',
                '/data/2.5/weather',
                <String, dynamic>{
                  'lat': 100.0.toString(),
                  'lon': 100.0.toString(),
                  'appid': fakeApiKey,
                  'units': 'metric'
                },
              ),
            ),
          ).called(1);
        }
      });

      test('throws WeatherNotFoundException whet status is 404', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await weatherApiClient
              .currentWeatherByCoordinates(Coord(lon: 100, lat: 100)),
          throwsA(isA<WeatherNotFoundException>()),
        );
      });

      test('throws WeatherRequestExeption whet status is 404', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(503);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await weatherApiClient
              .currentWeatherByCoordinates(Coord(lon: 100, lat: 100)),
          throwsA(isA<WeatherRequestExeption>()),
        );
      });

      test('returns CurrentWeatherResponse when the call is successful',
          () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body)
            .thenReturn(jsonEncode(currentWeatherResponse.toJson()));
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        final weather = await weatherApiClient
            .currentWeatherByCoordinates(Coord(lon: 100, lat: 100));

        expect(
          weather,
          isA<CurrentWeatherResponse>()
              .having((cw) => cw.name, 'name', currentWeatherResponse.name)
              .having((cw) => cw.dateTime, 'dateTime',
                  currentWeatherResponse.dateTime)
              .having((cw) => cw.main.temp, 'main.temp',
                  currentWeatherResponse.main.temp)
              .having((cw) => cw.main.tempMax, 'main.tempMax',
                  currentWeatherResponse.main.tempMax)
              .having((cw) => cw.weather.main, 'weather.main',
                  currentWeatherResponse.weather.main)
              .having((cw) => cw.weather.description, 'weather.main',
                  currentWeatherResponse.weather.description),
        );
      });
    });

    group('get weather in one call', () {
      test('correct parameters on Api call', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        try {
          await weatherApiClient.oneCallWeather(
            coord: Coord(lon: 100, lat: 100),
          );
        } catch (_) {
          verify(
            () => httpClient.get(
              Uri.https(
                'api.openweathermap.org',
                '/data/2.5/onecall',
                <String, dynamic>{
                  'lat': 100.0.toString(),
                  'lon': 100.0.toString(),
                  'exclude': [].join(','),
                  'appid': fakeApiKey,
                  'units': 'metric',
                },
              ),
            ),
          ).called(1);
        }
      });

      test('throws WeatherNotFoundException whet status is 404', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await weatherApiClient.oneCallWeather(
            coord: Coord(lon: 100, lat: 100),
          ),
          throwsA(isA<WeatherNotFoundException>()),
        );
      });

      test('throws WeatherRequestExeption whet status is 404', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(503);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await weatherApiClient.oneCallWeather(
            coord: Coord(lon: 100, lat: 100),
          ),
          throwsA(isA<WeatherRequestExeption>()),
        );
      });

      test('returns OnecallWeatherResponse when the call is successful',
          () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body)
            .thenReturn(jsonEncode(oneCallWeatherResponse.toJson()));
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        final weather = await weatherApiClient.oneCallWeather(
          coord: Coord(lon: 100, lat: 100),
        );

        expect(
          weather,
          isA<OnecallWeatherResponse>()
              .having((oc) => oc.current.temp, 'current.temp',
                  oneCallWeatherResponse.current.temp)
              .having((oc) => oc.current.weather.main, 'current.weather.main',
                  oneCallWeatherResponse.current.weather.main)
              .having((oc) => oc.daily.first.temp, 'daily.first.temp',
                  oneCallWeatherResponse.daily.first.temp)
              .having((oc) => oc.hourly.first.temp, 'hourly.first.temp',
                  oneCallWeatherResponse.hourly.first.temp),
        );
      });
    });

    group('iconUrl', () {
      test('get icon url correctly', () {
        final icon = '10d';
        expect(weatherApiClient.getIconUrl(icon),
            'http://openweathermap.org/img/wn/$icon@2x.png');
      });
    });
  });
}
