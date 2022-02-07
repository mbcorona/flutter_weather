import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_stokkur/blocs/weather/weather_cubit.dart';
import 'package:weather_stokkur/common/constants.dart';
import 'package:weather_stokkur/pages/weather/widgets/search_bar.dart';

import 'widgets/current_weather_view.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<WeatherCubit, WeatherState>(
            builder: (context, state) {
              return AnimatedContainer(
                duration: animationDuration,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: state.weather?.daily[state.daySelected].gradient ??
                        [Colors.orange, Colors.amber],
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
                    child: SearchBar(),
                  ),
                  BlocBuilder<WeatherCubit, WeatherState>(
                    builder: (context, state) {
                      return Expanded(
                        child: AnimatedSwitcher(
                          switchInCurve: Curves.easeOut,
                          switchOutCurve: Curves.easeIn,
                          duration: animationDuration,
                          child: Builder(
                            key: Key('${state.weather?.name}'),
                            builder: (_) {
                              if (state.status.isFailure) {
                                return const Text("Something went wrong");
                              }

                              if (state.weather != null) {
                                return CurrentWeatherView(
                                  weather: state.weather!,
                                );
                              }

                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
