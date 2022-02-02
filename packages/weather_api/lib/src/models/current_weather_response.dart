import 'models.dart';

class CurrentWeatherResponse {
  CurrentWeatherResponse({
    required this.name,
    required this.dateTime,
    required this.weather,
    required this.coord,
    required this.main,
  });
  final String name;
  final int dateTime;
  final Weather weather;
  final Coord coord;
  final Main main;

  factory CurrentWeatherResponse.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherResponse(
      name: json['name'] as String,
      dateTime: json['dt'] as int,
      weather: Weather.fromJson((json['weather'] as List).first),
      coord: Coord.fromJson(json['coord']),
      main: Main.fromJson(json['main']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dt': dateTime,
      'weather': [weather.toJson()],
      'coord': coord.toJson(),
      'main': main.toJson(),
    };
  }
}
