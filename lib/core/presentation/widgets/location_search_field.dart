import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_text_field.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/entities/location_entity.dart';
import 'package:flysen_frontend_mobile/features/reservation/presentation/bloc/location_search/location_search_bloc.dart';
import 'package:flysen_frontend_mobile/injector.dart';

class LocationSearchField extends StatefulWidget {
  const LocationSearchField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.onLocationSelected,
  });

  final String hintText;
  final TextEditingController controller;
  final ValueChanged<LocationEntity> onLocationSelected;

  @override
  State<LocationSearchField> createState() => _LocationSearchFieldState();
}

class _LocationSearchFieldState extends State<LocationSearchField> {
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  // This BLoC will be created and owned by this widget instance.
  late final LocationSearchBloc _locationSearchBloc;

  @override
  void initState() {
    super.initState();
    // Fetch a new instance of the BLoC from get_it.
    _locationSearchBloc = getIt<LocationSearchBloc>();

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _showOverlay();
      } else {
        if (widget.controller.text.isNotEmpty) {
          _locationSearchBloc.add(FetchAndSelectFirst(
            keyword: widget.controller.text,
            subType: 'CITY', // or 'AIRPORT'
          ));
        }
        _hideOverlay();
      }
    });
  }

  @override
  void dispose() {
    // First, ensure the overlay is removed from the screen if it's visible.
    _hideOverlay();

    // Now, it's safe to dispose the other controllers.
    _focusNode.dispose();
    _locationSearchBloc.close();
    super.dispose();
  }

  void _showOverlay() {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width / 2.7,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, 60.h),
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(8.r),
            // Use BlocProvider.value to provide this widget's BLoC instance to the overlay.
            child: BlocProvider.value(
              value: _locationSearchBloc,
              child: BlocBuilder<LocationSearchBloc, LocationSearchState>(
                builder: (context, state) {
                  if (state is LocationSearchLoading) {
                    return const Center(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ));
                  }
                  if (state is LocationSearchError) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(state.message,
                          style: const TextStyle(color: Colors.red)),
                    );
                  }
                  if (state is LocationSearchLoaded) {
                    return ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 200.h),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: state.locations.length,
                        itemBuilder: (context, index) {
                          final location = state.locations[index];
                          return ListTile(
                            title: Text(location.name),
                            subtitle: Text(location.iataCode),
                            onTap: () {
                              widget.onLocationSelected(location);
                              _focusNode.unfocus();
                            },
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    // We wrap with BlocProvider.value to make the BLoC available to the listener.
    return BlocProvider.value(
      value: _locationSearchBloc,
      child: BlocListener<LocationSearchBloc, LocationSearchState>(
        listener: (context, state) {
          if (state is LocationAutoSelected) {
            widget.onLocationSelected(state.location);
            _locationSearchBloc.add(ClearSearch());
          }
        },
        child: CompositedTransformTarget(
          link: _layerLink,
          child: CustomTextField(
            width: MediaQuery.of(context).size.width / 2.7,
            height: 56.h,
            hintText: widget.hintText,
            controller: widget.controller,
            focusNode: _focusNode,
            onChanged: (value) {
              if (value.isNotEmpty) {
                _locationSearchBloc
                    .add(KeywordChanged(keyword: value, subType: 'CITY'));
              } else {
                _locationSearchBloc.add(ClearSearch());
              }
            },
          ),
        ),
      ),
    );
  }
}
