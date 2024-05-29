import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doumo_test_task/src/presentation/blocs/city/city_bloc.dart';
import 'package:doumo_test_task/src/domain/entities/city/city_entity.dart';
import 'package:doumo_test_task/src/presentation/blocs/weather/weather_bloc.dart';

// This function serves as an intermediate layer to prepare
// Arguments for the overlay. The function is to be called everytime that the
// Cities are fetched
void showOverlay(
    {required BuildContext context,
    required List<CityEntity> cities,
    required double borderWidth,
    required OverlayEntry? overlayEntry,
    required double textFieldHeight,
    required double textFieldWidth,
    required LayerLink layerLink,
    required TextEditingController textEditingController}) {
// Previous overlay needs to be removed to replay the new options
  if (overlayEntry != null) {
    overlayEntry.remove();
  }

// Textfield dimensions are retrieved and used to create the overlay
  if (context.mounted) {
    final double verticalOffset = textFieldHeight * 1.2;

    overlayEntry = _createOverlayEntry(
        cities: cities,
        verticalOffset: verticalOffset,
        targetWidth: textFieldWidth,
        borderWidth: borderWidth,
        layerLink: layerLink,
        overlayEntry: overlayEntry,
        textEditingController: textEditingController);
    Overlay.of(context).insert(overlayEntry);
  }
}

// This function includes configurations for the overlay entry
// and the listviewbuilder child that display the options
OverlayEntry _createOverlayEntry(
    {required List<CityEntity> cities,
    required double verticalOffset,
    required double targetWidth,
    required double borderWidth,
    required LayerLink layerLink,
    required TextEditingController textEditingController,
    required OverlayEntry? overlayEntry}) {
  return OverlayEntry(
    builder: (context) {
      return Positioned(
        width: targetWidth,
        // This allows for position below the textfield
        child: CompositedTransformFollower(
          link: layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, verticalOffset * 1.2),
          child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: borderWidth)),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: cities.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    splashColor: Colors.blue,
                    onTap: () {
                      // Fetch weather of the chosen city using
                      // the coordinates from geoCode

                      final geoCode = cities[index].geoCode;
                      context
                          .read<WeatherBloc>()
                          .add(GetWeatherEvent(geoCode: geoCode));

                      // Put the chosen name in the textfield
                      // and remove the overlay
                      textEditingController.text = cities[index].name;
                      overlayEntry?.remove();
                      overlayEntry = null;
                    },
                    child: ListTile(
                      title: Text(
                        cities[index].name,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
    },
  );
}
