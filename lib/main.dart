import 'package:dio/dio.dart';
import 'package:doumo_test_task/src/config/router/app_router.dart';
import 'package:doumo_test_task/src/core/constants/app_theme.dart';
import 'package:doumo_test_task/src/data/data_sources/remote/city/cities_remote_data_source.dart';
import 'package:doumo_test_task/src/data/data_sources/remote/city/cities_remote_data_source_impl.dart';
import 'package:doumo_test_task/src/data/data_sources/remote/weather/weather_remote_data_source.dart';
import 'package:doumo_test_task/src/data/data_sources/remote/weather/weather_remote_data_source_impl.dart';
import 'package:doumo_test_task/src/data/repositories/city/city_repository_impl.dart';
import 'package:doumo_test_task/src/data/repositories/weather/weather_repository_impl.dart';
import 'package:doumo_test_task/src/domain/repositories/city/city_repository.dart';
import 'package:doumo_test_task/src/domain/repositories/weather/weather_repository.dart';
import 'package:doumo_test_task/src/domain/usecases/city/city_usecases.dart';
import 'package:doumo_test_task/src/domain/usecases/weather/weather_usecases.dart';
import 'package:doumo_test_task/src/presentation/blocs/city/city_bloc.dart';
import 'package:doumo_test_task/src/presentation/blocs/weather/weather_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'package:doumo_test_task/src/injector.dart';

void main() async {
  await dotenv.load();
  // init the injector
  await init();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => injector<CityBloc>()),
          BlocProvider(create: (context) => injector<WeatherBloc>())
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          routerConfig: _appRouter.config(),
        ));
  }
}
