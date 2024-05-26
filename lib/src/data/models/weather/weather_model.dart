import 'package:doumo_test_task/src/data/data_sources/_mappers/entity_convertable.dart';
import 'package:doumo_test_task/src/domain/entities/weather/weather_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'weather_model.g.dart';

// keys to get relevant values from Weather Data Model for Weather Entity creation
const String weatherDescriptionKey = 'description';
const String temperatureKey = 'temp';

@JsonSerializable()
class WeatherModel with EntityConvertible<WeatherModel, WeatherEntity> {
  final Map<String, dynamic> weather;
  final Map<String, dynamic> main;

  WeatherModel({required this.weather, required this.main});

  @override
  WeatherEntity toEntity() {
    return WeatherEntity(
        weather: weather[weatherDescriptionKey],
        temperature: main[temperatureKey]);
  }
}
