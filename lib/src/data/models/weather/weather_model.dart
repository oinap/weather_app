import 'package:doumo_test_task/src/data/data_sources/_mappers/entity_convertable.dart';
import 'package:doumo_test_task/src/domain/entities/weather/weather_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'weather_model.g.dart';

// keys to get relevant values from Weather Data Model for Weather Entity creation
const String weatherDescriptionKey = 'description';
const String temperatureKey = 'temp';

@JsonSerializable()
class WeatherModel extends Equatable
    with EntityConvertible<WeatherModel, WeatherEntity> {
  final Map<String, dynamic> main;

  const WeatherModel({required this.main});

  @override
  WeatherEntity toEntity() {
    return WeatherEntity(temperature: main[temperatureKey]);
  }

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return _$WeatherModelFromJson(json);
  }

  @override
  List<Object?> get props => [main];
}
