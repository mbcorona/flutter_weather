import 'package:weather_api/src/models/weather.dart';

class DailyWeather {
  DailyWeather({
    required this.dateTime,
    required this.temp,
    required this.min,
    required this.max,
    required this.feelsLike,
    required this.weather,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    return DailyWeather(
      dateTime: json['dt'],
      temp: json['temp']['day'] * 1.0,
      max: json['temp']['max'] * 1.0,
      min: json['temp']['min'] * 1.0,
      feelsLike: json['feels_like']['day'] * 1.0,
      weather: Weather.fromJson((json['weather'] as List).first),
    );
  }
  final int dateTime;
  final double temp;
  final double min;
  final double max;
  final double feelsLike;
  final Weather weather;

  Map<String, dynamic> toJson() {
    return {
      'dt': dateTime,
      'temp': {
        'day': temp,
        'max': max,
        'min': min,
      },
      'feels_like': {'day': feelsLike},
      'weather': [weather.toJson()],
    };
  }
}
