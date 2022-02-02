class Main {
  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
  });
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json['temp'] * 1.0,
      feelsLike: json['feels_like'] * 1.0,
      tempMin: json['temp_min'] * 1.0,
      tempMax: json['temp_max'] * 1.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temp': temp,
      'feels_like': feelsLike,
      'temp_min': tempMin,
      'temp_max': tempMax,
    };
  }
}
