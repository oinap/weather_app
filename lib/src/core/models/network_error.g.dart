// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkErrorModel _$NetworkErrorModelFromJson(Map<String, dynamic> json) =>
    NetworkErrorModel(
      code: (json['code'] as num?)?.toInt(),
      detail: json['detail'] as String?,
      cod: (json['cod'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$NetworkErrorModelToJson(NetworkErrorModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'detail': instance.detail,
      'cod': instance.cod,
      'message': instance.message,
    };
