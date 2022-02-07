import 'package:flutter/material.dart';
import 'package:weather_stokkur/blocs/weather/weather_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _searchCtrl = TextEditingController();
    return Row(
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.8),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextField(
                  controller: _searchCtrl,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search city...",
                    isDense: true,
                  ),
                  onSubmitted: (value) {
                    context.read<WeatherCubit>().currentWeatherByCity(value);
                  },
                ),
              ),
              BlocBuilder<WeatherCubit, WeatherState>(
                builder: (context, state) {
                  return Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: state.status.isLoading
                        ? ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                            child: LinearProgressIndicator(
                              backgroundColor: state.weather
                                  ?.daily[state.daySelected].gradient[0],
                              color: state.weather?.daily[state.daySelected]
                                  .gradient[1],
                            ),
                          )
                        : const SizedBox.shrink(),
                  );
                },
              )
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            _searchCtrl.clear();
            context.read<WeatherCubit>().currentWeatherByGeolocation();
          },
          icon: BlocBuilder<WeatherCubit, WeatherState>(
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: state.weather != null && _searchCtrl.text.isEmpty
                      ? Colors.white
                      : Colors.transparent,
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Icon(
                  Icons.near_me_rounded,
                ),
              );
            },
          ),
        )
      ],
    );
  }
}