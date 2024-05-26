// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_network_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityNetworkErrorModel _$CityNetworkErrorModelFromJson(
        Map<String, dynamic> json) =>
    CityNetworkErrorModel(
      code: (json['code'] as num?)?.toInt(),
      detail: json['detail'] as String?,
    );

Map<String, dynamic> _$CityNetworkErrorModelToJson(
        CityNetworkErrorModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'detail': instance.detail,
    };
