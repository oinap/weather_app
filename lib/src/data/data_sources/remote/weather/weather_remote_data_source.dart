import 'package:doumo_test_task/src/data/models/weather/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getWeather({required Map<String, double> geoCode});
}
