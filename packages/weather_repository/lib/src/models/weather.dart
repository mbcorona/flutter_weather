import 'package:weather_repository/src/models/forecast_weather.dart';
import 'package:weather_api/weather_api.dart' as weather_api;

class Weather {
  Weather({
    required this.name,
    required this.main,
    required this.description,
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.dateTime,
    this.hourly = const [],
    this.daily = const [],
  });

  factory Weather.fromClientApi(
    weather_api.CurrentWeatherResponse currentWeather,
    weather_api.OnecallWeatherResponse oneCallWeather,
  ) {
    return Weather(
      name: currentWeather.name,
      main: currentWeather.weather.main,
      description: currentWeather.weather.description,
      temp: currentWeather.main.temp,
      feelsLike: currentWeather.main.feelsLike,
      tempMin: currentWeather.main.tempMin,
      tempMax: currentWeather.main.tempMax,
      dateTime: currentWeather.dateTime,
      hourly: oneCallWeather.hourly
          .map(
            (e) => ForecastWeather(
              id: e.weather.id,
              main: e.weather.main,
              description: e.weather.description,
              icon: e.weather.icon,
              dateTime: e.dateTime,
              temp: e.temp,
              feelsLike: e.feelsLike,
              max: 0,
              min: 0,
            ),
          )
          .toList(),
      daily: oneCallWeather.daily
          .map(
            (e) => ForecastWeather(
              id: e.weather.id,
              main: e.weather.main,
              description: e.weather.description,
              icon: e.weather.icon,
              dateTime: e.dateTime,
              temp: e.temp,
              feelsLike: e.feelsLike,
              max: e.max,
              min: e.min,
            ),
          )
          .toList(),
    );
  }

  final String name;
  final String main;
  final String description;
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int dateTime;

  final List<ForecastWeather> hourly;
  final List<ForecastWeather> daily;
}
