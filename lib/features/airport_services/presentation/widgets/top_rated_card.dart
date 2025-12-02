import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/stars.dart';
import 'package:flysen_frontend_mobile/core/theme/theme.dart';
import 'package:flysen_frontend_mobile/features/airport_services/domain/entities/airport_service_entity.dart';

class TopRatedCard extends StatelessWidget {
  final AirportServiceEntity airportServiceEntity;
  const TopRatedCard({super.key, required this.airportServiceEntity});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: Stack(
        children: [
          // Background Image
          Container(
            width: 1.sw - 32.w,
            height: 150.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(airportServiceEntity.images[0]),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Gradient Overlay
          Container(
            width: 1.sw - 32.w,
            height: 150.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                end: Alignment.topCenter,
                begin: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.8),
                  Colors.black.withOpacity(0.1),
                ],
              ),
            ),
          ),
          // Content (Text, etc.)
          Positioned(
            bottom: 12.h,
            left: 16.w,
            right: 16.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48.h,
                  height: 48.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(airportServiceEntity.logo ?? ''),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  airportServiceEntity.name,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),

          Positioned(
              bottom: 12.h,
              right: 16.w,
              child: Stars(score: airportServiceEntity.rating)),
        ],
      ),
    );
  }
}
