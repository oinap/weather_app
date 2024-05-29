import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:doumo_test_task/src/core/constants/network_constants.dart';
import 'package:doumo_test_task/src/core/constants/url_constants.dart';
import 'package:doumo_test_task/src/data/data_sources/remote/weather/weather_remote_data_source_impl.dart';
import 'package:doumo_test_task/src/data/models/weather/weather_model.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../../_utils/json_reader.dart';
import '../../../_utils/mocks/mocks.mocks.dart';

void main() {
  late final Dio mockDio;

  late final WeatherRemoteDataSourceImpl weatherRemoteDataSource;

  late final WeatherModel tWeatherModel;

  late final dynamic weatherJson;

  setUpAll(() async {
    await dotenv.load();
    mockDio = MockDio();
    weatherRemoteDataSource = WeatherRemoteDataSourceImpl(mockDio);

    weatherJson = jsonReader('weather_dummy.json');

    tWeatherModel = WeatherModel.fromJson(weatherJson as Map<String, dynamic>);
  });

  // This is a test for getWeather method
  group('getWeather', () {
    late final Response response;
    late final double lat;
    late final double lon;
    late final String fullUrl;
    late final Map<String, dynamic> queryParamteres;
    late final Map<String, double> geoCode;

    setUpAll(() {
      fullUrl = '${NetworkConstants.weatherBaseUrl}/${UrlConstants.getWeather}';
      lat = weatherJson['coord']['lat'];
      lon = weatherJson['coord']['lon'];
      geoCode = {'latitude': lat, 'longitude': lon};
      queryParamteres = {
        'appid': NetworkConstants.weatherApiKey,
        'lat': lat,
        'lon': lon,
        'units': 'metric'
      };
      response = Response<dynamic>(
          data: weatherJson,
          requestOptions: RequestOptions(
              path: UrlConstants.getWeather, queryParameters: queryParamteres));
    });
    test('should return [WeatherModel()] when successful', () async {
// Arrange
      when(mockDio.get(fullUrl, queryParameters: queryParamteres))
          .thenAnswer((_) async => response);

// Act
      final result = await weatherRemoteDataSource.getWeather(geoCode: geoCode);

// Assert
      expect(result, isA<WeatherModel>());
      expect(result, equals(tWeatherModel));
    });

    test('should throw [Exception()] when the call is unsuccessful', () async {
// Arrange
      when(mockDio.get(fullUrl, queryParameters: queryParamteres))
          .thenThrow(Exception());

// Act
      final call = weatherRemoteDataSource.getWeather;

// Assert
      expect(call(geoCode: geoCode), throwsException);
    });
  });
}
