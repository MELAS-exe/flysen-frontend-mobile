import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/entities/flight_search_params.dart';
import 'package:flysen_frontend_mobile/features/reservation/presentation/bloc/flight/flight_bloc.dart';

class TripStep1Form extends StatefulWidget {
  const TripStep1Form({super.key});

  @override
  State<TripStep1Form> createState() => _TripStep1FormState();
}

class _TripStep1FormState extends State<TripStep1Form> {
  final _formKey = GlobalKey<FormState>();
  final _originController = TextEditingController(text: 'DSS');
  final _destinationController = TextEditingController(text: 'CDG');
  final _dateController = TextEditingController(text: '2025-12-01');

  @override
  void dispose() {
    _originController.dispose();
    _destinationController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _onSearch() {
    if (_formKey.currentState!.validate()) {
      final params = FlightSearchParams(
        currencyCode: 'XOF',
        originDestinations: [
          OriginDestination(
            id: '1',
            originLocationCode: _originController.text.trim().toUpperCase(),
            destinationLocationCode: _destinationController.text.trim().toUpperCase(),
            departureDateTimeRange: DepartureDateTimeRange(date: _dateController.text.trim()),
          ),
        ],
        travelers: [const Traveler(id: '1', travelerType: 'ADULT')],
        sources: ['GDS'],
        searchCriteria: const SearchCriteria(maxFlightOffers: 10),
      );
      // Déclenche l'événement pour chercher les vols
      context.read<FlightBloc>().add(SearchFlights(params));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _originController,
              decoration: const InputDecoration(labelText: 'Aéroport de départ', hintText: 'ex: DSS'),
              validator: (value) => value!.isEmpty ? 'Champ requis' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _destinationController,
              decoration: const InputDecoration(labelText: 'Aéroport d\'arrivée', hintText: 'ex: CDG'),
              validator: (value) => value!.isEmpty ? 'Champ requis' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _dateController,
              decoration: const InputDecoration(labelText: 'Date de départ', hintText: 'YYYY-MM-DD'),
              validator: (value) => value!.isEmpty ? 'Champ requis' : null,
            ),
            const SizedBox(height: 32),
            // Le bouton de recherche s'anime pendant le chargement
            BlocBuilder<FlightBloc, FlightState>(
              builder: (context, state) {
                if (state is FlightLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ElevatedButton(
                  onPressed: _onSearch,
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                  child: const Text('Rechercher les vols'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}