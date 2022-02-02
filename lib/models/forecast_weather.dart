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

  factory ForecastWeather.fromJson(Map<String, dynamic> json) {
    return ForecastWeather(
      id: json['id'] as int,
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
      dateTime: json['dateTime'] as int,
      temp: json['temp'],
      feelsLike: json['feelsLike'],
    );
  }

  final int id;
  final String main;
  final String description;
  final String icon;
  final int dateTime;
  final double temp;
  final double feelsLike;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'main': main,
      'description': description,
      'icon': icon,
      'dateTime': dateTime,
      'temp': temp,
      'feelsLike': feelsLike,
    };
  }
}
