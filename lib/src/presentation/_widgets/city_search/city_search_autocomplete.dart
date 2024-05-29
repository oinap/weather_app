import 'package:doumo_test_task/src/core/constants/app_theme.dart';
import 'package:doumo_test_task/src/domain/entities/city/city_entity.dart';
import 'package:doumo_test_task/src/presentation/blocs/weather/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doumo_test_task/src/presentation/blocs/city/city_bloc.dart';
import 'package:easy_debounce/easy_debounce.dart';

class CitySearchAutocomplete extends StatefulWidget {
  const CitySearchAutocomplete({super.key});

  @override
  State<CitySearchAutocomplete> createState() => _CitySearchAutocompleteState();
}

class _CitySearchAutocompleteState extends State<CitySearchAutocomplete> {
  // Layer link to  position overlay entry (suggestions) below the
  // search text field
  final LayerLink _layerLink = LayerLink();

  // Overlay entry is the suggestions pop up
  OverlayEntry? _overlayEntry;

  // Textfield needs a global key so that the overlay entry can extract
  // the textfield's height for proper vertical offset
  final GlobalKey _textFieldKey = GlobalKey();

// TextEditingController is needed to show the chosen autocomplete option
// in the textfield

  final TextEditingController _textEditingController = TextEditingController();
  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

// This function includes configurations for the overlay entry
// and the listviewbuilder child that display the options

  OverlayEntry _createOverlayEntry(List<CityEntity> cities,
      double verticalOffset, double targetWidth, double borderWidth) {
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          width: targetWidth,
          // This allows for position below the textfield
          child: CompositedTransformFollower(
            link: _layerLink,
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
                        _textEditingController.text = cities[index].name;
                        _overlayEntry?.remove();
                        _overlayEntry = null;
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

// This function serves as an intermediate layer to prepare
// Arguments for the overlay. The function is to be called everytime that the
// Cities are fetched
  void _showOverlay(
      BuildContext context, List<CityEntity> cities, double borderWidth) {
// Previous overlay needs to be removed to replay the new options
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
    }

// Textfield dimensions are retrieved and used to create the overlay
    if (context.mounted) {
      RenderBox renderBox =
          _textFieldKey.currentContext!.findRenderObject() as RenderBox;
      double textFieldHeight = renderBox.size.height;
      double textFieldWidth = renderBox.size.width;

      _overlayEntry = _createOverlayEntry(
          cities, textFieldHeight, textFieldWidth, borderWidth);
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  @override
  Widget build(BuildContext context) {
    // initiate size variables
    final double textFieldWidth = MediaQuery.sizeOf(context).width / 1.5;

    return Container(
      width: textFieldWidth,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(width: 3),
        borderRadius: BorderRadius.circular(10),
      ),
      // Set the textfield as target for CompositedTransform
      // to allow positioning of the overlay entry
      child: CompositedTransformTarget(
        link: _layerLink,
        child: BlocListener<CityBloc, CityState>(
          listener: (context, state) {
            if (state is CityLoaded &&
                _textEditingController.text.length >= 3) {
              _showOverlay(context, state.cities, 3);
            }
          },
          child: TextField(
            controller: _textEditingController,
            key: _textFieldKey,
            decoration: const InputDecoration(
                border: InputBorder.none,
                suffixIcon: Icon(Icons.search),
                prefixIcon: Icon(Icons.location_city)),
            onChanged: (value) {
              // The Amadeus city search API will send back a bad response
              // if the keyword is less than 3 characters
              if (value.length >= 3) {
                // Debouncer is necessary to synchronise overlay entry options
                // and the asynchronous network call

                EasyDebounce.debounce(
                    'city_search', const Duration(milliseconds: 390), () {
                  context.read<CityBloc>().add(GetCityEvent(cityQuery: value));
                });
              } else {
                _overlayEntry?.remove();
                _overlayEntry = null;
              }
            },
          ),
        ),
      ),
    );
  }
}
