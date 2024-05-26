import 'package:doumo_test_task/src/data/data_sources/remote/city/cities_remote_data_source_impl.dart';
import 'package:doumo_test_task/src/data/models/city/city_model.dart';
import 'package:flutter/material.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FloatingActionButton(
              child: const Text('data'),
              onPressed: () async {
                var dataSource = CitiesRemoteDataSourceImpl();
                List<CityModel> cities = await dataSource.getCities('Pa');
                print(cities);
              }),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
