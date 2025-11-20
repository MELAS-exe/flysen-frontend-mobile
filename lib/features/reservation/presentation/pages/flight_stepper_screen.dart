import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flysen_frontend_mobile/features/reservation/presentation/bloc/flight/flight_bloc.dart';
import 'package:flysen_frontend_mobile/features/reservation/presentation/pages/trip_step1_form.dart';
import 'package:flysen_frontend_mobile/features/reservation/presentation/pages/trip_step2_results.dart';
import 'package:flysen_frontend_mobile/features/reservation/presentation/pages/trip_step3_passenger.dart';
import 'package:flysen_frontend_mobile/injector.dart';

class FlightStepperScreen extends StatefulWidget {
  const FlightStepperScreen({super.key});

  @override
  State<FlightStepperScreen> createState() => _FlightStepperScreenState();
}

class _FlightStepperScreenState extends State<FlightStepperScreen> {
  int _currentStep = 0;

  // Méthode pour passer à l'étape suivante
  void _onStepContinue() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep += 1;
      });
    }
  }

  // Méthode pour revenir à l'étape précédente
  void _onStepCancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Le Bloc est créé ici et fourni à toutes les étapes enfants
    return BlocProvider(
      create: (context) => getIt<FlightBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Réservation de vol'),
          leading: _currentStep > 0
              ? IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: _onStepCancel,
          )
              : null,
        ),
        body: BlocListener<FlightBloc, FlightState>(
          // Ce Listener écoute les changements d'état pour agir
          listener: (context, state) {
            if (state is FlightLoaded) {
              // Si les vols sont chargés avec succès, passer automatiquement à l'étape 2.
              setState(() {
                _currentStep = 1;
              });
            } else if (state is FlightError) {
              // En cas d'erreur, afficher une SnackBar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Erreur: ${state.message}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Stepper(
            type: StepperType.horizontal,
            currentStep: _currentStep,
            // On désactive le tap pour forcer le flux logique
            onStepTapped: null,
            // On cache les boutons par défaut pour créer les nôtres
            controlsBuilder: (context, details) => const SizedBox.shrink(),
            steps: [
              Step(
                title: const Text('Recherche'),
                content: const TripStep1Form(),
                isActive: _currentStep >= 0,
                state: _currentStep > 0 ? StepState.complete : StepState.indexed,
              ),
              Step(
                title: const Text('Résultats'),
                content: TripStep2Results(onStepContinue: _onStepContinue),
                isActive: _currentStep >= 1,
                state: _currentStep > 1 ? StepState.complete : StepState.indexed,
              ),
              Step(
                title: const Text('Passagers'),
                content: const TripStep3Passenger(),
                isActive: _currentStep >= 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}