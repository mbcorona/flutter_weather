import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_stokkur/blocs/weather/weather_cubit.dart';
import 'package:weather_stokkur/common/constants.dart';
import 'package:weather_stokkur/models/weather.dart';

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
                            key: Key(state.weather?.name ?? "loading"),
                            builder: (_) {
                              if (state.status.isSuccess) {
                                return WeatherView(
                                  weather: state.weather!,
                                );
                              }

                              if (state.status.isFailure) {
                                return const Text("Something went wrong");
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

class WeatherView extends StatelessWidget {
  const WeatherView({
    Key? key,
    required this.weather,
  }) : super(key: key);

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${weather.name}\n${weather.main}',
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  weather.temp.toInt().toString() + "°",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 80,
                  ),
                ),
                Text(
                  'Max ${weather.tempMax.toInt()}°\nMin ${weather.tempMin.toInt()}°',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                )
              ],
            )
          ],
        ),
        Image.asset(
          weather.asset,
          height: MediaQuery.of(context).size.width * .8,
        ),
        const SizedBox(height: 10),
        const WetherNextDaysView(),
        const SizedBox(height: 10),
        const WetherNextDaysView(),
      ],
    );
  }
}

class WetherNextDaysView extends StatelessWidget {
  const WetherNextDaysView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          Tbd(),
          Tbd(),
          Tbd(),
          Tbd(),
        ],
      ),
    );
  }
}

class Tbd extends StatelessWidget {
  const Tbd({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: const [
          Text(
            "Now",
            style: TextStyle(color: Colors.grey),
          ),
          Icon(Icons.cloud),
        ],
      ),
    );
  }
}
