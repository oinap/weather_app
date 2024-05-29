import 'package:doumo_test_task/src/domain/entities/city/city_entity.dart';
import 'package:doumo_test_task/src/domain/usecases/city/city_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'city_state.dart';
part 'city_event.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final CityUsecases _cityUsecases;

  CityBloc(this._cityUsecases) : super(CityInitial()) {
    on<GetCityEvent>(_onGetCities);
  }

  Future<void> _onGetCities(GetCityEvent event, Emitter<CityState> emit) async {
    emit(CityLoading());

    final result = await _cityUsecases.getCities(cityQuery: event.cityQuery);

    result.fold((exception) {
      emit(CityError(message: exception.message));
    }, (cities) {
      emit(CityLoaded(cities: cities));
    });
  }
}
