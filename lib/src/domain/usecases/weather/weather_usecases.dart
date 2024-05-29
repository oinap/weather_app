import 'package:doumo_test_task/src/core/exceptions/network_exception.dart';
import 'package:doumo_test_task/src/domain/entities/weather/weather_entity.dart';
import 'package:doumo_test_task/src/domain/repositories/weather/weather_repository.dart';
import 'package:fpdart/fpdart.dart';

class WeatherUsecases {
  final WeatherRepository _weatherRepository;
  WeatherUsecases(this._weatherRepository);

  /// Retrieves weather based on [geoCode] of form {'langitutde': double, 'latitude': double}
  /// but first checks that the coordinates are valid.
  Future<Either<NetworkException, WeatherEntity>> getWeather(
      {required Map<String, double> geoCode}) async {
    final double longitude = geoCode['longitude']!;
    final double latitude = geoCode['latitude']!;

    if (longitude < -180 || longitude > 180) {
      return const Left(NetworkException(
          message: 'longitude must be in range of [-180,180]',
          statusCode: 400));
    } else if (latitude < -90 || latitude > 90) {
      return const Left(NetworkException(
          message: 'latitude must be in range [-90,90]', statusCode: 400));
    } else {
      return _weatherRepository.getWeather(geoCode: geoCode);
    }
  }
}
