import 'package:flutter/material.dart';
import 'package:weather_stokkur/models/models.dart';

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

  final String name;
  final String main;
  final String description;
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;

  final List<ForecastWeather> hourly;
  final List<ForecastWeather> daily;

  String get asset {
    switch (main) {
      case "Clouds":
        return 'assets/images/Cloudy.png';
      case "Clear":
        return 'assets/images/Sunny.png';
      case "Thunderstorm":
      case "Rain":
        return 'assets/images/Rainy.png';
      case "Drizzle":
        return 'assets/images/Night.png';
      default:
        return 'assets/images/Sunny.png';
    }
  }

  List<Color> get gradient {
    switch (main) {
      case "Clouds":
        return [const Color(0xFF8794D9), const Color(0xFF8EAEC6)];
      case "Thunderstorm":
      case "Rain":
        return [const Color(0xFF5F6C75), const Color(0xFF3C6482)];
      case "Drizzle":
        return [const Color(0xFF29333A), const Color(0xFF31414C)];
      case "Clear":
      default:
        return [Colors.orange, Colors.amber];
    }
  }

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
