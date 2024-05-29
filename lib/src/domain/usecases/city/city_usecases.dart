import 'package:doumo_test_task/src/core/exceptions/network_exception.dart';
import 'package:doumo_test_task/src/domain/repositories/city/city_repository.dart';
import 'package:doumo_test_task/src/domain/entities/city/city_entity.dart';
import 'package:fpdart/fpdart.dart';

class CityUsecases {
  final CityRepository _cityRepository;
  const CityUsecases(this._cityRepository);

  /// Retrieves a list of cities that match [cityQuery] String.
  Future<Either<NetworkException, List<CityEntity>>> getCities(
      {required String cityQuery}) async {
    // city query must be in range [3,50] defined by the API
    if (cityQuery.length < 3 || cityQuery.length > 50) {
      return const Left(NetworkException(
          message: 'City name must be longer than two letters',
          statusCode: 400));
    }
    return _cityRepository.getCities(cityQuery: cityQuery);
  }
}
