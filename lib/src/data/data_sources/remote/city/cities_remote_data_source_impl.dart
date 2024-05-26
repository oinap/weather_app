import 'package:dio/dio.dart';
import 'package:doumo_test_task/src/core/constants/network_constants.dart';
import 'package:doumo_test_task/src/core/constants/url_constants.dart';
import 'package:doumo_test_task/src/data/data_sources/remote/city/cities_remote_data_source.dart';
import 'package:doumo_test_task/src/data/models/city/city_model.dart';

class CityRemoteDataSourceImpl implements CityRemoteDataSource {
  final Dio _dio = Dio();

  /// This method returns OAuth 2.0 token, if successful, to use Amadeus test API.\
  /// It uses [ClientId] and [ClientSecret] associated with the registered app
  @override
  Future<String> getAuthToken() async {
    String url = '${NetworkConstants.citiesBaseUrl}/${UrlConstants.citiesAuth}';
    try {
      Response response = await _dio.post(url,
          options: Options(
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
            },
          ),
          data: {
            'grant_type': 'client_credentials',
            'client_id': NetworkConstants.citiesClientId,
            'client_secret': NetworkConstants.citiesClientSecret
          });
      Map<String, dynamic> responseBody = response.data;
      return responseBody['access_token'];
    } on DioException catch (_) {
      rethrow;
    }
  }

  /// This method uses OAuth token to get cities that contain the cityQuery String.\
  /// *The cityQuery parameter String length must be in range of [3,50]*
  @override
  Future<List<CityModel>> getCities({required String cityQuery}) async {
    String url =
        '${NetworkConstants.citiesBaseUrl}/${UrlConstants.citiesGetCoordinates}';
    try {
      String authToken = await getAuthToken();
      Response response = await _dio.get(url,
          options: Options(headers: {'Authorization': 'Bearer $authToken'}),
          queryParameters: {'keyword': cityQuery, 'max': 10});

      // extract list of cities from the response
      List<dynamic> entries = response.data['data'];
      List<CityModel> cities = entries.map((entry) {
        return CityModel.fromJson(entry);
      }).toList();
      return cities;
    } on DioException catch (_) {
      rethrow;
    }
  }
}
