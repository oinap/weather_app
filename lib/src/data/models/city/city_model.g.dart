// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityModel _$CityModelFromJson(Map<String, dynamic> json) => CityModel(
      type: json['type'] as String?,
      subType: json['subType'] as String?,
      name: json['name'] as String?,
      iataCode: json['iataCode'] as String?,
      address: (json['address'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      geoCode: (json['geoCode'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
    );

Map<String, dynamic> _$CityModelToJson(CityModel instance) => <String, dynamic>{
      'type': instance.type,
      'subType': instance.subType,
      'name': instance.name,
      'iataCode': instance.iataCode,
      'address': instance.address,
      'geoCode': instance.geoCode,
    };
