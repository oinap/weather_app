part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

class GetWeatherEvent extends WeatherEvent {
  final Map<String, double> geoCode;

  const GetWeatherEvent({required this.geoCode});

  @override
  List<Object?> get props => [geoCode];
}
