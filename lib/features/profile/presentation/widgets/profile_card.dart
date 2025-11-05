import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flysen_frontend_mobile/core/theme/theme.dart';
import 'package:flysen_frontend_mobile/core/utils/dimensions.dart';

class ProfileCard extends StatefulWidget {
  final String name;
  final int totalPoints;
  final int totalFlights;
  final int totalReservations;
  final int totalPrizes;

  const ProfileCard(
      {super.key,
      required this.name,
      required this.totalPoints,
      required this.totalFlights,
      required this.totalReservations,
      required this.totalPrizes});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Dimension.aroundPadding,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.onSurface,
        borderRadius: BorderRadius.circular(30.w),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppTheme.lightTheme.colorScheme.surface,
                    radius: 20.w,
                    child: Center(
                      child: Image.asset(
                        "assets/icons/user.png",
                        width: 20.w,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme
                                      .lightTheme.colorScheme.onPrimary)),
                      SizedBox(
                        height: 4.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/icons/pencil.png",
                            width: 16.w,
                          ),
                          SizedBox(
                            width: 4.h,
                          ),
                          Text(
                            "Modifier",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                    color: AppTheme
                                        .lightTheme.colorScheme.onPrimary),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                "${widget.totalPoints} points",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.tertiary,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1.h,
            decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surfaceDim,
                borderRadius: BorderRadius.circular(100)),
          ),
          SizedBox(
            height: 16.h,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 8.w,
              children: [
                Container(
                  width: 1.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                      borderRadius: BorderRadius.circular(100)),
                ),
                Column(children: [
                  Text(
                    "${widget.totalFlights}",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.surface,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Voyages",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.surfaceDim,
                        fontWeight: FontWeight.bold),
                  ),
                ]),
                Container(
                  width: 1.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.surfaceDim,
                      borderRadius: BorderRadius.circular(100)),
                ),
                Column(children: [
                  Text(
                    "${widget.totalReservations}",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.surface,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Séjours",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.surfaceDim,
                        fontWeight: FontWeight.bold),
                  ),
                ]),
                Container(
                  width: 1.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.surfaceDim,
                      borderRadius: BorderRadius.circular(100)),
                ),
                Column(children: [
                  Text(
                    "${widget.totalPrizes}",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.surface,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Cadeau",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.surfaceDim,
                        fontWeight: FontWeight.bold),
                  ),
                ]),
                Container(
                  width: 1.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                      borderRadius: BorderRadius.circular(100)),
                ),
              ])
        ],
      ),
    );
  }
}
