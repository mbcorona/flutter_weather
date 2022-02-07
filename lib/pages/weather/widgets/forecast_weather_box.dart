import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_stokkur/blocs/weather/weather_cubit.dart';
import 'package:weather_stokkur/common/utils.dart';
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
            color: Colors.white.withOpacity(.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(weathers.length, (index) {
                final dateTime = DateTime.fromMillisecondsSinceEpoch(
                    weathers[index].dateTime * 1000);
                return BlocBuilder<WeatherCubit, WeatherState>(
                  builder: (context, state) {
                    return FutureForecast(
                      text: '${isDaily ? getDayLabel(dateTime.weekday) : dateTime.hour}',
                      iconUrl: weathers[index].icon,
                      selected: isDaily ? state.daySelected == index : false,
                      onTap: isDaily ? (){
                        context.read<WeatherCubit>().selectDay(index);
                      } : null,
                    );
                  },
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
