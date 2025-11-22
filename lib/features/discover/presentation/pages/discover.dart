import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flysen_frontend_mobile/app/router/app_router.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_text_field.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/top_bar.dart';
import 'package:flysen_frontend_mobile/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:flysen_frontend_mobile/features/discover/presentation/blocs/discover_bloc.dart';
import 'package:flysen_frontend_mobile/features/discover/presentation/widgets/category_row.dart';
import 'package:flysen_frontend_mobile/features/discover/presentation/widgets/destination.dart';
import 'package:flysen_frontend_mobile/features/discover/presentation/widgets/event.dart';
import 'package:flysen_frontend_mobile/injector.dart';
import 'package:go_router/go_router.dart';

class Discover extends StatefulWidget {
  const Discover({super.key});

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DiscoverBloc>()..add(const LoadDestinations()),
      child: BlocListener<DiscoverBloc, DiscoverState>(
        listener: (context, state) {
          if (state is DiscoverAuthenticationError) {
            context.read<AuthBloc>().add(const SignOutRequested());
            context.goNamed(AppRouter.auth);
          }
        },
        child: _DiscoverView(),
      ),
    );
  }
}

class _DiscoverView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController recherche = TextEditingController();

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CustomTextField(
                  controller: recherche,
                  searchable: true,
                  hintText: "Que voulez vous découvrir?",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CategoryRow(),
              SizedBox(
                height: 40,
              ),

              // BLoC Consumer for destinations
              BlocBuilder<DiscoverBloc, DiscoverState>(
                builder: (context, state) {
                  if (state is DiscoverLoading) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is DiscoverError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Text(
                          'Erreur: ${state.message}',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    );
                  } else if (state is DiscoverLoaded ||
                      state is DiscoverLoadingMore) {
                    final destinations = state is DiscoverLoaded
                        ? state.destinations
                        : (state as DiscoverLoadingMore).destinations;

                    if (destinations.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Text('Aucune destination disponible'),
                        ),
                      );
                    }

                    return Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),

                        // Destinations from API
                        ...destinations.map((destination) {
                          final firstImage =
                              destination.images?.isNotEmpty == true
                                  ? destination.images!.first
                                  : null;

                          return Column(
                            children: [
                              Destination(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    "/destination_detail",
                                  );
                                },
                                score: destination.popularityScore,
                                title: destination.name,
                                duration:
                                    destination.averageStayDuration?.toString(),
                                image: firstImage,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          );
                        }).toList(),

                        // Loading more indicator
                        if (state is DiscoverLoadingMore)
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: CircularProgressIndicator(),
                          ),
                      ],
                    );
                  }

                  return SizedBox.shrink();
                },
              ),

              SizedBox(
                height: 80,
              )
            ],
          ),
        ),
      ],
    );
  }
}
