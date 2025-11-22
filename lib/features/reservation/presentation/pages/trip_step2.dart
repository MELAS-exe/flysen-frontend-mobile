import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flysen_frontend_mobile/app/router/app_router.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/tab_selector.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/top_bar.dart';
import 'package:flysen_frontend_mobile/core/utils/dimensions.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/entities/flight_offer.dart';
import 'package:flysen_frontend_mobile/features/reservation/presentation/bloc/flight/flight_bloc.dart';
import 'package:flysen_frontend_mobile/features/reservation/presentation/widgets/destination_element.dart';
import 'package:go_router/go_router.dart';

class TripStep2 extends StatefulWidget {
  const TripStep2({super.key});

  @override
  State<TripStep2> createState() => _TripStep2State();
}

enum FilterType { price, time, noStops }

class _TripStep2State extends State<TripStep2> {
  String? _selectedFlightOfferId;
  FilterType _selectedFilter = FilterType.price;

  List<FlightOffer> _originalOffers = [];
  List<FlightOffer> _displayOffers = [];

  // Store the IDs of the cheapest and fastest offers
  String? _cheapestOfferId;
  String? _fastestOfferId;

  @override
  void initState() {
    super.initState();
    final state = context.read<FlightBloc>().state;
    if (state is FlightLoaded) {
      _updateAndSortOffers(state.flightOffers);
    }
  }

  /// Helper function to convert ISO 8601 duration string to a comparable Duration object.
  Duration _parseDuration(String isoString) {
    if (!isoString.startsWith('PT')) return Duration.zero;
    String temp = isoString.substring(2);
    int hours = 0;
    int minutes = 0;

    if (temp.contains('H')) {
      final parts = temp.split('H');
      hours = int.tryParse(parts[0]) ?? 0;
      temp = parts.length > 1 ? parts[1] : '';
    }
    if (temp.contains('M')) {
      final parts = temp.split('M');
      minutes = int.tryParse(parts[0]) ?? 0;
    }
    return Duration(hours: hours, minutes: minutes);
  }

  /// Compares two ISO duration strings.
  int _compareDuration(String a, String b) {
    return _parseDuration(a).compareTo(_parseDuration(b));
  }

  /// Central function to update all lists and determine cheapest/fastest.
  void _updateAndSortOffers(List<FlightOffer> newOffers) {
    _originalOffers = newOffers;

    if (_originalOffers.isNotEmpty) {
      // Find cheapest offer
      final cheapestList = List<FlightOffer>.from(_originalOffers)
        ..sort((a, b) => double.parse(a.price.total).compareTo(double.parse(b.price.total)));
      _cheapestOfferId = cheapestList.first.id;

      // Find fastest offer
      final fastestList = List<FlightOffer>.from(_originalOffers)
        ..sort((a, b) => _compareDuration(a.itineraries.first.duration!, b.itineraries.first.duration!));
      _fastestOfferId = fastestList.first.id;
    } else {
      _cheapestOfferId = null;
      _fastestOfferId = null;
    }

    _applyDisplayFilter();
  }

  /// Sorts and filters the original list of offers based on the `_selectedFilter`.
  void _applyDisplayFilter() {
    _displayOffers = List<FlightOffer>.from(_originalOffers);

    switch (_selectedFilter) {
      case FilterType.price:
        _displayOffers.sort((a, b) =>
            double.parse(a.price.total).compareTo(double.parse(b.price.total)));
        break;
      case FilterType.time:
        _displayOffers.sort((a, b) => _compareDuration(
            a.itineraries.first.duration!, b.itineraries.first.duration!));
        break;
      case FilterType.noStops:
        _displayOffers.retainWhere((offer) {
          return offer.itineraries.first.segments.length == 1;
        });
        _displayOffers.sort((a, b) =>
            double.parse(a.price.total).compareTo(double.parse(b.price.total)));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        showBack: true,
        title: "Dakar vers Paris",
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: Dimension.aroundPadding,
              child: TabSelector<FilterType>(
                options: const {
                  FilterType.price: "Prix",
                  FilterType.time: "Durée",
                  FilterType.noStops: "Direct",
                },
                initialValue: _selectedFilter,
                onSelectionChanged: (newFilter) {
                  setState(() {
                    _selectedFilter = newFilter;
                    _applyDisplayFilter();
                  });
                },
              ),
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: BlocConsumer<FlightBloc, FlightState>(
                listener: (context, state) {
                  if (state is FlightLoaded) {
                    setState(() {
                      _updateAndSortOffers(state.flightOffers);
                    });
                  }
                },
                builder: (context, state) {
                  if (state is FlightLoading && _originalOffers.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is FlightError) {
                    return Center(child: Text('Erreur: ${state.message}'));
                  }

                  if (_displayOffers.isEmpty) {
                    if (state is FlightLoaded) {
                      return const Center(child: Text('Aucun vol correspondant à vos critères.'));
                    }
                    return const Center(child: Text('Commencez une recherche de vol.'));
                  }

                  final carrierNames =
                  (state is FlightLoaded) ? state.carrierNames : <String, String>{};

                  return ListView.separated(
                    padding: Dimension.aroundPadding,
                    itemCount: _displayOffers.length,
                    itemBuilder: (context, index) {
                      final flightOffer = _displayOffers[index];
                      return DestinationElement(
                        flightOffer: flightOffer,
                        carrierNames: carrierNames,
                        // Check if the current offer's ID matches the stored cheapest/fastest IDs
                        isCheapest: flightOffer.id == _cheapestOfferId,
                        isFastest: flightOffer.id == _fastestOfferId,
                        onTap: () {
                          // Navigate to TripStep3 and pass the selected flight offer
                          context.pushNamed(
                            AppRouter.tripStep3,
                            extra: flightOffer,
                          );
                        },
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 10.h),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}