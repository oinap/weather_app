import 'package:equatable/equatable.dart';

class CityEntity extends Equatable {
  final String name;
  final Map<String, double> geoCode;

  const CityEntity({required this.name, required this.geoCode});

  @override
  List<Object?> get props => [name, geoCode];
}
