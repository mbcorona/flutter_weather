import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:weather_repository/weather_repository.dart'
    show WeatherRepository, Coord;
import 'package:weather_stokkur/models/weather.dart';
import 'package:weather_stokkur/services/location_service.dart';

part 'weather_state.dart';

class WeatherCubit extends HydratedCubit<WeatherState> {
  WeatherCubit(
      {required WeatherRepository weatherRepository, LocationService? location})
      : _weatherRepository = weatherRepository,
        _location = location ?? LocationService(),
        super(WeatherState());

  final WeatherRepository _weatherRepository;
  final LocationService _location;

  @override
  WeatherState? fromJson(Map<String, dynamic> json) {
    return WeatherState.fromJson(json);
  }

  Future<void> currentWeatherByCity(String city) async {
    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      final weather = await _weatherRepository.currentWeather(city: city);
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
          ),
        ),
      );
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
          coord: Coord(
        lat: location.latitude!,
        lon: location.longitude!,
      ));
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
          ),
        ),
      );
    } on Exception {
      emit(state.copyWith(status: WeatherStatus.failure));
    }
  }

  @override
  Map<String, dynamic>? toJson(WeatherState state) {
    return state.toJson();
  }
}
