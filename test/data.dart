import 'package:weather_repository/weather_repository.dart';

final Weather weatherData = Weather(
  name: 'Morelia',
  main: 'Clouds',
  description: 'Clouds',
  temp: 12,
  feelsLike: 11,
  tempMin: 10,
  tempMax: 13,
  dateTime: DateTime.now().millisecondsSinceEpoch,
  hourly: [
    ForecastWeather(
      id: 123,
      main: 'Clouds',
      description: 'Clouds',
      icon: 'iconsUrl',
      dateTime: DateTime.now().millisecondsSinceEpoch,
      temp: 12,
      min: 10,
      max: 13,
      feelsLike: 11,
    )
  ],
  daily: [
    ForecastWeather(
      id: 123,
      main: 'Clouds',
      description: 'Clouds',
      icon: 'iconsUrl',
      dateTime: DateTime.now().millisecondsSinceEpoch,
      temp: 12,
      min: 10,
      max: 13,
      feelsLike: 11,
    )
  ],
);
