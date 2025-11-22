import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flysen_frontend_mobile/app/router/app_router.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_button.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_text_field.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/tab_selector.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/top_bar.dart';
import 'package:flysen_frontend_mobile/core/theme/theme.dart';
import 'package:flysen_frontend_mobile/core/utils/dimensions.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/entities/flight_search_params.dart';
import 'package:flysen_frontend_mobile/features/reservation/presentation/bloc/flight/flight_bloc.dart';
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
    setState(() {
      adultCount++;
    });
  }

  void decrementAdultCount() {
    setState(() {
      if (adultCount > 1) {
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
        if (_selectedArrivalDate != null &&
            _selectedArrivalDate!.isBefore(picked)) {
          _selectedArrivalDate = null;
          _arrivalDateController.text = '';
        }
      });
    }
  }

  Future<void> _selectArrivalDate() async {
    final firstSelectableDate = _selectedDepartureDate ?? DateTime.now();
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
              primary: AppTheme.lightTheme.colorScheme.tertiary,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppTheme.lightTheme.colorScheme.tertiary,
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
    return BlocListener<FlightBloc, FlightState>(
      listener: (context, state) {
        if (state is FlightLoaded) {
          // When data is loaded, navigate to the next page
          // Using GoRouter's push will add the new page onto the stack
          context.pushNamed(AppRouter.tripStep2);
        } else if (state is FlightError) {
          // If there's an error, show a snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: TopBar(showBack: true,),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.w),
              child: SizedBox(
                height: MediaQuery.of(context).size.height/1.2,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Type de vol:",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    SizedBox(height: 16.h),
                    TabSelector<TripType>(
                      options: const {
                        TripType.roundTrip: 'Aller-retour',
                        TripType.oneWay: 'Aller-simple',
                      },
                      initialValue: _selectedTripType,
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomTextField(
                          width: MediaQuery.of(context).size.width / 2.7,
                          height: 56.h,
                          hintText: "Départ",
                          controller: _departureLocationController,
                        ),
                        GestureDetector(
                            onTap: () {
                              permuteLocation();
                            },
                            child: CircleAvatar(
                                radius: 16.r,
                                backgroundColor: Colors.black,
                                child: Center(
                                  child: Icon(
                                    Icons.swap_horiz,
                                    color: Colors.white,
                                  ),
                                ))),
                        CustomTextField(
                          width: MediaQuery.of(context).size.width / 2.7,
                          height: 56.h,
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
                                _departureDateController.text =
                                    _displayDateFormat
                                        .format(departureDate);
                              });
                            }
                          },
                          child: CustomTextField(
                            width: _selectedTripType == TripType.roundTrip
                                ? MediaQuery.of(context).size.width / 2.25
                                : MediaQuery.of(context).size.width / 1.1,
                            height: 56.h,
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
                                  _arrivalDateController.text =
                                      _displayDateFormat
                                          .format(arrivalDate);
                                });
                              }
                            },
                            child: CustomTextField(
                              width:
                                  MediaQuery.of(context).size.width / 2.25,
                              height: 56.h,
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
                    SizedBox(height: 32.h,),
                    BlocBuilder<FlightBloc, FlightState>(
                      builder: (context, state) {
                        // Show loading indicator inside the button when loading
                        if (state is FlightLoading) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              CustomButton(
                                width: MediaQuery.of(context).size.width,
                                height: 48.h,
                                text: "",
                                onPressed: () {},
                              ),
                              Center(
                                  child: CircularProgressIndicator(
                                color: Colors.white,
                              ))
                            ],
                          );
                        }
                        // Default button state
                        return CustomButton(
                          width: MediaQuery.of(context).size.width,
                          height: 48.h,
                          text: "Voir les offres",
                          onPressed: () {
                            List<Traveler> travelers = [];
                            int travelerId = 1;
                            for (int i = 0; i < adultCount; i++) {
                              travelers.add(Traveler(
                                  id: travelerId.toString(),
                                  travelerType: 'ADULT'));
                              travelerId++;
                            }
                            for (int i = 0; i < childCount; i++) {
                              travelers.add(Traveler(
                                  id: travelerId.toString(),
                                  travelerType: 'CHILD'));
                              travelerId++;
                            }
                            for (int i = 0; i < infantCount; i++) {
                              travelers.add(Traveler(
                                  id: travelerId.toString(),
                                  travelerType: 'INFANT'));
                              travelerId++;
                            }

                            final originLocationCode =
                            _departureLocationController.text
                                .trim()
                                .toUpperCase();
                            final destinationLocationCode =
                            _arrivalLocationController.text
                                .trim()
                                .toUpperCase();

                            // Create the map of IATA codes to user-friendly names
                            final Map<String, String> friendlyLocationNames = {
                              originLocationCode: _departureLocationController.text.trim(),
                              destinationLocationCode: _arrivalLocationController.text.trim(),
                            };

                            FlightSearchParams params = FlightSearchParams(
                              currencyCode: 'XOF',
                              originDestinations: [],
                              travelers: travelers,
                              sources: const ['GDS'],
                              searchCriteria:
                              const SearchCriteria(maxFlightOffers: 20),
                            );

                            params.originDestinations.add(OriginDestination(
                              id: '1',
                              originLocationCode: originLocationCode,
                              destinationLocationCode:
                              destinationLocationCode,
                              departureDateTimeRange:
                              DepartureDateTimeRange(
                                  date: _selectedDepartureDate != null
                                      ? _apiDateFormat.format(
                                      _selectedDepartureDate!)
                                      : ''),
                            ));

                            if (_selectedTripType == TripType.roundTrip) {
                              params.originDestinations
                                  .add(OriginDestination(
                                id: '2',
                                originLocationCode: destinationLocationCode,
                                destinationLocationCode: originLocationCode,
                                departureDateTimeRange:
                                DepartureDateTimeRange(
                                    date: _selectedArrivalDate != null
                                        ? _apiDateFormat.format(
                                        _selectedArrivalDate!)
                                        : ''),
                              ));
                            }

                            // Dispatch the event with both the params and the friendly names map
                            context
                                .read<FlightBloc>()
                                .add(SearchFlights(params, friendlyLocationNames));
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
