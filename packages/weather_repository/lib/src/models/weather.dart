import 'package:weather_repository/src/models/forecast_weather.dart';

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
