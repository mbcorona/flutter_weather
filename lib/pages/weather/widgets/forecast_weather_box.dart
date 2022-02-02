import 'package:flutter/material.dart';
import 'package:weather_stokkur/models/models.dart';

import 'future_forecast.dart';

class ForecastWeatherBox extends StatelessWidget {
  const ForecastWeatherBox({
    Key? key,
    required this.weathers,
    required this.isDaily,
  }) : super(key: key);

  final List<ForecastWeather> weathers;
  final bool isDaily;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isDaily ? 'Daily' : 'Hourly',
          style: const TextStyle(color: Colors.white),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: weathers.map(
              (e) {
                final dateTime =
                    DateTime.fromMillisecondsSinceEpoch(e.dateTime * 1000);
                return FutureForecast(
                  text: '${isDaily ? dateTime.day : dateTime.hour}',
                  iconUrl: e.icon,
                );
              },
            ).toList()),
          ),
        ),
      ],
    );
  }
}
