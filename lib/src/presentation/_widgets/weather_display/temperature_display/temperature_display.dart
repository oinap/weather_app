import 'package:doumo_test_task/src/presentation/_widgets/weather_display/temperature_display/empty_temperature.dart';
import 'package:doumo_test_task/src/presentation/_widgets/weather_display/temperature_display/loading_animation.dart';
import 'package:doumo_test_task/src/presentation/_widgets/weather_display/temperature_display/temperature_widget.dart';
import 'package:doumo_test_task/src/presentation/blocs/weather/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TemperatureDisplay extends StatelessWidget {
  const TemperatureDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final double adaptiveFontSize = MediaQuery.sizeOf(context).width * 0.4;
    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      if (state is WeatherLoaded) {
        // show the temperature with slide in effect
        return TemperatureWidget(
            fontSize: adaptiveFontSize, temperature: state.weather.temperature);
      } else if (state is WeatherLoading) {
        // show loading animation
        return LoadingAnimation(
          fontSize: adaptiveFontSize,
        );
      } else {
        // default placeholder when no data is loading or loaded
        return EmptyTemperature(fontSize: adaptiveFontSize);
      }
    });
  }
}
