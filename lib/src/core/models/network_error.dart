import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'network_error.g.dart';

@JsonSerializable()
class NetworkErrorModel extends Equatable {
  // city codes
  final int? code;
  final String? detail;

  //weather codes
  final int? cod;
  final String? message;

  const NetworkErrorModel({this.code, this.detail, this.cod, this.message});

  factory NetworkErrorModel.fromJson(Map<String, dynamic> json) {
    return _$NetworkErrorModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NetworkErrorModelToJson(this);
  @override
  List<Object?> get props => [code, detail];
}
