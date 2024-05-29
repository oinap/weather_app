import 'package:auto_route/auto_route.dart';
import 'package:doumo_test_task/src/core/constants/app_theme.dart';
import 'package:doumo_test_task/src/data/data_sources/remote/city/cities_remote_data_source_impl.dart';
import 'package:doumo_test_task/src/data/data_sources/remote/weather/weather_remote_data_source_impl.dart';
import 'package:doumo_test_task/src/data/models/city/city_model.dart';
import 'package:doumo_test_task/src/data/models/weather/weather_model.dart';
import 'package:doumo_test_task/src/presentation/_widgets/city_search/city_search_autocomplete.dart';
import 'package:doumo_test_task/src/presentation/_widgets/weather_display/placeholder_icons.dart';
import 'package:doumo_test_task/src/presentation/_widgets/weather_display/temperature_display/temperature_display.dart';
import 'package:doumo_test_task/src/presentation/_widgets/weather_display/today_date_display.dart';
import 'package:doumo_test_task/src/presentation/blocs/city/city_bloc.dart';
import 'package:doumo_test_task/src/presentation/blocs/weather/weather_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class WeatherView extends StatelessWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const CitySearchAutocomplete(),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.05,
              ),
              const TodayDateDisplay(),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.05,
              ),
              const TemperatureDisplay(),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.1,
              ),
              const PlaceholderIcons()
            ],
          ),
        ),
      ),
    );
  }
}
