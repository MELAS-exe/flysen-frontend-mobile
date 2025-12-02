import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flysen_frontend_mobile/core/utils/dimensions.dart';
import 'package:flysen_frontend_mobile/features/discover/domain/entities/event_entity.dart';
import 'package:intl/intl.dart'; // Import for date formatting

class Event extends StatelessWidget {
  final GestureTapCallback? onTap;
  final EventEntity eventEntity;

  const Event({
    super.key,
    this.onTap,
    required this.eventEntity,
  });

  @override
  Widget build(BuildContext context) {
    // Helper to format the date nicely
    String formattedDate =
        DateFormat('d MMM', 'fr_FR').format(eventEntity.date);

    return GestureDetector(
      // Wrap with GestureDetector to make it tappable
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            height: 120.h,
            decoration: BoxDecoration(
                // --- THIS IS THE FIX ---
                image: DecorationImage(
                    // Use CachedNetworkImage for better performance and error handling
                    image: CachedNetworkImageProvider(
                      // Use the safe 'firstImage' getter from your entity
                      eventEntity.firstImage,
                    ),
                    fit: BoxFit.cover,
                    // Add a color filter to darken the image slightly, making text more readable
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.3), BlendMode.darken)),
                borderRadius: BorderRadius.circular(15.r)),
            child: Align(
              alignment: Alignment.bottomCenter,
              // The transparent gradient overlay can be simplified
              child: Container(
                height: 60.h,
                padding: Dimension.horizontalPadding,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        // Use Expanded to handle long text
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8.h),
                            Text(eventEntity.name,
                                maxLines: 1, // Ensure single line
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                            SizedBox(height: 2.h),
                            Text(eventEntity.destinationName,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: Colors.white,
                                    )),
                          ],
                        ),
                      ),
                      // Nicer Date Display
                      Text(
                        formattedDate,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
