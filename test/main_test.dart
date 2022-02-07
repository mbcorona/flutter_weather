import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_repository/weather_repository.dart';
import 'package:weather_stokkur/main.dart';
import 'package:weather_stokkur/pages/weather/weather_page.dart';

import 'helpers/hydrayted_bloc.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  group('WeatherApp', () {
    late WeatherRepository weatherRepository;
    setUp(() {
      weatherRepository = MockWeatherRepository();
    });
    testWidgets('has WeatherAppView and WeatherPage', (tester) async {
      await mockHydratedStorage(
        () async => {
          await tester
              .pumpWidget(WeatherApp(weatherRepository: weatherRepository))
        },
      );
      expect(find.byType(WeatherAppView), findsOneWidget);
      expect(find.byType(WeatherPage), findsOneWidget);
    });
  });
}
