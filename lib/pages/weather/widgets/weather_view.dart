import 'package:flutter/material.dart';
import 'package:weather_stokkur/models/models.dart';

import 'forecast_weather_box.dart';

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
          height: MediaQuery.of(context).size.width * .6,
        ),
        const SizedBox(height: 10),
        ForecastWeatherBox(weathers: weather.hourly, isDaily: false,),
        const SizedBox(height: 10),
        ForecastWeatherBox(weathers: weather.daily, isDaily: true,),
      ],
    );
  }
}