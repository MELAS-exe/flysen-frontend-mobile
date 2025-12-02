import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/stars.dart';
import 'package:flysen_frontend_mobile/features/discover/domain/entities/destination_entity.dart';

class Destination extends StatelessWidget {
  // The widget now takes a single DestinationEntity object
  final DestinationEntity destination;
  final GestureTapCallback? onTap;

  const Destination({
    super.key,
    required this.destination,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Extract information directly from the entity
    final String title = destination.name;
    final double? score = destination.popularityScore;
    final String? description = destination.description;
    final String? imageUrl = destination.images?.isNotEmpty == true
        ? destination.images!.first
        : null;

    Widget buildPlaceholder() {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: Colors.grey[300],
        ),
        child: Center(
          child: Icon(
            Icons.image_not_supported_rounded,
            size: 50.w,
            color: Colors.grey[600],
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 1.sw,
            height: 1.sw, // Adjusted height for a more rectangular look
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: imageUrl != null
                  // Use Image.network to get access to the errorBuilder
                  ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      // This builder is shown while the image is loading
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: Colors.grey[300],
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2.w,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                      // This builder is shown if the image fails to load (e.g., 404 error)
                      errorBuilder: (context, error, stackTrace) {
                        return buildPlaceholder();
                      },
                    )
                  // If there's no URL, show the placeholder immediately
                  : buildPlaceholder(),
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 0.5.sw,
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Handle the case where score might be null
                  if (score != null) Stars(score: score / 2),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              // Use the description from the entity
              if (description != null)
                SizedBox(
                  width: 1.sw,
                  child: Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
