import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_button.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/top_bar.dart';
import 'package:flysen_frontend_mobile/core/theme/theme.dart';
import 'package:flysen_frontend_mobile/core/utils/dimensions.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/entities/flight_offer.dart';
import 'package:flysen_frontend_mobile/features/reservation/presentation/bloc/flight/flight_bloc.dart';
import 'package:intl/intl.dart';

class TripStep3 extends StatelessWidget {
  final FlightOffer flightOffer;

  const TripStep3({super.key, required this.flightOffer});

  // Helper to format ISO 8601 duration string (e.g., "PT2H0M")
  String _formatDuration(String isoDuration) {
    if (!isoDuration.startsWith('PT')) return isoDuration;
    String temp = isoDuration.substring(2);
    String hours = '0';
    String minutes = '0';
    if (temp.contains('H')) {
      var parts = temp.split('H');
      hours = parts[0];
      temp = parts.length > 1 ? parts[1] : '';
    }
    if (temp.contains('M')) {
      minutes = temp.split('M')[0];
    }
    return "${hours}h ${minutes}m";
  }

  // Helper to get an icon for a specific amenity type
  Image _getAmenityIcon(String? amenityType) {
    switch (amenityType) {
      case 'BAGGAGE':
        return Image.asset("assets/icons/carry-on-bag.png", width: 24.r);
      case 'MEAL':
        return Image.asset("assets/icons/food.png", width: 24.r);
      case 'SEAT':
      case 'PRE_RESERVED_SEAT':
        return Image.asset("assets/icons/flight-seat.png", width: 24.r);
      case 'WIFI':
      case 'TRAVEL_SERVICES':
        return Image.asset("assets/icons/wifi.png", width: 24.r);
        ;
      default:
        return Image.asset("assets/icons/done.png", width: 24.r);
    }
  }

  @override
  Widget build(BuildContext context) {
    final flightState = context.read<FlightBloc>().state;
    final Map<String, String> carrierNames =
        (flightState is FlightLoaded) ? flightState.carrierNames : {};
    final Map<String, String> locationNames =
        (flightState is FlightLoaded) ? flightState.locationNames : {};

    // --- Prepare data for the first (outbound) itinerary ---
    final outboundItinerary = flightOffer.itineraries.first;
    final outboundFirstSegment = outboundItinerary.segments.first;
    final outboundLastSegment = outboundItinerary.segments.last;
    final outboundDepartureTime = DateFormat.Hm()
        .format(DateTime.parse(outboundFirstSegment.departure.at));
    final outboundArrivalTime =
        DateFormat.Hm().format(DateTime.parse(outboundLastSegment.arrival.at));

    // --- Prepare data for the second (return) itinerary, if it exists ---
    final isRoundTrip = flightOffer.itineraries.length > 1;
    Itinerary? returnItinerary;
    Segment? returnFirstSegment;
    Segment? returnLastSegment;
    String? returnDepartureTime;
    String? returnArrivalTime;

    if (isRoundTrip) {
      returnItinerary = flightOffer.itineraries[1];
      returnFirstSegment = returnItinerary.segments.first;
      returnLastSegment = returnItinerary.segments.last;
      returnDepartureTime = DateFormat.Hm()
          .format(DateTime.parse(returnFirstSegment.departure.at));
      returnArrivalTime =
          DateFormat.Hm().format(DateTime.parse(returnLastSegment.arrival.at));
    }

    // --- Prepare data for the inclusions/amenities section ---
    // We will show the amenities for the first traveler as a representative example.
    final firstTravelerPricing = flightOffer.travelerPricings.first;
    final firstFareDetails = firstTravelerPricing.fareDetailsBySegment.first;
    final amenities = firstFareDetails.amenities;

    return Scaffold(
      appBar: TopBar(
        showBack: true,
        title: "Détails du vol",
      ),
      bottomSheet: Container(
        padding: Dimension.aroundPadding,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
              ),
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r))),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          RichText(
              text: TextSpan(
                  text: "Prix total: ",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.black),
                  children: [
                TextSpan(
                    text: "${flightOffer.price.grandTotal} Fcfa",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.tertiary,
                        fontWeight: FontWeight.bold))
              ])),
          SizedBox(
            height: 2.h,
          ),
          Text("Prix par passager: ${flightOffer.price.base} Fcfa",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.grey)),
          SizedBox(
            height: 2.h,
          ),
          Text("Frais et taxes inclus",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.grey)),
          SizedBox(height: 16.h),
          CustomButton(
              width: 1.sw,
              height: 48.h,
              text: "Acheter le billet",
              onPressed: () {}),
          SizedBox(height: 16.h),
        ]),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: Dimension.aroundPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // region Outbound Flight Section
              SizedBox(
                height: 16.h,
              ),
              Text(
                  "Aller: ${locationNames[outboundFirstSegment.departure.iataCode] ?? outboundFirstSegment.departure.iataCode} vers ${locationNames[outboundLastSegment.arrival.iataCode] ?? outboundLastSegment.arrival.iataCode}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
              SizedBox(
                height: 16.h,
              ),
              Row(children: [
                Column(
                  children: [
                    Image.asset("assets/icons/plane-take-off.png", width: 24.r),
                    SizedBox(height: 2.h),
                    Container(
                      width: 1.w,
                      height: 100.h,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 2.h),
                    Image.asset("assets/icons/plane-land.png", width: 24.r),
                  ],
                ),
                SizedBox(
                  width: 8.w,
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "$outboundDepartureTime - ${outboundFirstSegment.departure.iataCode}",
                              style: Theme.of(context).textTheme.bodySmall),
                          SizedBox(height: 1.w),
                          Text(
                              locationNames[outboundFirstSegment
                                      .departure.iataCode] ??
                                  outboundFirstSegment.departure.iataCode,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.grey)),
                        ],
                      ),
                      SizedBox(height: 80.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "$outboundArrivalTime - ${outboundLastSegment.arrival.iataCode}",
                              style: Theme.of(context).textTheme.bodySmall),
                          SizedBox(height: 1.w),
                          Text(
                              locationNames[
                                      outboundLastSegment.arrival.iataCode] ??
                                  outboundLastSegment.arrival.iataCode,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
              SizedBox(
                height: 16.h,
              ),
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
              SizedBox(
                height: 16.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Vol",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.grey)),
                      SizedBox(height: 2.w),
                      Text(
                          "${outboundFirstSegment.carrierCode} ${outboundFirstSegment.number}",
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                  SizedBox(
                    width: 0.5.sw,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Durée",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.grey)),
                        SizedBox(height: 2.w),
                        Text(_formatDuration(outboundItinerary.duration!),
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Compagnie",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.grey)),
                      SizedBox(
                        height: 2.w,
                      ),
                      Row(
                        children: [
                          Image.asset(
                              "assets/images/Square/${outboundFirstSegment.carrierCode}.png",
                              errorBuilder: (context, error, stackTrace) {
                            return Image.asset("assets/icons/app-logo.png",
                                width: 24.r);
                          }, width: 24.r),
                          SizedBox(width: 8.w),
                          Text(
                              carrierNames[outboundFirstSegment.carrierCode] ??
                                  outboundFirstSegment.carrierCode,
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 0.5.sw,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Avion",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.grey)),
                        SizedBox(height: 2.w),
                        Text(outboundFirstSegment.aircraft.code,
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ),
                ],
              ),
              // endregion

              // region Return Flight Section (Conditional)
              if (isRoundTrip &&
                  returnItinerary != null &&
                  returnFirstSegment != null &&
                  returnLastSegment != null) ...[
                SizedBox(
                  height: 32.h,
                ),
                Text(
                    "Retour: ${locationNames[returnFirstSegment.departure.iataCode] ?? returnFirstSegment.departure.iataCode} vers ${locationNames[returnLastSegment.arrival.iataCode] ?? returnLastSegment.arrival.iataCode}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 16.h,
                ),
                Row(children: [
                  Column(
                    children: [
                      Image.asset("assets/icons/plane-take-off.png",
                          width: 24.r),
                      SizedBox(height: 2.h),
                      Container(
                        width: 1.w,
                        height: 100.h,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 2.h),
                      Image.asset("assets/icons/plane-land.png", width: 24.r),
                    ],
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "$returnDepartureTime - ${returnFirstSegment.departure.iataCode}",
                                style: Theme.of(context).textTheme.bodySmall),
                            SizedBox(
                              height: 1.w,
                            ),
                            Text(
                                locationNames[returnFirstSegment
                                        .departure.iataCode] ??
                                    returnFirstSegment.departure.iataCode,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: Colors.grey)),
                          ],
                        ),
                        SizedBox(
                          height: 80.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "$returnArrivalTime - ${returnLastSegment.arrival.iataCode}",
                                style: Theme.of(context).textTheme.bodySmall),
                            SizedBox(
                              height: 1.w,
                            ),
                            Text(
                                locationNames[
                                        returnLastSegment.arrival.iataCode] ??
                                    returnLastSegment.arrival.iataCode,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
                SizedBox(
                  height: 16.h,
                ),
                const Divider(
                  height: 1,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Vol",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.grey)),
                        SizedBox(
                          height: 2.w,
                        ),
                        Text(
                            "${returnFirstSegment.carrierCode} ${returnFirstSegment.number}",
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                    SizedBox(
                      width: 0.5.sw,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Durée",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.grey)),
                          SizedBox(
                            height: 2.w,
                          ),
                          Text(_formatDuration(returnItinerary.duration!),
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Compagnie",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.grey)),
                        SizedBox(
                          height: 2.w,
                        ),
                        Row(
                          children: [
                            Image.asset(
                                "assets/images/Square/${returnFirstSegment.carrierCode}.png",
                                errorBuilder: (context, error, stackTrace) {
                              return Image.asset("assets/icons/app-logo.png",
                                  width: 24.r);
                            }, width: 24.r),
                            SizedBox(width: 8.w),
                            Text(
                                carrierNames[returnFirstSegment.carrierCode] ??
                                    returnFirstSegment.carrierCode,
                                style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 0.5.sw,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Avion",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.grey)),
                          SizedBox(
                            height: 2.w,
                          ),
                          Text(returnFirstSegment.aircraft.code,
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
              // endregion
              SizedBox(
                height: 32.h,
              ),
              Text("Inclusions",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
              SizedBox(
                height: 8.h,
              ),

              if (amenities == null || amenities.isEmpty)
                Text("Aucune inclusion spécifiée.",
                    style: Theme.of(context).textTheme.bodySmall)
              else
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: amenities.map((amenity) {
                    return Row(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _getAmenityIcon(amenity.amenityType),
                            SizedBox(width: 8.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(amenity.description,
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                SizedBox(
                                  height: 1.w,
                                ),
                                Text("Inclus",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: Colors.grey)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  }).toList(),
                ),
              SizedBox(
                height: 220.h,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
