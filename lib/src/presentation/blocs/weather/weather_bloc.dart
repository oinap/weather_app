import 'package:doumo_test_task/src/domain/entities/weather/weather_entity.dart';
import 'package:doumo_test_task/src/domain/usecases/weather/weather_usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'weather_state.dart';
part 'weather_event.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherUsecases _weatherUsecases;

  WeatherBloc(this._weatherUsecases) : super(WeatherInitial()) {
    on<GetWeatherEvent>(_onGetWeather);
  }

  Future<void> _onGetWeather(
      GetWeatherEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());

    final result = await _weatherUsecases.getWeather(geoCode: event.geoCode);

    result.fold((exception) {
      emit(WeatherError(message: exception.message));
    }, (weather) {
      emit(WeatherLoaded(weather: weather));
    });
  }
}
