import 'package:weather_api/src/models/weather.dart';

class DailyWeather {
  DailyWeather({
    required this.dateTime,
    required this.temp,
    required this.feelsLike,
    required this.weather,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    return DailyWeather(
      dateTime: json['dt'],
      temp: json['temp']['day'] * 1.0,
      feelsLike: json['feels_like']['day'] * 1.0,
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
      'temp': {'day': temp},
      'feels_like': {'day': feelsLike},
      'weather': [weather.toJson()],
    };
  }
}
