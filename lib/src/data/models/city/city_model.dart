import 'package:doumo_test_task/src/data/data_sources/_mappers/entity_convertable.dart';
import 'package:doumo_test_task/src/domain/entities/city/city_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'city_model.g.dart';

@JsonSerializable()
class CityModel extends Equatable
    with EntityConvertible<CityModel, CityEntity> {
  final String? type;
  final String? subType;
  final String name;
  final String? iataCode;
  final Map<String, String>? address;
  final Map<String, double> geoCode;

  const CityModel(
      {this.type,
      this.subType,
      required this.name,
      this.iataCode,
      this.address,
      required this.geoCode});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return _$CityModelFromJson(json);
  }
  @override
  List<Object?> get props => [type, subType, name, iataCode, address, geoCode];

  @override
  CityEntity toEntity() {
    return CityEntity(name: name, geoCode: geoCode);
  }
}
