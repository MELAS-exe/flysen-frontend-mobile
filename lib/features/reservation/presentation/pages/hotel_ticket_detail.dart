import 'package:flutter/material.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/person_ticket_info.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/top_bar.dart';
import 'package:flysen_frontend_mobile/core/theme/theme.dart';
import 'package:flysen_frontend_mobile/features/reservation/presentation/widgets/hotel_ticket.dart';

class HotelTicketDetail extends StatefulWidget {
  @override
  State<HotelTicketDetail> createState() => _HotelTicketDetailState();
}

class _HotelTicketDetailState extends State<HotelTicketDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              "assets/hotel.jpg",
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.only(left: 20, right: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(
                        0.8,
                      ), // Semi-transparent white background
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 5,
                        ),
                      ],
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                  HotelTicket(
                    hotelName: "Hôtel du Lac",
                    chambre: "Suite Présidentielle",
                    dateDebut: DateTime(2025, 5, 12),
                    dateFin: DateTime(2025, 5, 15),
                    classe: "5 étoiles",
                    price: 150000,
                    hotelLogo: Image.asset("assets/hotel_logo.png"),
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
