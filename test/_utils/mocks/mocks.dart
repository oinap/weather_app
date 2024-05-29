import 'package:dio/dio.dart';
import 'package:doumo_test_task/src/data/data_sources/remote/city/cities_remote_data_source.dart';
import 'package:doumo_test_task/src/data/data_sources/remote/weather/weather_remote_data_source.dart';
import 'package:doumo_test_task/src/domain/repositories/city/city_repository.dart';
import 'package:doumo_test_task/src/domain/repositories/weather/weather_repository.dart';
import 'package:doumo_test_task/src/domain/usecases/city/city_usecases.dart';
import 'package:doumo_test_task/src/domain/usecases/weather/weather_usecases.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  Dio,
  WeatherRemoteDataSource,
  CityRemoteDataSource,
  WeatherRepository,
  CityRepository,
  WeatherUsecases,
  CityUsecases
])
void main() {}
