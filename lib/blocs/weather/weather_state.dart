part of 'weather_cubit.dart';

enum WeatherStatus { initial, loading, success, failure }

extension WeatherStatusX on WeatherStatus {
  bool get isInitial => this == WeatherStatus.initial;
  bool get isLoading => this == WeatherStatus.loading;
  bool get isSuccess => this == WeatherStatus.success;
  bool get isFailure => this == WeatherStatus.failure;
}

const weatherStatusEnumMap = {
  WeatherStatus.initial: 'initial',
  WeatherStatus.loading: 'loading',
  WeatherStatus.success: 'success',
  WeatherStatus.failure: 'failure',
};

class WeatherState {
  WeatherState({
    this.status = WeatherStatus.initial,
    this.weather,
  });

  factory WeatherState.fromJson(Map<String, dynamic> json) {
    final status = weatherStatusEnumMap.entries
        .singleWhere((e) => e.value == json['status'],
            orElse: () => const MapEntry(WeatherStatus.initial, 'initial'))
        .key;
    return WeatherState(
      status: status,
      weather: Weather.fromJson(json['weather']),
    );
  }

  final WeatherStatus status;
  final Weather? weather;

  WeatherState copyWith({
    WeatherStatus? status,
    Weather? weather,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': weatherStatusEnumMap[status],
      'weather': weather?.toJson(),
    };
  }
}
