import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_repository/weather_repository.dart';
import 'package:weather_stokkur/blocs/weather/weather_cubit.dart';
import 'package:weather_stokkur/services/location_service.dart';

import '../../data.dart';
import '../../helpers/hydrayted_bloc.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

class MockLoationService extends Mock implements LocationService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Weather Cubit', () {
    late WeatherRepository weatherRepository;
    late LocationService locationService;

    setUp(() {
      weatherRepository = MockWeatherRepository();
      locationService = MockLoationService();
    });

    blocTest<WeatherCubit, WeatherState>(
      'emits [loading, failure] when currentWeatherByCity throws an Exception.',
      build: () {
        when(() => weatherRepository.getWeather(city: 'city'))
            .thenThrow(Exception());
        return mockHydratedStorage(() => WeatherCubit(
              weatherRepository: weatherRepository,
              locationService: locationService,
            ));
      },
      act: (cubit) => cubit.currentWeatherByCity('city'),
      expect: () => const <WeatherState>[
        WeatherState(status: WeatherStatus.loading),
        WeatherState(status: WeatherStatus.failure),
      ],
    );
    blocTest<WeatherCubit, WeatherState>(
      'emits [loading, success] when get currentWeatherByCity successfully',
      build: () {
        when(() => weatherRepository.getWeather(city: 'city'))
            .thenAnswer((invocation) async => weatherData);
        return mockHydratedStorage(() => WeatherCubit(
              weatherRepository: weatherRepository,
              locationService: locationService,
            ));
      },
      act: (cubit) => cubit.currentWeatherByCity('city'),
      expect: () => <dynamic>[
        const WeatherState(status: WeatherStatus.loading),
        isA<WeatherState>()
            .having((ws) => ws.status, 'status', WeatherStatus.success)
            .having((ws) => ws.daySelected, 'daySelected', 0)
            .having((ws) => ws.weather!.name, 'weather.name', weatherData.name)
            .having((ws) => ws.weather!.temp, 'weather.temp', weatherData.temp)
            .having((ws) => ws.weather!.tempMax, 'weather.tempMax',
                weatherData.tempMax)
            .having((ws) => ws.weather!.tempMin, 'weather.tempMin',
                weatherData.tempMin)
            .having((ws) => ws.weather!.hourly.length, 'weather.hourly',
                weatherData.hourly.length)
            .having((ws) => ws.weather!.daily.length, 'weather.daily',
                weatherData.daily.length),
      ],
    );
  });
}
