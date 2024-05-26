import 'package:doumo_test_task/src/data/models/city/city_model.dart';

abstract class CityRemoteDataSource {
  Future<String> getAuthToken();
  Future<List<CityModel>> getCities({required String cityQuery});
}
