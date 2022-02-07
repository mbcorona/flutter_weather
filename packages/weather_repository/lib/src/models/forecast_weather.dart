class ForecastWeather {
  ForecastWeather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
    required this.dateTime,
    required this.temp,
    required this.max,
    required this.min,
    required this.feelsLike,
  });

  final int id;
  final String main;
  final String description;
  String icon;
  final int dateTime;
  final double temp;
  final double max;
  final double min;
  final double feelsLike;
}
