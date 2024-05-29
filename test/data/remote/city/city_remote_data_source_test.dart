import 'package:dio/dio.dart';
import 'package:doumo_test_task/src/core/constants/network_constants.dart';
import 'package:doumo_test_task/src/core/constants/url_constants.dart';
import 'package:doumo_test_task/src/data/data_sources/remote/city/cities_remote_data_source_impl.dart';
import 'package:doumo_test_task/src/data/models/city/city_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../_utils/json_reader.dart';
import '../../../_utils/mocks/mocks.mocks.dart';

void main() {
  late final Dio mockDio;
  late final CityRemoteDataSourceImpl cityRemoteDataSource;
  late final List<CityModel> tCityModels;
  late final Map<String, dynamic> citiesJson;

  setUpAll(() async {
    mockDio = MockDio();
    await dotenv.load();
    cityRemoteDataSource = CityRemoteDataSourceImpl(mockDio);
    citiesJson = jsonReader('city_dummy.json');

    tCityModels = [];
    for (Map<String, dynamic> cityJson in citiesJson['data']) {
      CityModel model = CityModel.fromJson(cityJson);
      tCityModels.add(model);
    }
  });

// This is a test for getCities method
  group('getCities', () {
    late final Response response;
    late final String cityQuery;
    late final String getUrl;
    late final String postUrl;
    late final Map<String, dynamic> queryParameters;

    setUpAll(() {
      getUrl =
          '${NetworkConstants.citiesBaseUrl}/${UrlConstants.citiesGetCoordinates}';
      postUrl = '${NetworkConstants.citiesBaseUrl}/${UrlConstants.citiesAuth}';
      cityQuery = 'par';
      queryParameters = {'keyword': cityQuery, 'max': 5};
      response = Response<dynamic>(
          data: citiesJson,
          requestOptions:
              RequestOptions(path: getUrl, queryParameters: queryParameters));
    });

    test('should return a [CityModel()] when request is successful', () async {
      // Arrange

      // auth token
      when(mockDio.post(
        postUrl,
        options: anyNamed('options'),
        data: anyNamed('data'),
      )).thenAnswer((_) async => Response(
          data: {'access_token': 'someToken'}, // Corrected key
          statusCode: 200,
          requestOptions: RequestOptions(path: postUrl)));

      when(mockDio.get(getUrl,
              queryParameters: queryParameters, options: anyNamed('options')))
          .thenAnswer((_) async => response);

      // Act

      final result = await cityRemoteDataSource.getCities(cityQuery: cityQuery);

      // Assert

      expect(result, isA<List<CityModel>>());
      expect(result, equals(tCityModels));
    });
    test('should throw an [Exception()]', () async {
      // Arrange
      when(mockDio.post(
        postUrl,
        options: anyNamed('options'),
        data: anyNamed('data'),
      )).thenAnswer((_) async => Response(
          data: {'access_token': 'someToken'}, // Corrected key
          statusCode: 200,
          requestOptions: RequestOptions(path: postUrl)));

      when(mockDio.get(getUrl,
              queryParameters: queryParameters, options: anyNamed('options')))
          .thenThrow(Exception());

      // Act
      final call = cityRemoteDataSource.getCities;

      // Assert

      expect(call(cityQuery: cityQuery), throwsException);
    });
  });
}
