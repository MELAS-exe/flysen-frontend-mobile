import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flysen_frontend_mobile/app/router/app_router.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_text_field.dart';
import 'package:flysen_frontend_mobile/core/utils/dimensions.dart';
import 'package:flysen_frontend_mobile/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:flysen_frontend_mobile/features/discover/domain/entities/destination_entity.dart';
import 'package:flysen_frontend_mobile/features/discover/presentation/blocs/discover/discover_bloc.dart';
import 'package:flysen_frontend_mobile/features/discover/presentation/blocs/discover_search/discover_search_bloc.dart';
import 'package:flysen_frontend_mobile/features/discover/presentation/widgets/category_row.dart';
import 'package:flysen_frontend_mobile/features/discover/presentation/widgets/destination.dart';
import 'package:flysen_frontend_mobile/features/discover/presentation/widgets/event.dart';

// Assuming your new sticky header is in this path
import 'package:flysen_frontend_mobile/features/discover/presentation/widgets/sticky_search_header.dart';
import 'package:flysen_frontend_mobile/injector.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class Discover extends StatefulWidget {
  const Discover({super.key});

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  // Controller needs to be stateful to be passed to the delegate and disposed properly
  final TextEditingController _rechercheController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late final DiscoverBloc _discoverBloc;
  late final DiscoverSearchBloc _discoverSearchBloc;

  @override
  void initState() {
    super.initState();
    // You are adding the listener twice. Let's clean that up.
    _discoverBloc = getIt<DiscoverBloc>()..add(const LoadInitialData());
    _discoverSearchBloc = getIt<DiscoverSearchBloc>();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _discoverBloc),
        BlocProvider.value(value: _discoverSearchBloc),
      ],
      child: BlocListener<DiscoverBloc, DiscoverState>(
        listener: (context, state) {
          if (state is DiscoverAuthenticationError) {
            context.goNamed(AppRouter.auth);
            context.read<AuthBloc>().add(const SignOutRequested());
          }
        },
        child: _DiscoverView(
          rechercheController: _rechercheController,
          scrollController: _scrollController,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _rechercheController.dispose();
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    // The call to super.dispose() should be at the end.
    _discoverBloc.close();
    _discoverSearchBloc.close();
    super.dispose();
  }

  void _onScroll() {
    if (!_isBottom) return;

    // Use the `_discoverBloc` variable directly instead of `context.read`.
    final currentState = _discoverBloc.state;

    // Only proceed if we are in a 'DiscoverLoaded' state.
    // Assuming you will add a `hasReachedMax` flag to your DiscoverLoaded state.
    if (currentState is DiscoverLoaded) {
      final destinations = currentState.destinations;
      if (destinations.isNotEmpty) {
        // Get the ID of the last destination in the current list
        final lastId = destinations.last.id;
        // Dispatch the event with the last ID
        _discoverBloc.add(LoadMoreDestinations(lastDocumentId: lastId));
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    // Trigger when user is within 200 pixels of the bottom
    return currentScroll >= (maxScroll - 200);
  }
}

class _DiscoverView extends StatelessWidget {
  final TextEditingController rechercheController;
  final ScrollController scrollController;

  const _DiscoverView({
    required this.rechercheController,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscoverBloc, DiscoverState>(
      builder: (context, state) {
        // If the initial data is loading, show a full-screen shimmer layout.
        if (state is DiscoverLoading) {
          return _buildLoadingShimmer();
        }

        final bool shouldShowEvent =
            state is DiscoverLoaded && state.featuredEvents.isNotEmpty;
        return CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverToBoxAdapter(
              // Only build the Column and its children if we should show the event.
              // Otherwise, build a completely empty widget.
              child: shouldShowEvent
                  ? Column(
                      children: [
                        SizedBox(height: 16.h),
                        Padding(
                          padding: Dimension.horizontalPadding,
                          child: Event(
                            onTap: () {
                              context.pushNamed(AppRouter.eventDetail,
                                  extra: (state as DiscoverLoaded)
                                      .featuredEvents
                                      .first);
                            },
                            // This code path is now only executed when the list is not empty.
                            eventEntity:
                                (state as DiscoverLoaded).featuredEvents[1],
                          ),
                        ),
                        SizedBox(height: 16.h),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),

            // --- The StickySearchHeader remains the same ---
            SliverPersistentHeader(
              delegate:
                  StickySearchHeader(searchController: rechercheController),
              pinned: true,
            ),

            // --- Search Results or Default List Section ---
            BlocBuilder<DiscoverSearchBloc, DiscoverSearchState>(
              builder: (context, searchState) {
                if (rechercheController.text.isEmpty) {
                  return _buildDefaultDiscoverList(state);
                }
                // ... (search result logic is unchanged)
                if (searchState is DiscoverSearchLoaded) {
                  return _buildSearchResultsList(searchState.destinations);
                }
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              },
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: 80.h),
            ),
          ],
        );
      },
    );
  }

  // --- NEW: Helper Widget for a full-page shimmer ---
  Widget _buildLoadingShimmer() {
    return CustomScrollView(
      physics:
          const NeverScrollableScrollPhysics(), // Disable scrolling during load
      slivers: [
        // Shimmer for the Event
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(height: 16.h),
              Padding(
                padding: Dimension.horizontalPadding,
                child: Shimmer(
                  duration: Duration(milliseconds: 2000),
                  interval: Duration(milliseconds: 0),
                  direction: ShimmerDirection.fromLBRT(),
                  child: Container(
                    height: 120.h,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15.r)),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
        // Shimmer for the Search Bar
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(Dimension.horizontalPadding.left, 0,
                Dimension.horizontalPadding.right, 32.h),
            child: Shimmer(
              duration: Duration(milliseconds: 2000),
              interval: Duration(milliseconds: 0),
              direction: ShimmerDirection.fromLBRT(),
              child: Container(
                height: 56.h,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(100.r)),
              ),
            ),
          ),
        ),
        // Shimmer for the Destination list
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Padding(
                padding: EdgeInsets.fromLTRB(Dimension.horizontalPadding.left,
                    20.h, Dimension.horizontalPadding.right, 32.h),
                child: Shimmer(
                  duration: Duration(milliseconds: 2000),
                  interval: Duration(milliseconds: 0),
                  direction: ShimmerDirection.fromLBRT(),
                  child: Container(
                    height: 1.sw,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15.r)),
                  ),
                ),
              );
            },
            childCount: 3, // Show 3 shimmer placeholders
          ),
        )
      ],
    );
  }

  // --- Helper Widget for the Default List (Now takes state as a parameter) ---
  Widget _buildDefaultDiscoverList(DiscoverState state) {
    // The initial loading state is already handled, so we just check for errors and loaded states.
    if (state is DiscoverError) {
      return SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text('Erreur: ${state.message}',
                style: const TextStyle(color: Colors.red)),
          ),
        ),
      );
    } else if (state is DiscoverLoaded) {
      // Only check for DiscoverLoaded
      if (state.destinations.isEmpty) {
        return const SliverToBoxAdapter(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Text('Aucune destination disponible'),
            ),
          ),
        );
      }

      return SliverMainAxisGroup(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final destination = state.destinations[index];
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                      Dimension.horizontalPadding.left,
                      index == 0 ? 20.h : 0,
                      Dimension.horizontalPadding.right,
                      32.h),
                  child: Destination(
                    destination: destination,
                    onTap: () {
                      context.pushNamed(AppRouter.destinationDetail,
                          extra: destination);
                    },
                  ),
                );
              },
              childCount: state.destinations.length,
            ),
          ),
          // Show loading indicator at the bottom ONLY if we haven't reached the max.
          if (!state.hasReachedMax)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
        ],
      );
    }
    return const SliverToBoxAdapter(child: SizedBox.shrink());
  }

  // --- Helper Widget for the Search Results List ---
  Widget _buildSearchResultsList(List<DestinationEntity> searchResults) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final destination = searchResults[index];
          return Padding(
            padding: EdgeInsets.fromLTRB(Dimension.horizontalPadding.left,
                index == 0 ? 20.h : 0, Dimension.horizontalPadding.right, 32.h),
            child: Destination(
              destination: destination,
              onTap: () {
                // When a search result is tapped, clear the search and navigate.
                context.read<DiscoverSearchBloc>().add(ClearSearch());
                rechercheController.clear();
                context.pushNamed(AppRouter.destinationDetail,
                    extra: destination);
              },
            ),
          );
        },
        childCount: searchResults.length,
      ),
    );
  }
}
