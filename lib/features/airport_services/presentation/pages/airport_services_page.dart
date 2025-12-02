import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_text_field.dart';
import 'package:flysen_frontend_mobile/core/utils/dimensions.dart';
import 'package:flysen_frontend_mobile/features/airport_services/presentation/blocs/airport_services/airport_services_bloc.dart';
import 'package:flysen_frontend_mobile/features/airport_services/presentation/widgets/category_row_airport_service.dart';
import 'package:flysen_frontend_mobile/features/airport_services/presentation/widgets/service_tile.dart';
import 'package:flysen_frontend_mobile/features/airport_services/presentation/widgets/top_rated_card.dart';
import 'package:flysen_frontend_mobile/injector.dart';

class AirportServicesPage extends StatefulWidget {
  final String airportId;
  final String airportName;

  const AirportServicesPage({
    super.key,
    required this.airportId,
    required this.airportName,
  });

  @override
  State<AirportServicesPage> createState() => _AirportServicesPageState();
}

class _AirportServicesPageState extends State<AirportServicesPage> {
  @override
  Widget build(BuildContext context) {
    // Calculate the width for each grid item.
    // Screen width - horizontal padding on both sides - spacing between items
    final double horizontalPadding = Dimension.horizontalPadding.horizontal;
    const double gridSpacing = 16.0;
    final double itemWidth = (1.sw - horizontalPadding - gridSpacing) / 2;

    return BlocProvider(
      create: (context) => getIt<AirportServicesBloc>()
        ..add(LoadAirportServices(widget.airportId)),
      child: Scaffold(
        body: BlocBuilder<AirportServicesBloc, AirportServicesState>(
          builder: (context, state) {
            if (state is AirportServicesLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is AirportServicesError) {
              return Center(
                  child: Text(state.message,
                      style: const TextStyle(color: Colors.red)));
            }
            if (state is AirportServicesLoaded) {
              if (state.services.isEmpty) {
                return const Center(
                    child: Text("Aucun service trouvé pour cet aéroport."));
              }

              final topRatedService = state.services.first;
              final otherServices = state.services.skip(1).toList();

              String airportName = widget.airportName;
              return SingleChildScrollView(
                child: Padding(
                  padding: Dimension.horizontalPadding,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            CircleAvatar(
                                radius: 16.h,
                                backgroundColor:
                                    Theme.of(context).colorScheme.tertiary,
                                child: Icon(Icons.location_pin,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    size: 16.h)),
                            SizedBox(width: 8.h),
                            Text(
                              airportName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Text(
                          "Les meilleurs",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        // The top rated card remains, taking full width
                        TopRatedCard(airportServiceEntity: topRatedService),
                        SizedBox(
                          height: 32.h,
                        ),
                        CustomTextField(
                          searchable: true,
                          hintText: "Recherche...",
                          onTap: () {},
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        CategoryRowAirportService(),
                        SizedBox(
                          height: 16.h,
                        ),
                        // --- NEW GRID IMPLEMENTATION ---
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: otherServices.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: gridSpacing,
                            mainAxisSpacing: gridSpacing,
                            childAspectRatio:
                                itemWidth / (itemWidth), // Adjust height ratio
                          ),
                          itemBuilder: (context, index) {
                            final service = otherServices[index];
                            return ServiceTile(
                              airportServiceEntity: service,
                              width: itemWidth,
                            );
                          },
                        ),
                        SizedBox(
                            height: 32.h), // Add some padding at the bottom
                      ]),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
