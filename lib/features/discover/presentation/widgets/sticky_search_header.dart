import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_text_field.dart';
import 'package:flysen_frontend_mobile/core/utils/dimensions.dart';
import 'package:flysen_frontend_mobile/features/discover/presentation/blocs/discover_search/discover_search_bloc.dart';
import 'package:flysen_frontend_mobile/features/discover/presentation/widgets/category_row.dart'; // Make sure this path is correct

class StickySearchHeader extends SliverPersistentHeaderDelegate {
  final TextEditingController searchController;
  final LayerLink layerLink = LayerLink();

  // Calculate the total height of your sticky section
  final double height = (56.h) + (16.h) + (40.h) + (31.h);

  StickySearchHeader({required this.searchController});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context)
          .scaffoldBackgroundColor, // Ensure a solid background
      child: Column(
        children: [
          Padding(
            padding: Dimension.horizontalPadding,
            // Use CompositedTransformTarget to mark where the overlay should appear
            child: CompositedTransformTarget(
              link: layerLink,
              child: CustomTextField(
                searchable: true,
                hintText: "Recherche...",
                controller: searchController,
                // When the text changes, add an event to the DiscoverSearchBloc
                onChanged: (query) {
                  context
                      .read<DiscoverSearchBloc>()
                      .add(SearchQueryChanged(query));
                },
                onTap: () {
                  // This could be used for a clear button or other actions
                },
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Padding(padding: Dimension.horizontalPadding, child: CategoryRow()),
        ],
      ),
    );
  }

  // The maximum height of the header when fully expanded.
  @override
  double get maxExtent => height;

  // The minimum height of the header when fully collapsed (it should be the same as maxExtent to just stick).
  @override
  double get minExtent => height;

  // This is called to check if the header needs to be rebuilt.
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true; // For simplicity, always rebuild. Can be optimized.
  }
}
