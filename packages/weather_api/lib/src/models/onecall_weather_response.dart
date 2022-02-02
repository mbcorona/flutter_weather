import 'package:weather_api/src/models/daily_weather.dart';
import 'package:weather_api/weather_api.dart';

class OnecallWeatherResponse {
  OnecallWeatherResponse({
    required this.current,
    required this.hourly,
    required this.daily,
  });

  factory OnecallWeatherResponse.fromJson(Map<String, dynamic> json) {
    return OnecallWeatherResponse(
      current: OneCallWeather.fromJson(json['current']),
      hourly: (json['hourly'] as List)
          .map(
            (e) => OneCallWeather.fromJson(e),
          )
          .toList(),
      daily: (json['daily'] as List)
          .map(
            (e) => DailyWeather.fromJson(e),
          )
          .toList(),
    );
  }

  final OneCallWeather current;
  final List<OneCallWeather> hourly;
  final List<DailyWeather> daily;

  Map<String, dynamic> toJson() {
    return {
      'current': current.toJson(),
      'hourly': hourly.map((e) => e.toJson()).toList(),
      'daily': daily.map((e) => e.toJson()).toList(),
    };
  }
}
