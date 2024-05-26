import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'city_network_error.g.dart';

@JsonSerializable()
class CityNetworkErrorModel extends Equatable {
  final int? code;
  final String? detail;

  const CityNetworkErrorModel({this.code, this.detail});

  factory CityNetworkErrorModel.fromJson(Map<String, dynamic> json) {
    return _$CityNetworkErrorModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CityNetworkErrorModelToJson(this);
  @override
  List<Object?> get props => [code, detail];
}
