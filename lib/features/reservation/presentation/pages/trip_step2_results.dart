import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/entities/flight_offer.dart';
import 'package:flysen_frontend_mobile/features/reservation/presentation/bloc/flight/flight_bloc.dart';

class TripStep2Results extends StatelessWidget {
  // Le paramètre manquant est réintroduit ici
  final VoidCallback onStepContinue;

  const TripStep2Results({super.key, required this.onStepContinue});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FlightBloc, FlightState>(
      // On utilise BlocConsumer pour écouter les changements d'état et agir
      listener: (context, state) {
        // Lorsque la tarification est terminée, on appelle le callback pour passer à l'étape 3
        if (state is FlightPriceLoaded) {
          onStepContinue();
        }
      },
      builder: (context, state) {
        // Déterminer la liste des offres à afficher, même pendant le chargement du prix
        List<FlightOffer> offersToShow = [];
        bool isLoadingPrice = state is FlightPriceLoading;

        if (state is FlightLoaded) {
          offersToShow = state.flightOffers;
        } else if (state is FlightPriceLoading) {
          // Afficher la liste précédente pendant le chargement du nouveau prix
          offersToShow = state.previousOffers;
        } else if (state is FlightPriceLoaded) {
          // Après le chargement du prix, nous sommes sur le point de changer d'étape.
          // Pour éviter un flash, on peut continuer d'afficher la liste précédente.
          final pricedOffer = state.priceResponse.flightOffers.first;
          // Trouver l'offre correspondante dans une liste potentielle pour garder l'UI cohérente.
          // C'est une simple logique de fallback, la navigation est la priorité.
          offersToShow = [pricedOffer];
        }


        if (offersToShow.isEmpty && !isLoadingPrice) {
          return const Center(
            child: Text(
              'Les résultats de votre recherche s\'afficheront ici.',
              textAlign: TextAlign.center,
            ),
          );
        }

        // Stack pour superposer l'indicateur de chargement sur la liste
        return Stack(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(), // Permet le scroll si le contenu dépasse
              padding: const EdgeInsets.all(16.0),
              itemCount: offersToShow.length,
              itemBuilder: (context, index) {
                final offer = offersToShow[index];
                final firstSegment = offer.itineraries.first.segments.first;
                final lastSegment = offer.itineraries.first.segments.last;

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      // Déclencher l'événement pour obtenir le prix détaillé
                      context.read<FlightBloc>().add(PriceFlight(offer));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${firstSegment.departure.iataCode} ➔ ${lastSegment.arrival.iataCode}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                '${offer.price.grandTotal ?? offer.price.total} ${offer.price.currency}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Durée: ${offer.itineraries.first.duration?.replaceAll("PT", "").replaceAll("H", "h ").replaceAll("M", "m") ?? "N/A"}',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            // Afficher un overlay de chargement pendant la tarification
            if (isLoadingPrice)
              Container(
                color: Colors.black.withOpacity(0.2),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        );
      },
    );
  }
}