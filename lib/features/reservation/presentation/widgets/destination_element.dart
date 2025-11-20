import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DestinationElement extends StatefulWidget {
  final Image companyLogo;
  final String companyName;
  final String price;
  final bool isRoundTrip;
  final DateTime departureDateTime;
  final DateTime arrivalDateTime;
  final String departureLocation;
  final String arrivalLocation;
  final String duration;
  final String stops;
  final DateTime date;
  final GestureTapCallback? onTap;
  final Color color;
  bool isCheapest;
  bool isFastest;
  DestinationElement({
    required this.companyLogo,
    required this.date,
    this.onTap,
    this.isCheapest = false,
    this.isFastest = false,
    required this.color,
    required this.companyName,
    required this.price,
    required this.isRoundTrip,
    required this.departureDateTime,
    required this.arrivalDateTime,
    required this.departureLocation,
    required this.arrivalLocation,
    required this.duration,
    required this.stops,
  });
  @override
  State<DestinationElement> createState() => _DestinationElementState();
}

class _DestinationElementState extends State<DestinationElement> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 150.h,
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.black),
        ),
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.isCheapest)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                width: 100.w,
                height: 16.w,
                decoration: BoxDecoration(
                    color: Color(0xFFDCFCE7),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5.w),
                      bottomRight: Radius.circular(5.w),
                    )),
                child: Center(
                  child: Text("Moins cher",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: const Color(0xFF30AD5E),
                            fontWeight: FontWeight.bold,
                          )),
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  widget.companyLogo,
                  SizedBox(width: 8.w),
                  Text(
                    widget.companyName,
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ]),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
