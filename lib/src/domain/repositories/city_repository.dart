import 'package:doumo_test_task/src/core/exceptions/network_exception.dart';
import 'package:doumo_test_task/src/domain/entities/city/city_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class CityRepository {
  /// Retrieves a list of cities that match [cityQuery] String.
  Future<Either<NetworkException, List<CityEntity>>> getCities(
      {required String cityQuery});
}
