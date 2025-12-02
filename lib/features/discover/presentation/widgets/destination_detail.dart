import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_button.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/stars.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/tab_selector.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/top_bar.dart';
import 'package:flysen_frontend_mobile/core/utils/dimensions.dart';
import 'package:flysen_frontend_mobile/features/discover/domain/entities/destination_entity.dart';
import 'package:flysen_frontend_mobile/features/discover/presentation/widgets/chewie_video_player.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class DestinationDetail extends StatefulWidget {
  const DestinationDetail({super.key, required this.destination});

  final DestinationEntity destination;

  @override
  State<DestinationDetail> createState() => _DestinationDetailState();
}

enum FilterType {
  all,
  photos,
  videos,
}

class _DestinationDetailState extends State<DestinationDetail> {
  FilterType _selectedFilterType = FilterType.all;

  Widget _buildMediaGrid() {
    final List<String> images = widget.destination.images ?? [];
    final List<String> videos = widget.destination.videos ?? [];

    List<Map<String, String>> mediaItems = [];

    if (_selectedFilterType == FilterType.all ||
        _selectedFilterType == FilterType.photos) {
      mediaItems.addAll(images.map((url) => {'type': 'photo', 'url': url}));
    }
    if (_selectedFilterType == FilterType.all ||
        _selectedFilterType == FilterType.videos) {
      mediaItems.addAll(videos.map((url) => {'type': 'video', 'url': url}));
    }

    if (mediaItems.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h),
          child: SizedBox(
            child: Text(
              "Aucun média disponible.",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      // Important for nested scrolling
      physics: const NeverScrollableScrollPhysics(),
      // Disable GridView's own scrolling
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.w,
        mainAxisSpacing: 8.h,
      ),
      itemCount: mediaItems.length,
      itemBuilder: (context, index) {
        final item = mediaItems[index];
        final url = item['url']!;
        final type = item['type'];
        if (type == 'photo') {
          return GestureDetector(
            onTap: () {
              // We need to find the correct starting index within the *original* images list
              final imageIndex = images.indexOf(url);
              if (imageIndex != -1) {
                _openPhotoGallery(context, imageIndex);
              }
            },
            child: Hero(
              // The tag must be unique, so the URL is a perfect choice
              tag: url,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      buildPlaceholder(),
                ),
              ),
            ),
          );
        } else if (type == 'video') {
          return GestureDetector(
            onTap: () {
              _openVideoPlayer(context, url);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Colors.black,
              ),
              child: Icon(Icons.play_circle_outline,
                  color: Colors.white, size: 30.r),
            ),
          );
        }
        return Container();
      },
    );
  }

  void _openVideoPlayer(BuildContext context, String videoUrl) {
    Navigator.push(
      context,
      TransparentRoute(
        // Using the same custom route
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.close, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: Stack(
              children: [
                // The blur effect
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                // The video player on top
                ChewieVideoPlayer(videoUrl: videoUrl),
              ],
            ),
          );
        },
      ),
    );
  }

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

  void _openPhotoGallery(BuildContext context, final int initialIndex) {
    // We only want to show photos in the gallery
    final List<String> images = widget.destination.images ?? [];

    Navigator.push(
      context,
      // Use our new custom transparent route
      TransparentRoute(
        builder: (context) => Scaffold(
          // Set scaffold to be transparent to see the blur behind it
          backgroundColor: Colors.transparent,
          // Add an AppBar to allow closing the gallery
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.close, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Stack(
            children: [
              // This BackdropFilter is what creates the blur effect
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  // This adds the semi-transparent black color over the blur
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              // Your PhotoViewGallery sits on top of the blurred background
              PhotoViewGallery.builder(
                itemCount: images.length,
                pageController: PageController(initialPage: initialIndex),
                builder: (context, index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(images[index]),
                    initialScale: PhotoViewComputedScale.contained,
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.covered * 2.5,
                    heroAttributes: PhotoViewHeroAttributes(tag: images[index]),
                  );
                },
                loadingBuilder: (context, event) => Center(
                  child: SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                      value: event == null
                          ? 0
                          : event.cumulativeBytesLoaded /
                              (event.expectedTotalBytes ?? 1),
                    ),
                  ),
                ),
                // Important: Set the gallery background to transparent
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
    final String region = widget.destination.region;
    final List<String>? higlights = widget.destination.highlights;
    final String title = widget.destination.name;
    final String nearestAirport = widget.destination.nearestAirportCode ?? "";
    final double? score = widget.destination.popularityScore;
    final String? description = widget.destination.description;
    final String? imageUrl = widget.destination.images?.isNotEmpty == true
        ? widget.destination.images!.first
        : null;

    return Scaffold(
      appBar: TopBar(
        showBack: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: Dimension.aroundPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16.h,
              ),
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
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
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
              Text(title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              SizedBox(
                height: 2.h,
              ),
              Text(region,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.grey)),
              SizedBox(
                height: 4.h,
              ),
              Stars(score: score == null ? 0 : score / 2),
              SizedBox(
                height: 16.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/icons/airplane-mode.png",
                        width: 24.r,
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      SizedBox(
                        width: 0.4.sw,
                        child: Text(nearestAirport,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall),
                      ),
                    ],
                  ),
                  CustomButton(
                      width: 150.w,
                      height: 40.h,
                      text: "Acheter un billet",
                      onPressed: () {})
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(description ?? "Pas de description fournie",
                  style: Theme.of(context).textTheme.bodySmall),
              SizedBox(height: 16.h),
              Text("A découvrir",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
              SizedBox(height: 8.h),
              if (higlights != null && higlights.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: higlights
                      .map((highlight) => Padding(
                            padding: EdgeInsets.only(bottom: 4.h),
                            child: Text(
                              "• $highlight",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ))
                      .toList(),
                )
              else
                Text(
                  "Pas de points forts fournis.",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              SizedBox(height: 16.h),
              Text("Catalogue",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
              SizedBox(
                height: 8.h,
              ),
              TabSelector<FilterType>(
                options: const {
                  FilterType.all: 'Tous',
                  FilterType.photos: 'Photos',
                  FilterType.videos: 'Videos',
                },
                initialValue: FilterType.all,
                onSelectionChanged: (newSelection) {
                  setState(() {
                    _selectedFilterType = newSelection;
                  });
                },
              ),
              SizedBox(height: 16.h),
              _buildMediaGrid(),
              SizedBox(height: 100.h),
            ],
          ),
        ),
      )),
    );
  }
}

class TransparentRoute extends PageRoute<void> {
  TransparentRoute({
    required this.builder,
    RouteSettings? settings,
  }) : super(settings: settings, fullscreenDialog: false);

  final WidgetBuilder builder;

  @override
  bool get opaque => false; // This is the key to making the route transparent

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
