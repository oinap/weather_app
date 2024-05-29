import 'package:dio/dio.dart';
import 'package:doumo_test_task/src/core/exceptions/network_exception.dart';
import 'package:doumo_test_task/src/data/data_sources/remote/weather/weather_remote_data_source.dart';
import 'package:doumo_test_task/src/data/models/weather/weather_model.dart';
import 'package:doumo_test_task/src/domain/entities/weather/weather_entity.dart';
import 'package:doumo_test_task/src/domain/repositories/weather/weather_repository.dart';
import 'package:fpdart/fpdart.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource _weatherRemoteDataSource;

  const WeatherRepositoryImpl(this._weatherRemoteDataSource);

  @override
  Future<Either<NetworkException, WeatherEntity>> getWeather(
      {required Map<String, double> geoCode}) async {
    try {
      WeatherModel weatherModel =
          await _weatherRemoteDataSource.getWeather(geoCode: geoCode);
      int temperature = weatherModel.main['temp'].round();

      return Right(WeatherEntity(temperature: temperature));
    } on DioException catch (e) {
      return Left(NetworkException.fromDioException(e));
    }
  }
}
