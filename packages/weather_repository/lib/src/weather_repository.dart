import 'package:weather_api/weather_api.dart' as weather_api;

import 'models/models.dart';

class WeatherRepository {
  WeatherRepository(
      {required String apiKey, weather_api.WeatherApiClient? weatherApiClient})
      : _weatherApiClient =
            weatherApiClient ?? weather_api.WeatherApiClient(apiKey: apiKey);

  final weather_api.WeatherApiClient _weatherApiClient;

  Future<Weather> getWeather({String? city, Coord? coord}) async {
    assert(city != null || coord != null, 'City or coords must be provided');
    weather_api.CurrentWeatherResponse currentWeather;
    if (coord != null) {
      currentWeather = await _weatherApiClient.currentWeatherByCoordinates(
          weather_api.Coord(lat: coord.lat, lon: coord.lon));
    } else {
      currentWeather =
          await _weatherApiClient.currentWeatherByCity(city: city!);
    }
    final oneCallWeather = await _weatherApiClient.oneCallWeather(
      coord: currentWeather.coord,
    );
    final result = Weather.fromClientApi(currentWeather, oneCallWeather);
    for (var element in result.hourly) {
      element.icon = _weatherApiClient.getIconUrl(element.icon);
    }
    for (var element in result.daily) {
      element.icon = _weatherApiClient.getIconUrl(element.icon);
    }
    return result;
  }
}
