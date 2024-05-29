import 'package:doumo_test_task/src/presentation/_widgets/error_display/error_snackbar.dart';
import 'package:doumo_test_task/src/presentation/blocs/city/city_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CityErrorListener extends StatelessWidget {
  const CityErrorListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CityBloc, CityState>(
      listener: (context, state) {
        if (state is CityError) {
          final SnackBar errorSnackBar = ErrorSnackbar(message: state.message);
          ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
        }
      },
    );
  }
}
