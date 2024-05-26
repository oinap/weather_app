import 'package:dio/dio.dart';
import 'package:doumo_test_task/src/core/exceptions/network_exception.dart';
import 'package:doumo_test_task/src/data/data_sources/remote/city/cities_remote_data_source.dart';
import 'package:doumo_test_task/src/data/data_sources/remote/city/cities_remote_data_source_impl.dart';
import 'package:doumo_test_task/src/data/models/city/city_model.dart';
import 'package:doumo_test_task/src/domain/entities/city/city_entity.dart';
import 'package:doumo_test_task/src/domain/repositories/city_repository.dart';
import 'package:fpdart/src/either.dart';

class CityRepositoryImpl implements CityRepository {
  final CityRemoteDataSource _cityRemoteDataSource;

  CityRepositoryImpl(this._cityRemoteDataSource);

  @override
  Future<Either<NetworkException, List<CityEntity>>> getCities(
      {required String cityQuery}) async {
    try {
      List<CityModel> result =
          await _cityRemoteDataSource.getCities(cityQuery: cityQuery);
      return Right(result.map((cityModel) {
        return cityModel.toEntity();
      }).toList());
    } on DioException catch (e) {
      return Left(NetworkException.fromDioException(e));
    }
  }
}
