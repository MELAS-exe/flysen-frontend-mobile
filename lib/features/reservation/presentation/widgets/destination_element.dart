import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:flysen_frontend_mobile/features/reservation/domain/entities/flight_offer.dart';
import 'package:flysen_frontend_mobile/core/utils/mapper.dart';

class DestinationElement extends StatelessWidget {
  final FlightOffer flightOffer;
  final Map<String, String> carrierNames; // e.g., { "AH": "AIR ALGERIE" }
  final bool isCheapest;
  final bool isFastest;
  final GestureTapCallback? onTap;

  const DestinationElement({
    super.key,
    required this.flightOffer,
    required this.carrierNames,
    this.onTap,
    this.isCheapest = false,
    this.isFastest = false,
  });

  /// Helper function to format ISO 8601 duration (e.g., "PT10H55M") into a readable string.
  String _formatDuration(String isoDuration) {
    if (!isoDuration.startsWith('PT')) return isoDuration;
    String temp = isoDuration.substring(2); // Remove "PT"

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

  @override
  Widget build(BuildContext context) {
    // --- Derive all data from the flightOffer object ---
    final outboundItinerary = flightOffer.itineraries.first;
    final segments = outboundItinerary.segments;
    final firstSegment = segments.first;
    final lastSegment = segments.last;

    final String carrierCode = firstSegment.carrierCode;
    final String companyName = carrierNames[carrierCode] ?? carrierCode;
    final String price = NumberFormat.currency(
      locale: 'fr_FR', // Or your desired locale
      symbol: flightOffer.price.currency,
      decimalDigits: 0,
    ).format(double.parse(flightOffer.price.total));

    final bool isRoundTrip = !(flightOffer.oneWay ?? false);
    final DateTime departureDateTime =
        DateTime.parse(firstSegment.departure.at);
    final DateTime arrivalDateTime = DateTime.parse(lastSegment.arrival.at);
    final String duration = _formatDuration(outboundItinerary.duration ?? '');

    final String departureLocation = firstSegment.departure.iataCode;
    final String arrivalLocation = lastSegment.arrival.iataCode;
    final String stops =
        segments.length > 1 ? '${segments.length - 1} escale(s)' : 'Direct';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: isCheapest || isFastest
            ? EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.w)
            : EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.black),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // --- Cheapest/Fastest Banners ---
            if (isCheapest)
              _buildBanner(context, "Moins cher", const Color(0xFFDCFCE7),
                  const Color(0xFF30AD5E)),
            if (isFastest)
              _buildBanner(context, "Plus rapide", const Color(0xFFF3E0B4),
                  const Color(0xFFA25A28)),

            if (isCheapest || isFastest) const SizedBox(height: 8),

            // --- Header: Airline and Price ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Image.asset(
                    "assets/images/Square/${carrierCode}.png",
                    width: 32.w,
                    height: 32.w,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                        getAirlineLogoPath(''),
                        width: 32.w), // Fallback
                  ),
                  SizedBox(width: 8.w),
                  SizedBox(
                    width: 100.w,
                    child: Text(
                      companyName,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )
                ]),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text(
                    price,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    isRoundTrip ? "Aller-retour" : "Aller simple",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.grey),
                  )
                ]),
              ],
            ),
            SizedBox(height: 16.w),

            // --- Itinerary Visual ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTimeAndLocation(
                    context,
                    DateFormat.Hm().format(departureDateTime),
                    departureLocation,
                    CrossAxisAlignment.start),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(radius: 4.w, backgroundColor: Colors.black),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Dash(
                              direction: Axis.horizontal,
                              dashColor: Colors.grey,
                              dashLength: 4.w,
                            ),
                          ),
                          Image.asset("assets/icons/airplane-mode.png",
                              width: 16.w),
                        ],
                      ),
                      CircleAvatar(radius: 4.w, backgroundColor: Colors.black),
                    ],
                  ),
                ),
                _buildTimeAndLocation(
                    context,
                    DateFormat.Hm().format(arrivalDateTime),
                    arrivalLocation,
                    CrossAxisAlignment.end),
              ],
            ),
            SizedBox(height: 16.h),

            // --- Footer: Duration and Stops ---
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$duration, $stops",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.grey),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  // Helper widget for banners
  Widget _buildBanner(
      BuildContext context, String text, Color bgColor, Color textColor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      width: 100.w,
      height: 16.w,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(5.w),
          bottomRight: Radius.circular(5.w),
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }

  // Helper widget for time and location display
  Widget _buildTimeAndLocation(BuildContext context, String time,
      String location, CrossAxisAlignment alignment) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(time,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold)),
        Text(location, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
