class ForecastWeather {
  ForecastWeather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
    required this.dateTime,
    required this.temp,
    required this.feelsLike,
  });

  final int id;
  final String main;
  final String description;
  final String icon;
  final int dateTime;
  final double temp;
  final double feelsLike;
}
