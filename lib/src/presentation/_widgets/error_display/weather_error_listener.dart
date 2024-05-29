import 'package:doumo_test_task/src/presentation/_widgets/error_display/error_snackbar.dart';
import 'package:doumo_test_task/src/presentation/blocs/weather/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherErrorListener extends StatelessWidget {
  const WeatherErrorListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<WeatherBloc, WeatherState>(
      listener: (context, state) {
        if (state is WeatherError) {
          final SnackBar errorSnackBar = ErrorSnackbar(message: state.message);
          ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
        }
      },
    );
  }
}
