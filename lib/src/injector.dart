part of 'package:doumo_test_task/main.dart';

final GetIt injector = GetIt.instance;

Future<void> init() async {
  injector
    // data sources
    ..registerLazySingleton<CityRemoteDataSource>(
        () => CityRemoteDataSourceImpl(Dio()))
    ..registerLazySingleton<WeatherRemoteDataSource>(
        () => WeatherRemoteDataSourceImpl(Dio()))

    // repositories
    ..registerLazySingleton<CityRepository>(
        () => CityRepositoryImpl(injector()))
    ..registerLazySingleton<WeatherRepository>(
        () => WeatherRepositoryImpl(injector()))

    // usecases
    ..registerLazySingleton<CityUsecases>(() => CityUsecases(injector()))
    ..registerLazySingleton<WeatherUsecases>(() => WeatherUsecases(injector()))

    // blocs
    ..registerLazySingleton<CityBloc>(() => CityBloc(injector()))
    ..registerLazySingleton<WeatherBloc>(() => WeatherBloc(injector()));
}
