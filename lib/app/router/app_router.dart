import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/nav_bar.dart';
import 'package:flysen_frontend_mobile/features/auth/presentation/pages/introduction_slider.dart';
import 'package:flysen_frontend_mobile/features/chatbot/presentation/pages/chatbot.dart';
import 'package:flysen_frontend_mobile/features/reservation/domain/entities/flight_offer.dart';
import 'package:flysen_frontend_mobile/features/reservation/presentation/pages/history.dart';
import 'package:flysen_frontend_mobile/features/reservation/presentation/pages/hotel_ticket_detail.dart';
import 'package:flysen_frontend_mobile/features/reservation/presentation/pages/stay_step1.dart';
import 'package:flysen_frontend_mobile/features/reservation/presentation/pages/stay_step2.dart';
import 'package:flysen_frontend_mobile/features/reservation/presentation/pages/trip_step1.dart';
import 'package:flysen_frontend_mobile/features/reservation/presentation/pages/trip_step2.dart';
import 'package:flysen_frontend_mobile/features/reservation/presentation/pages/trip_step3.dart';
import 'package:flysen_frontend_mobile/features/reservation/presentation/pages/trip_step4.dart';
import 'package:flysen_frontend_mobile/features/reservation/presentation/pages/trip_ticket_detail.dart';
import 'package:go_router/go_router.dart';

class AppRouter extends Equatable {
  static const auth = 'auth';
  static const navigation = 'navigation';
  static const stayStep1 = 'stayStep1';
  static const stayStep2 = 'stayStep2';
  static const tripStep1 = 'tripStep1';
  static const tripStep2 = 'tripStep2';
  static const tripStep3 = 'tripStep3';
  static const tripStep4 = 'tripStep4';
  static const tripTicketDetail = 'tripTicketDetail';
  static const hotelTicketDetail = 'hotelTicketDetail';
  static const history = 'history';
  static const chatBot = 'chatBot';

  @override
  List<Object?> get props => [
        auth,
        navigation,
        stayStep1,
        stayStep2,
        tripStep1,
        tripStep2,
        tripStep3,
        tripStep4,
        tripTicketDetail,
        hotelTicketDetail,
        chatBot,
      ];
}

GoRouter router([String? initialLocation]) => GoRouter(
      debugLogDiagnostics: kDebugMode || kProfileMode,
      initialLocation: initialLocation ?? '/',
      routes: [
        GoRoute(
          path: '/',
          name: AppRouter.auth,
          builder: (context, state) => const IntroductionSlider(),
        ),
        GoRoute(
          path: '/navigation',
          name: AppRouter.navigation,
          builder: (context, state) => NavBar(),
        ),
        GoRoute(
          path: '/stayStep1',
          name: AppRouter.stayStep1,
          builder: (context, state) => StayStep1(),
        ),
        GoRoute(
          path: '/stayStep2',
          name: AppRouter.stayStep2,
          builder: (context, state) => StayStep2(),
        ),
        GoRoute(
          path: '/tripStep1',
          name: AppRouter.tripStep1,
          builder: (context, state) => TripStep1(),
        ),
        GoRoute(
          path: '/tripStep2',
          name: AppRouter.tripStep2,
          builder: (context, state) => TripStep2(),
        ),
        GoRoute(
          path: '/tripStep3',
          name: AppRouter.tripStep3,
          builder: (context, state) => TripStep3(
            flightOffer: state.extra as FlightOffer,
          ),
        ),
        GoRoute(
          path: '/tripStep4',
          name: AppRouter.tripStep4,
          builder: (context, state) => TripStep4(),
        ),
        GoRoute(
          path: '/tripTicketDetail',
          name: AppRouter.tripTicketDetail,
          builder: (context, state) => TripTicketDetail(),
        ),
        GoRoute(
          path: '/hotelTicketDetail',
          name: AppRouter.hotelTicketDetail,
          builder: (context, state) => HotelTicketDetail(),
        ),
        GoRoute(
          path: '/history',
          name: AppRouter.history,
          builder: (context, state) => History(),
        ),
        GoRoute(
          path: '/chatBot',
          name: AppRouter.chatBot,
          builder: (context, state) => ChatBot(),
        )
      ],
    );
