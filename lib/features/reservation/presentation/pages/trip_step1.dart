import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_button.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_text_field.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/tab_selector.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/top_bar.dart';
import 'package:flysen_frontend_mobile/core/theme/theme.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/entities/flight_search_params.dart';
import 'package:flysen_frontend_mobile/features/reservation/presentation/bloc/flight/flight_bloc.dart';
import 'package:flysen_frontend_mobile/features/reservation/presentation/pages/trip_step2.dart';
import 'package:flysen_frontend_mobile/features/reservation/presentation/widgets/custom_counter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class TripStep1 extends StatefulWidget {
  @override
  State<TripStep1> createState() => _TripStep1State();
}

enum TripType { oneWay, roundTrip }

class _TripStep1State extends State<TripStep1> {
  TripType _selectedTripType = TripType.roundTrip;
  TextEditingController _departureLocationController = TextEditingController();
  TextEditingController _arrivalLocationController = TextEditingController();
  TextEditingController _departureDateController = TextEditingController();
  TextEditingController _arrivalDateController = TextEditingController();
  DateTime? _selectedDepartureDate;
  DateTime? _selectedArrivalDate;
  int adultCount = 1;
  int infantCount = 0;
  int childCount = 0;
  final DateFormat _apiDateFormat = DateFormat('yyyy-MM-dd');

  final DateFormat _displayDateFormat = DateFormat('dd/MM/yyyy');

  void incrementAdultCount() {
    // Wrap the change in setState
    setState(() {
      adultCount++;
    });
  }

  void decrementAdultCount() {
    // Wrap the change in setState
    setState(() {
      if (adultCount > 1) { // It's good practice to keep at least 1 adult
        adultCount--;
      }
    });
  }

  void incrementInfantCount() {
    setState(() {
      infantCount++;
    });
  }

  void decrementInfantCount() {
    setState(() {
      if (infantCount > 0) {
        infantCount--;
      }
    });
  }

  void incrementChildCount() {
    setState(() {
      childCount++;
    });
  }

  void decrementChildCount() {
    setState(() {
      if (childCount > 0) {
        childCount--;
      }
    });
  }

  void permuteLocation() {
    String temp = _departureLocationController.text;
    _departureLocationController.text = _arrivalLocationController.text;
    _arrivalLocationController.text = temp;
  }

  Future<void> _selectDepartureDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDepartureDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      cancelText: "Annuler",
      confirmText: "Valider",
      helpText: "Sélectionnez une date",
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary:
                  AppTheme.lightTheme.colorScheme.tertiary, // Header background
              onPrimary: Colors.white, // Header text
              onSurface: Colors.black, // Body text
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppTheme
                    .lightTheme.colorScheme.tertiary, // Button text color
              ),
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDepartureDate) {
      setState(() {
        _selectedDepartureDate = picked;
        // IMPORTANT: If the arrival date is now before the new departure date, clear it.
        if (_selectedArrivalDate != null &&
            _selectedArrivalDate!.isBefore(picked)) {
          _selectedArrivalDate = null;
          _arrivalDateController.text = ''; // Clear the text field too
        }
      });
    }
  }

  Future<void> _selectArrivalDate() async {
    // Use the departure date as the minimum selectable date.
    final firstSelectableDate = _selectedDepartureDate ?? DateTime.now();

    // Determine a valid initial date for the picker.
    DateTime validInitialDate = _selectedArrivalDate ?? firstSelectableDate;
    if (validInitialDate.isBefore(firstSelectableDate)) {
      validInitialDate = firstSelectableDate;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: validInitialDate,
      firstDate: firstSelectableDate,
      lastDate: DateTime(2101),
      cancelText: "Annuler",
      confirmText: "Valider",
      helpText: "Sélectionnez une date",
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary:
                  AppTheme.lightTheme.colorScheme.tertiary, // Header background
              onPrimary: Colors.white, // Header text
              onSurface: Colors.black, // Body text
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppTheme
                    .lightTheme.colorScheme.tertiary, // Button text color
              ),
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedArrivalDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Background image
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Voyager",
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 40),
                  Image.asset("assets/images/plane-1.png", fit: BoxFit.cover),
                ],
              ),
            ),
            Container(color: Colors.black.withOpacity(0.5)),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Type de vol:",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    SizedBox(height: 16.h),
                    TabSelector<TripType>(
                      // Provide the options as a map
                      options: const {
                        TripType.roundTrip: 'Aller-retour',
                        TripType.oneWay: 'Aller-simple',
                      },
                      // Set the initial selection
                      initialValue: _selectedTripType,
                      // Handle the change in selection
                      onSelectionChanged: (newSelection) {
                        setState(() {
                          _selectedTripType = newSelection;
                        });
                      },
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Lieu:",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextField(
                          width: MediaQuery.of(context).size.width / 2.7,
                          height: 60.h,
                          hintText: "Départ",
                          controller: _departureLocationController,
                        ),
                        GestureDetector(
                            onTap: () {
                              permuteLocation();
                            },
                            child: CircleAvatar(
                                radius: 16.h,
                                backgroundColor: Colors.black,
                                child: Center(
                                  child: Icon(
                                    Icons.swap_horiz,
                                    color: Colors.white,
                                  ),
                                ))),
                        CustomTextField(
                          width: MediaQuery.of(context).size.width / 2.7,
                          height: 60.h,
                          hintText: "Arrivée",
                          controller: _arrivalLocationController,
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Date:",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () async {
                            await _selectDepartureDate();
                            final departureDate = _selectedDepartureDate;
                            if (departureDate != null) {
                              setState(() {
                                _departureDateController.text = _displayDateFormat.format(departureDate);
                              });
                            }
                          },
                          child: CustomTextField(
                            width: _selectedTripType == TripType.roundTrip
                                ? MediaQuery.of(context).size.width / 2.25
                                : MediaQuery.of(context).size.width,
                            height: 60.h,
                            hintText: "Départ",
                            readOnly: true,
                            controller: _departureDateController,
                            enabled: false,
                          ),
                        ),
                        if (_selectedTripType == TripType.roundTrip)
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () async {
                              await _selectArrivalDate();
                              final arrivalDate = _selectedArrivalDate;
                              if (arrivalDate != null) {
                                setState(() {
                                  // Format the date for the user to see
                                  _arrivalDateController.text = _displayDateFormat.format(arrivalDate);
                                });
                              }
                            },
                            child: CustomTextField(
                              width: MediaQuery.of(context).size.width / 2.25,
                              height: 60.h,
                              hintText: "Arrivée",
                              controller: _arrivalDateController,
                              readOnly: true,
                              enabled: false,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Passagers:",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Adulte(s) [12 ans et +]",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        CustomCounter(
                            increment: incrementAdultCount,
                            decrement: decrementAdultCount,
                            label: adultCount),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Enfant(s) [2 et 11 ans]",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        CustomCounter(
                            increment: incrementChildCount,
                            decrement: decrementChildCount,
                            label: childCount),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Bébé(s) [moins de 2 ans]",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        CustomCounter(
                            increment: incrementInfantCount,
                            decrement: decrementInfantCount,
                            label: infantCount),
                      ],
                    ),
                    SizedBox(height: 32.h),
                    CustomButton(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      text: "Voir offre",
                      onPressed: () {
                        List<Traveler> travelers = [];
                        int travelerId = 1;
                        for (int i = 0; i < adultCount; i++) {
                          travelers.add(Traveler(id: travelerId.toString(), travelerType: 'ADULT'));
                          travelerId++;
                        }
                        for (int i = 0; i < childCount; i++) {
                          travelers.add(Traveler(id: travelerId.toString(), travelerType: 'CHILD'));
                          travelerId++;
                        }
                        for (int i = 0; i < infantCount; i++) {
                          travelers.add(Traveler(id: travelerId.toString(), travelerType: 'INFANT'));
                          travelerId++;
                        }

                        FlightSearchParams params = FlightSearchParams(
                          currencyCode: 'XOF',
                          originDestinations: [],
                          travelers: travelers,
                          sources: const ['GDS'],
                          searchCriteria: const SearchCriteria(maxFlightOffers: 20),
                        );

                        final originLocationCode = _departureLocationController.text.trim().toUpperCase();
                        final destinationLocationCode = _arrivalLocationController.text.trim().toUpperCase();

                        // Departure flight
                        params.originDestinations.add(OriginDestination(
                          id: '1',
                          originLocationCode: originLocationCode,
                          destinationLocationCode: destinationLocationCode,
                          departureDateTimeRange: DepartureDateTimeRange(date: _selectedDepartureDate != null
                              ? _apiDateFormat.format(_selectedDepartureDate!)
                              : '',),
                        ));

                        // Return flight, if round trip
                        if(_selectedTripType == TripType.roundTrip){
                          params.originDestinations.add(OriginDestination(
                            id: '2',
                            originLocationCode: destinationLocationCode,
                            destinationLocationCode: originLocationCode,
                            departureDateTimeRange: DepartureDateTimeRange(date: _selectedArrivalDate != null
                                ? _apiDateFormat.format(_selectedArrivalDate!)
                                : ''),
                          ));
                        }
                        context.read<FlightBloc>().add(SearchFlights(params));
                      },
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 0,
              right: 0,
              child: TopBar(showBack: true),
            ),
          ],
        ),
      ),
    );
  }
}
