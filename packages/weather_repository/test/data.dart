import 'package:weather_api/weather_api.dart';

final weather = Weather(
  id: 123,
  main: 'Clouds',
  description: 'Clouds',
  icon: 'icon',
);

final CurrentWeatherResponse currentWeatherResponse = CurrentWeatherResponse(
  name: 'Morelia',
  dateTime: DateTime.now().millisecondsSinceEpoch,
  weather: weather,
  coord: Coord(
    lon: 100,
    lat: 100,
  ),
  main: Main(
    temp: 12,
    feelsLike: 11,
    tempMin: 10,
    tempMax: 13,
  ),
);

final OnecallWeatherResponse onecallWeatherResponse = OnecallWeatherResponse(
  current: OneCallWeather(
      dateTime: DateTime.now().millisecondsSinceEpoch,
      temp: 12,
      feelsLike: 11,
      weather: weather),
  hourly: [
    OneCallWeather(dateTime: 123, temp: 12, feelsLike: 11, weather: weather)
  ],
  daily: [
    DailyWeather(
      dateTime: DateTime.now().millisecondsSinceEpoch,
      temp: 12,
      min: 10,
      max: 13,
      feelsLike: 11,
      weather: weather,
    )
  ],
);
