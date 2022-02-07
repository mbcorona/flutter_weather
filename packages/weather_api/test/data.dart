import 'package:weather_api/weather_api.dart';

final currentWeatherResponse = CurrentWeatherResponse(
  name: 'Morelia',
  dateTime: DateTime.now().millisecondsSinceEpoch,
  weather: Weather(
    id: 1,
    main: 'Clouds',
    description: 'Clouds',
    icon: '10d',
  ),
  coord: Coord(lon: 100, lat: 100),
  main: Main(
    temp: 20,
    feelsLike: 20,
    tempMin: 10,
    tempMax: 30,
  ),
);

final oneCallWeatherResponse = OnecallWeatherResponse(
  current: OneCallWeather(
    dateTime: DateTime.now().millisecondsSinceEpoch,
    temp: 20.0,
    feelsLike: 20.0,
    weather: Weather(
      main: 'Clouds',
      icon: '10d',
      description: 'Clouds',
      id: 1,
    ),
  ),
  hourly: [
    OneCallWeather(
      dateTime: DateTime.now().millisecondsSinceEpoch,
      temp: 20.0,
      feelsLike: 20.0,
      weather: Weather(
        main: 'Clouds',
        icon: '10d',
        description: 'Clouds',
        id: 1,
      ),
    )
  ],
  daily: [
    DailyWeather(
      dateTime: DateTime.now().millisecondsSinceEpoch,
      temp: 20.0,
      max: 23,
      min: 21,
      feelsLike: 21.0,
      weather: Weather(
        main: 'Clouds',
        icon: '10d',
        description: 'Clouds',
        id: 1,
      ),
    ),
  ],
);
