import 'package:dio/dio.dart';
import 'package:doumo_test_task/src/core/exceptions/network_exception.dart';
import 'package:doumo_test_task/src/data/data_sources/remote/city/cities_remote_data_source.dart';
import 'package:doumo_test_task/src/data/data_sources/remote/city/cities_remote_data_source_impl.dart';
import 'package:doumo_test_task/src/data/models/city/city_model.dart';
import 'package:doumo_test_task/src/domain/entities/city/city_entity.dart';
import 'package:doumo_test_task/src/domain/repositories/city/city_repository.dart';
import 'package:fpdart/fpdart.dart';

class CityRepositoryImpl implements CityRepository {
  final CityRemoteDataSource _cityRemoteDataSource;

  CityRepositoryImpl(this._cityRemoteDataSource);

  /// retrieves cities, but only saves those with non empty geoCodes
  @override
  Future<Either<NetworkException, List<CityEntity>>> getCities(
      {required String cityQuery}) async {
    try {
      List<CityModel> result =
          await _cityRemoteDataSource.getCities(cityQuery: cityQuery);

// Only save cities that are have non empty geoCodes
      List<CityEntity> citiesWithGeoCodes = [];
      for (CityModel city in result) {
        if (city.geoCode.isNotEmpty) {
          citiesWithGeoCodes.add(city.toEntity());
        }
      }

      return Right(citiesWithGeoCodes);
    } on DioException catch (e) {
      return Left(NetworkException.fromDioException(e));
    }
  }
}
