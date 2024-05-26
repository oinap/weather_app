import 'package:flutter_dotenv/flutter_dotenv.dart';

class NetworkConstants {
  // weather network constants
  static final weatherBaseUrl = '${dotenv.env['WEATHER_BASE_URL']}';
  static final weatherApiKey = '${dotenv.env['WEATHER_API_KEY']}';

  // cities network constants
  static final citiesBaseUrl = '${dotenv.env['CITY_BASE_URL']}';
  static final citiesClientId = '${dotenv.env['CITY_CLIENT_ID']}';
  static final citiesClientSecret = '${dotenv.env['CITY_CLIENT_SECRET']}';
}
