import 'package:weather_api/weather_api.dart' as weather_api;
import 'package:weather_repository/src/models/forecast_weather.dart';

import 'models/models.dart';

class WeatherRepository {
  WeatherRepository(
      {required String apiKey, weather_api.WeatherApiClient? weatherApiClient})
      : _weatherApiClient =
            weatherApiClient ?? weather_api.WeatherApiClient(apiKey: apiKey);

  final weather_api.WeatherApiClient _weatherApiClient;

  Future<Weather> currentWeather({String? city, Coord? coord}) async {
    assert(city != null || coord != null, 'City or coords must be provided');
    weather_api.CurrentWeatherResponse response;
    if (coord != null) {
      response = await _weatherApiClient.currentWeatherByCoordinates(
          weather_api.Coord(lat: coord.lat, lon: coord.lon));
    } else {
      response = await _weatherApiClient.currentWeatherByCity(city!);
    }

    final onecall =
        await _weatherApiClient.oneCallWeather(coord: response.coord);

    return Weather(
      name: response.name,
      main: response.weather.main,
      description: response.weather.description,
      temp: response.main.temp,
      feelsLike: response.main.feelsLike,
      tempMin: response.main.tempMin,
      tempMax: response.main.tempMax,
      dateTime: response.dateTime,
      hourly: onecall.hourly
          .map(
            (e) => ForecastWeather(
              id: e.weather.id,
              main: e.weather.main,
              description: e.weather.description,
              icon: e.weather.icon,
              dateTime: e.dateTime,
              temp: e.temp,
              feelsLike: e.feelsLike,
            ),
          )
          .toList(),
      daily: onecall.daily
          .map(
            (e) => ForecastWeather(
              id: e.weather.id,
              main: e.weather.main,
              description: e.weather.description,
              icon: e.weather.icon,
              dateTime: e.dateTime,
              temp: e.temp,
              feelsLike: e.feelsLike,
            ),
          )
          .toList(),
    );
  }
}
