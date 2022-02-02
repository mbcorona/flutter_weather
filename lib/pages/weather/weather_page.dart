import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_stokkur/blocs/weather/weather_cubit.dart';
import 'package:weather_stokkur/common/constants.dart';

import 'widgets/weather_view.dart';

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
                    colors: state.weather?.gradient ??
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(25),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.8),
                                borderRadius: BorderRadius.circular(5)),
                            child: TextField(
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Search city...",
                                  isDense: true),
                              onSubmitted: (value) {
                                context
                                    .read<WeatherCubit>()
                                    .currentWeatherByCity(value);
                              },
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            context
                                .read<WeatherCubit>()
                                .currentWeatherByGeolocation();
                          },
                          icon: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Icon(
                              Icons.gps_fixed_outlined,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    BlocBuilder<WeatherCubit, WeatherState>(
                      builder: (context, state) {
                        return AnimatedSwitcher(
                          switchInCurve: Curves.easeOut,
                          switchOutCurve: Curves.easeIn,
                          duration: animationDuration,
                          child: Builder(
                            key: Key('${state.status}_${state.weather?.name}'),
                            builder: (_) {
                              if (state.status.isFailure) {
                                return const Text("Something went wrong");
                              }

                              if (state.weather != null) {
                                return WeatherView(
                                  weather: state.weather!,
                                );
                              }

                              return const SizedBox.shrink();
                            },
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
