import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final int temperature;

  const WeatherEntity({required this.temperature});

  @override
  List<Object?> get props => [temperature];
}
