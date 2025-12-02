import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_button.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/stars.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/tab_selector.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/top_bar.dart';
import 'package:flysen_frontend_mobile/core/utils/dimensions.dart';
import 'package:flysen_frontend_mobile/features/discover/domain/entities/event_entity.dart';
import 'package:flysen_frontend_mobile/features/discover/presentation/widgets/chewie_video_player.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class EventDetail extends StatefulWidget {
  const EventDetail({super.key, required this.event});

  final EventEntity event;

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  // Helper to build a placeholder for missing images
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

  // Helper to open the full-screen photo gallery
  void _openPhotoGallery(BuildContext context, final int initialIndex) {
    final List<String> images = widget.event.images;

    Navigator.push(
      context,
      TransparentRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(color: Colors.black.withOpacity(0.5)),
              ),
              PhotoViewGallery.builder(
                itemCount: images.length,
                pageController: PageController(initialPage: initialIndex),
                builder: (context, index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: CachedNetworkImageProvider(images[index]),
                    initialScale: PhotoViewComputedScale.contained,
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.covered * 2.5,
                    heroAttributes: PhotoViewHeroAttributes(tag: images[index]),
                  );
                },
                loadingBuilder: (context, event) => const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
                backgroundDecoration:
                    const BoxDecoration(color: Colors.transparent),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Extract data from the EventEntity for easier access
    final String title = widget.event.name;
    final String location = widget.event.destinationName;
    final double score = widget.event.stats.averageRating;
    final int reviewCount = widget.event.stats.totalReviews;
    final String description = widget.event.description;
    final String? organizerName = widget.event.organizer?.name;

    // Use the safe 'firstImage' getter
    final String? imageUrl =
        widget.event.firstImage.isNotEmpty ? widget.event.firstImage : null;

    // Format date and time
    final String formattedDate =
        DateFormat('d MMMM yyyy', 'fr_FR').format(widget.event.date);
    final String formattedTime =
        DateFormat.Hm('fr_FR').format(widget.event.date);
    final String venue = widget.event.venue;

    return Scaffold(
      appBar: TopBar(showBack: true),
      body: SafeArea(
        child: Padding(
          padding: Dimension.aroundPadding,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                // Main Image
                SizedBox(
                  width: 1.sw,
                  height: 0.6.sw, // A more cinematic 16:9 aspect ratio
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child: imageUrl != null
                        ? Hero(
                            tag: imageUrl,
                            child: CachedNetworkImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: Colors.grey[300],
                              ),
                              errorWidget: (context, url, error) =>
                                  buildPlaceholder(),
                            ),
                          )
                        : buildPlaceholder(),
                  ),
                ),
                SizedBox(height: 16.h),
                // Title
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.h),
                // Location and Rating
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.grey, size: 16.sp),
                    SizedBox(width: 4.w),
                    Text(
                      location,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Stars(score: score),
                    SizedBox(width: 8.w),
                    Text(
                      '$score ($reviewCount avis)',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                const Divider(),
                SizedBox(height: 16.h),

                // Event Info Section (Date, Time, Venue)
                _buildInfoRow(
                    context, Icons.calendar_today, 'Date', formattedDate),
                SizedBox(height: 12.h),
                _buildInfoRow(
                    context, Icons.access_time, 'Heure', formattedTime),
                SizedBox(height: 12.h),
                _buildInfoRow(context, Icons.place, 'Lieu', venue),

                SizedBox(height: 16.h),
                const Divider(),
                SizedBox(height: 16.h),

                // Description
                Text(
                  "À propos de l'évènement",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.h),
                Text(
                  description.isNotEmpty
                      ? description
                      : "Aucune description disponible.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                SizedBox(height: 16.h),
                const Divider(),
                SizedBox(height: 16.h),

                // Organizer
                Text(
                  "Organisateur",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.h),
                Text(
                  organizerName ?? "Information non disponible",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                // Media Gallery
                if (widget.event.images.length > 1) ...[
                  SizedBox(height: 24.h),
                  Text(
                    "Photos",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16.h),
                  _buildPhotoGrid(),
                ],

                SizedBox(height: 120.h), // Space for bottom button
              ],
            ),
          ),
        ),
      ),
      // Floating Bottom Button
      bottomSheet: Container(
        padding: Dimension.aroundPadding,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: CustomButton(
          width: 150.w,
          height: 40.h,
          text: "Acheter un billet",
          onPressed: () {
          },
        ),
      ),
    );
  }

  // Helper widget to create consistent info rows
  Widget _buildInfoRow(
      BuildContext context, IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).primaryColor, size: 20.sp),
        SizedBox(width: 16.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.grey),
            ),
            SizedBox(height: 2.h),
            Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        )
      ],
    );
  }

  // Helper widget to build the grid of additional photos
  Widget _buildPhotoGrid() {
    // Exclude the first image since it's already shown as the main banner
    final additionalImages = widget.event.images.skip(1).toList();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.w,
        mainAxisSpacing: 8.h,
      ),
      itemCount: additionalImages.length,
      itemBuilder: (context, index) {
        final url = additionalImages[index];
        return GestureDetector(
          onTap: () {
            // The gallery index needs to be offset by 1
            _openPhotoGallery(context, index + 1);
          },
          child: Hero(
            tag: url,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[200],
                  child: const Icon(Icons.error_outline, color: Colors.grey),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// Re-using the custom transparent route from DestinationDetail
class TransparentRoute extends PageRoute<void> {
  TransparentRoute({required this.builder, RouteSettings? settings})
      : super(settings: settings, fullscreenDialog: false);

  final WidgetBuilder builder;

  @override
  bool get opaque => false;
  @override
  Color? get barrierColor => null;
  @override
  String? get barrierLabel => null;
  @override
  bool get maintainState => true;
  @override
  Duration get transitionDuration => const Duration(milliseconds: 350);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final result = builder(context);
    return FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
      child: result,
    );
  }
}
