import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/entities/flight_offer.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/entities/flight_price_response.dart';
import 'package:flysen_frontend_mobile/features/reservation/presentation/bloc/flight/flight_bloc.dart';

class TripStep3Passenger extends StatefulWidget {
  const TripStep3Passenger({super.key});

  @override
  State<TripStep3Passenger> createState() => _TripStep3PassengerState();
}

class _TripStep3PassengerState extends State<TripStep3Passenger> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _onConfirmBooking() {
    if (_formKey.currentState!.validate()) {
      // Logique future pour créer la réservation (booking)
      print('Confirmation de la réservation pour :');
      print('Prénom: ${_firstNameController.text}');
      print('Nom: ${_lastNameController.text}');
      print('Email: ${_emailController.text}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Réservation confirmée ! (Simulation)'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlightBloc, FlightState>(
      builder: (context, state) {
        if (state is! FlightPriceLoaded) {
          // Cet état ne devrait pas être visible si le flux est correct,
          // mais c'est une sécurité.
          return const Center(
            child: Text('Veuillez d\'abord sélectionner un vol.'),
          );
        }

        final FlightPriceResponse priceResponse = state.priceResponse;
        final flightOffer = priceResponse.flightOffers.first;
        final bookingRequirements = priceResponse.bookingRequirements;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Section récapitulative du vol
              _buildFlightSummary(flightOffer),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 24),

              // Section formulaire passager
              Text(
                'Informations du passager',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(labelText: 'Prénom'),
                      validator: (value) =>
                      value!.isEmpty ? 'Le prénom est requis' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(labelText: 'Nom de famille'),
                      validator: (value) =>
                      value!.isEmpty ? 'Le nom est requis' : null,
                    ),
                    const SizedBox(height: 16),
                    if (bookingRequirements?.emailAddressRequired ?? false)
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(labelText: 'Adresse e-mail'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'L\'e-mail est requis';
                          }
                          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return 'Veuillez entrer un e-mail valide';
                          }
                          return null;
                        },
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _onConfirmBooking,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Confirmer et Payer'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFlightSummary(FlightOffer flightOffer) {
    return Card(
      elevation: 0,
      color: Colors.grey.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Votre vol sélectionné',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${flightOffer.itineraries.first.segments.first.departure.iataCode} ➔ ${flightOffer.itineraries.first.segments.last.arrival.iataCode}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  '${flightOffer.price.grandTotal} ${flightOffer.price.currency}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.deepPurple),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}