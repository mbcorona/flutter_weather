import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather_repository/weather_repository.dart';
import 'package:weather_stokkur/blocs/weather/weather_cubit.dart';
import 'package:weather_stokkur/pages/weather_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  HydratedBlocOverrides.runZoned(
    () => runApp(WeatherApp(weatherRepository: WeatherRepository(apiKey: "f84c0cf53b69e3addc6d4e2349bcf5cf"))),
    storage: storage,
  );
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key, required WeatherRepository weatherRepository})
      : _weatherRepository = weatherRepository,
        super(key: key);

  final WeatherRepository _weatherRepository;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Stokkur',
      theme: ThemeData(),
      home: BlocProvider(
        create: (context) => WeatherCubit(weatherRepository: _weatherRepository),
        child: const WeatherPage(),
      ),
    );
  }
}
