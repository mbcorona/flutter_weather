import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:weather_repository/weather_repository.dart'
    as weather_repository;
import 'package:weather_stokkur/models/models.dart';
import 'package:weather_stokkur/services/location_service.dart';

part 'weather_state.dart';

class WeatherCubit extends HydratedCubit<WeatherState> {
  WeatherCubit(
      {required weather_repository.WeatherRepository weatherRepository,
      LocationService? locationService})
      : _weatherRepository = weatherRepository,
        _location = locationService ?? LocationService(),
        super(const WeatherState());

  final weather_repository.WeatherRepository _weatherRepository;
  final LocationService _location;

  @override
  WeatherState? fromJson(Map<String, dynamic> json) {
    return WeatherState.fromJson(json);
  }

  Future<void> currentWeatherByCity(String city) async {
    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      final weather = await _weatherRepository.getWeather(city: city);
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
      final weather = await _weatherRepository.getWeather(
        coord: weather_repository.Coord(
          lat: location.latitude!,
          lon: location.longitude!,
        ),
      );
      _handleRepositoryResponse(weather);
    } on Exception {
      emit(state.copyWith(status: WeatherStatus.failure));
    }
  }

  Future<void> selectDay(int day) async {
    if (state.weather == null || day < 0 || day > state.weather!.daily.length) {
      return;
    }
    emit(state.copyWith(daySelected: day));
  }

  void _handleRepositoryResponse(weather_repository.Weather weather) {
    emit(
      state.copyWith(
        status: WeatherStatus.success,
        weather: Weather.fromRepository(weather),
      ),
    );
  }

  @override
  Map<String, dynamic>? toJson(WeatherState state) {
    return state.toJson();
  }
}
