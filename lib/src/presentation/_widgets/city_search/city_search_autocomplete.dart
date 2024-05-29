import 'package:doumo_test_task/src/core/constants/app_theme.dart';
import 'package:doumo_test_task/src/domain/entities/city/city_entity.dart';
import 'package:doumo_test_task/src/presentation/_widgets/city_search/overlay_entry_functions.dart';
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

  @override
  Widget build(BuildContext context) {
    // Initiate size variables
    final double textFieldWidth = MediaQuery.sizeOf(context).width / 1.5;

    RenderBox renderBox =
        _textFieldKey.currentContext!.findRenderObject() as RenderBox;
    double textFieldHeight = renderBox.size.height;

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
            if (state is CityLoaded && _textEditingController.text.isNotEmpty) {
              showOverlay(
                  context: context,
                  cities: state.cities,
                  borderWidth: 3,
                  overlayEntry: _overlayEntry,
                  textFieldHeight: textFieldHeight,
                  textFieldWidth: textFieldWidth,
                  layerLink: _layerLink,
                  textEditingController: _textEditingController);
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
                    'city_search', const Duration(milliseconds: 500), () {
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
