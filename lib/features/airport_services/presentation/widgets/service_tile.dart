import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/stars.dart';
import 'package:flysen_frontend_mobile/core/theme/theme.dart';
import 'package:flysen_frontend_mobile/features/airport_services/domain/entities/airport_service_entity.dart';

class ServiceTile extends StatelessWidget {
  final AirportServiceEntity airportServiceEntity;
  final double width;
  const ServiceTile({
    super.key,
    required this.airportServiceEntity,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: Stack(
        children: [
          // Background Image
          Container(
            width: width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(airportServiceEntity.images[0]),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Gradient Overlay
          Container(
            width: width,
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
          Positioned(
            bottom: 12.h,
            left: 16.w,
            right: 16.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 32.h,
                  height: 32.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(airportServiceEntity.logo ?? ''),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  airportServiceEntity.name,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),

          Positioned(
              bottom: 48.h,
              right: 16.w,
              child: Stars(score: airportServiceEntity.rating)),
        ],
      ),
    );
  }
}
