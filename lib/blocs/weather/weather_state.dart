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

class WeatherState extends Equatable {
  const WeatherState({
    this.status = WeatherStatus.initial,
    this.weather,
    this.daySelected = 0,
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
  final int daySelected;

  WeatherState copyWith({
    WeatherStatus? status,
    Weather? weather,
    int? daySelected,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
      daySelected: daySelected ?? this.daySelected,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': weatherStatusEnumMap[status],
      'weather': weather?.toJson(),
    };
  }

  @override
  List<Object?> get props => [status, weather, daySelected];
}
