import 'package:doumo_test_task/src/domain/entities/weather/weather_entity.dart';
import 'package:doumo_test_task/src/core/exceptions/network_exception.dart';
import 'package:fpdart/fpdart.dart';

abstract class WeatherRepository {
  /// Retrieves [WeatherEntity] based on [geoCode] : {'langitutde': double, 'latitude': double}
  Future<Either<NetworkException, WeatherEntity>> getWeather(
      {required Map<String, double> geoCode});
}
