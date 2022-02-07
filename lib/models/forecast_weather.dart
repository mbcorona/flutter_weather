import 'package:flutter/material.dart';

class ForecastWeather {
  ForecastWeather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
    required this.dateTime,
    required this.temp,
    required this.min,
    required this.max,
    required this.feelsLike,
  });

  factory ForecastWeather.fromJson(Map<String, dynamic> json) {
    return ForecastWeather(
      id: json['id'] as int,
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
      dateTime: json['dateTime'] as int,
      temp: json['temp'],
      min: json['max'],
      max: json['min'],
      feelsLike: json['feelsLike'],
    );
  }

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

  final int id;
  final String main;
  final String description;
  final String icon;
  final int dateTime;
  final double temp;
  final double min;
  final double max;
  final double feelsLike;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'main': main,
      'description': description,
      'icon': icon,
      'dateTime': dateTime,
      'temp': temp,
      'max': max,
      'min': min,
      'feelsLike': feelsLike,
    };
  }
}
