import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:weather_repository/weather_repository.dart'
    as weather_repository;
import 'package:weather_stokkur/models/models.dart';
import 'package:weather_stokkur/models/weather.dart';
import 'package:weather_stokkur/services/location_service.dart';

part 'weather_state.dart';

class WeatherCubit extends HydratedCubit<WeatherState> {
  WeatherCubit(
      {required weather_repository.WeatherRepository weatherRepository,
      LocationService? location})
      : _weatherRepository = weatherRepository,
        _location = location ?? LocationService(),
        super(WeatherState());

  final weather_repository.WeatherRepository _weatherRepository;
  final LocationService _location;

  @override
  WeatherState? fromJson(Map<String, dynamic> json) {
    return WeatherState.fromJson(json);
  }

  Future<void> currentWeatherByCity(String city) async {
    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      final weather = await _weatherRepository.currentWeather(city: city);
      _handleRepositoryResponse(weather);
    } on Exception {
      emit(state.copyWith(status: WeatherStatus.failure));
    }
  }

  Future<void> currentWeatherByGeolocation() async {
    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      final location = await _location.getLocation();
      if (location == null) {
        return;
      }
      final weather = await _weatherRepository.currentWeather(
          coord: weather_repository.Coord(
        lat: location.latitude!,
        lon: location.longitude!,
      ));
      _handleRepositoryResponse(weather);
    } on Exception {
      emit(state.copyWith(status: WeatherStatus.failure));
    }
  }

  void _handleRepositoryResponse(weather_repository.Weather weather) {
    emit(
      state.copyWith(
        status: WeatherStatus.success,
        weather: Weather(
          name: weather.name,
          main: weather.main,
          description: weather.description,
          temp: weather.temp,
          feelsLike: weather.feelsLike,
          tempMin: weather.tempMin,
          tempMax: weather.tempMax,
          hourly: weather.hourly
              .map(
                (e) => ForecastWeather(
                  id: e.id,
                  main: e.main,
                  description: e.description,
                  icon: e.icon,
                  dateTime: e.dateTime,
                  temp: e.temp,
                  feelsLike: e.feelsLike,
                ),
              )
              .toList(),
          daily: weather.daily
              .map(
                (e) => ForecastWeather(
                  id: e.id,
                  main: e.main,
                  description: e.description,
                  icon: e.icon,
                  dateTime: e.dateTime,
                  temp: e.temp,
                  feelsLike: e.feelsLike,
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  @override
  Map<String, dynamic>? toJson(WeatherState state) {
    return state.toJson();
  }
}
