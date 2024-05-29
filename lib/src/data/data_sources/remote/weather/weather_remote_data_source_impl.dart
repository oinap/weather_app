import 'package:dio/dio.dart';
import 'package:doumo_test_task/src/core/constants/network_constants.dart';
import 'package:doumo_test_task/src/core/constants/url_constants.dart';
import 'package:doumo_test_task/src/data/data_sources/remote/weather/weather_remote_data_source.dart';
import 'package:doumo_test_task/src/data/models/weather/weather_model.dart';

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final Dio _dio;

  const WeatherRemoteDataSourceImpl(this._dio);
  @override
  Future<WeatherModel> getWeather(
      {required Map<String, double> geoCode}) async {
    String url =
        '${NetworkConstants.weatherBaseUrl}/${UrlConstants.getWeather}';
    String apiKey = NetworkConstants.weatherApiKey;
    double latitude = geoCode['latitude']!;
    double longitude = geoCode['longitude']!;
    try {
      Response response = await _dio.get(url, queryParameters: {
        'appid': apiKey,
        'lat': latitude,
        'lon': longitude,
        'units': 'metric'
      });

      return WeatherModel.fromJson(response.data);
    } on DioException catch (_) {
      rethrow;
    }
  }
}
