import 'package:auto_route/auto_route.dart';
import 'package:doumo_test_task/src/presentation/_widgets/city_search/city_search_autocomplete.dart';
import 'package:doumo_test_task/src/presentation/_widgets/error_display/error_snackbar.dart';
import 'package:doumo_test_task/src/presentation/_widgets/weather_display/placeholder_icons.dart';
import 'package:doumo_test_task/src/presentation/_widgets/weather_display/temperature_display/temperature_display.dart';
import 'package:doumo_test_task/src/presentation/_widgets/weather_display/today_date_display.dart';
import 'package:doumo_test_task/src/presentation/blocs/city/city_bloc.dart';
import 'package:doumo_test_task/src/presentation/blocs/weather/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class WeatherView extends StatelessWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    final double spacing = MediaQuery.sizeOf(context).height * 0.05;
    return Scaffold(
      body: SafeArea(
        // Whenever error state is received a snackbar shows the error message
        child: MultiBlocListener(
          listeners: [
            BlocListener<CityBloc, CityState>(
              listener: (context, state) {
                if (state is CityError &&
                    state.message != 'Unexpected bad response') {
                  final SnackBar errorSnackBar =
                      ErrorSnackbar(message: state.message);
                  ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
                }
              },
            ),
            BlocListener<WeatherBloc, WeatherState>(
              listener: (context, state) {
                if (state is WeatherError) {
                  final SnackBar errorSnackBar =
                      ErrorSnackbar(message: state.message);
                  ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
                }
              },
            ),
          ],
          child: Center(
            child: Column(
              children: [
                const CitySearchAutocomplete(),
                SizedBox(height: spacing),
                const TodayDateDisplay(),
                SizedBox(height: spacing),
                const TemperatureDisplay(),
                SizedBox(height: spacing * 2),
                const PlaceholderIcons(),

                // display snackbar if exception is caught
              ],
            ),
          ),
        ),
      ),
    );
  }
}
