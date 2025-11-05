import 'package:flutter/material.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/person_ticket_info.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/top_bar.dart';
import 'package:flysen_frontend_mobile/core/theme/theme.dart';
import 'package:flysen_frontend_mobile/features/reservation/presentation/widgets/flight_ticket.dart';

class TripTicketDetail extends StatefulWidget {
  const TripTicketDetail({super.key});

  @override
  State<TripTicketDetail> createState() => _TripTicketDetailState();
}

class _TripTicketDetailState extends State<TripTicketDetail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.only(left: 20, right: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8), // Semi-transparent white background
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10,
                        children: [
                          PersonTicketInfo(
                            nom: "Abdou Fatah Geye",
                            color: AppTheme.lightTheme.colorScheme.tertiary,
                          ),
                          PersonTicketInfo(nom: "Adja Soukeyna Diop"),
                          PersonTicketInfo(nom: "Mohamed El Amine Sembene"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      SizedBox(width: 20,),
                      Text("Votre vol dans 1 jour", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Image.asset("assets/plane-1.png", scale: 0.5,),
                  FlightTicket(
                    airlineName: "Air Sénégal",
                    departureAirport: "Dakar",
                    departureTime: DateTime(2025, 6, 1, 8, 30),
                    arrivalTime: DateTime(2025, 6, 1, 12, 45),
                    arrivalAirport: "Kédougou",
                    classe: "Business",
                    price: 70000,
                    airlineLogo: Image.asset("assets/air-senegal.png"),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: Align(
                alignment: Alignment.topCenter,
                child: TopBar(showBack: true),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
