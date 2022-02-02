import 'package:weather_api/src/models/weather.dart';

class OneCallWeather {
  OneCallWeather({
    required this.dateTime,
    required this.temp,
    required this.feelsLike,
    required this.weather,
  });

  factory OneCallWeather.fromJson(Map<String, dynamic> json) {
    return OneCallWeather(
      dateTime: json['dt'],
      temp: json['temp'] * 1.0,
      feelsLike: json['feels_like'] * 1.0,
      weather: Weather.fromJson((json['weather'] as List).first),
    );
  }
  final int dateTime;
  final double temp;
  final double feelsLike;
  final Weather weather;

  Map<String, dynamic> toJson() {
    return {
      'dt': dateTime,
      'temp': temp,
      'feels_like': feelsLike,
      'weather': [weather.toJson()],
    };
  }
}
