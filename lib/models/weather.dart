import 'package:weather_stokkur/models/models.dart';
import 'package:weather_repository/weather_repository.dart'
    as weather_repository show Weather;

class Weather {
  Weather({
    required this.name,
    required this.main,
    required this.description,
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    this.hourly = const [],
    this.daily = const [],
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      name: json['name'],
      main: json['main'],
      description: json['description'],
      temp: json['temp'],
      feelsLike: json['feelsLike'],
      tempMin: json['tempMin'],
      tempMax: json['tempMax'],
      hourly: (json['hourly'] as List)
          .map((e) => ForecastWeather.fromJson(e))
          .toList(),
      daily: (json['daily'] as List)
          .map((e) => ForecastWeather.fromJson(e))
          .toList(),
    );
  }

  factory Weather.fromRepository(weather_repository.Weather weather) {
    return Weather(
      name: weather.name,
      main: weather.main,
      description: weather.description,
      temp: weather.temp,
      feelsLike: weather.feelsLike,
      tempMin: weather.tempMin,
      tempMax: weather.tempMax,
      hourly: weather.hourly
          .map(
            (e) => ForecastWeather(
              id: e.id,
              main: e.main,
              description: e.description,
              icon: e.icon,
              dateTime: e.dateTime,
              temp: e.temp,
              feelsLike: e.feelsLike,
              max: e.max,
              min: e.min,
            ),
          )
          .toList(),
      daily: weather.daily
          .map(
            (e) => ForecastWeather(
              id: e.id,
              main: e.main,
              description: e.description,
              icon: e.icon,
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

  final List<ForecastWeather> hourly;
  final List<ForecastWeather> daily;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'main': main,
      'description': description,
      'temp': temp,
      'feelsLike': feelsLike,
      'tempMin': tempMin,
      'tempMax': tempMax,
      'hourly': hourly.map((e) => e.toJson()).toList(),
      'daily': daily.map((e) => e.toJson()).toList(),
    };
  }
}
