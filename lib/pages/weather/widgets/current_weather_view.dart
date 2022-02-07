import 'package:flutter/material.dart';
import 'package:weather_stokkur/blocs/weather/weather_cubit.dart';
import 'package:weather_stokkur/common/constants.dart';
import 'package:weather_stokkur/common/utils.dart';
import 'package:weather_stokkur/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'forecast_weather_box.dart';

class CurrentWeatherView extends StatelessWidget {
  const CurrentWeatherView({Key? key, required this.weather}) : super(key: key);
  final Weather weather;
  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return BlocListener<WeatherCubit, WeatherState>(
      listener: (context, state) {
        if (state.daySelected != pageController.page!.round()) {
          pageController.jumpToPage(state.daySelected);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              weather.name,
              style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              padEnds: false,
              onPageChanged: (a) {
                context.read<WeatherCubit>().selectDay(a);
              },
              children: weather.daily
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    getDayLabel(
                                      DateTime.fromMillisecondsSinceEpoch(
                                        e.dateTime * 1000,
                                      ).weekday,
                                    ),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  TweenAnimationBuilder(
                                    tween: Tween(begin: 0.0, end: e.temp),
                                    duration: animationDuration,
                                    curve: Curves.easeOut,
                                    builder: (context, double value, _) {
                                      return Text(
                                        "${value.toInt()}°",
                                        key: Key(value.toString()),
                                        style: const TextStyle(
                                          height: 1,
                                          color: Colors.white,
                                          fontSize: 70,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const SizedBox(
                                    height: 13,
                                  ),
                                  Text(
                                    e.main,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Max ${e.max.toInt()}°\nMin ${e.min.toInt()}°',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(.8),
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.end,
                                  )
                                ],
                              ),
                            ],
                          ),
                          Expanded(
                            child: Image.asset(
                              e.asset,
                              // height: size.height / 2.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                ForecastWeatherBox(
                  weathers: weather.hourly,
                  isDaily: false,
                ),
                const SizedBox(height: 10),
                ForecastWeatherBox(
                  weathers: weather.daily,
                  isDaily: true,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
