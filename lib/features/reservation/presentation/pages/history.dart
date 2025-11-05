import 'package:flutter/material.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/top_bar.dart';
import 'package:flysen_frontend_mobile/features/reservation/presentation/widgets/reservation_card.dart';

class History extends StatefulWidget {
  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  int _value = 1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 100),
                  Row(
                    children: [
                      SizedBox(width: 20),
                      Text(
                        "Mes voyages et séjours",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _value = 1;
                          });
                        },
                        child: Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                            color: _value == 1 ? Colors.black : Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 2, color: Colors.black),
                          ),
                          child: Center(
                            child: Text(
                              "Voyages",
                              style: TextStyle(
                                color: _value == 1 ? Colors.white : Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _value = 2;
                          });
                        },
                        child: Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                            color: _value == 2 ? Colors.black : Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 2, color: Colors.black),
                          ),
                          child: Center(
                            child: Text(
                              "Sejours",
                              style: TextStyle(
                                color: _value == 2 ? Colors.white : Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  if (_value == 1) ...[
                    ReservationCard(
                      onTap: () => Navigator.pushNamed(context, "/ticket_voyage_detail"),
                      airlineLogo: Image.asset("assets/air-senegal.png"),
                      arilineName: "Air Sénégal",
                      nombrePersonne: 3,
                      dateDepart: DateTime.now(),
                    ),
                    SizedBox(height: 40,),
                    ReservationCard(
                      onTap: () => Navigator.pushNamed(context, "/ticket_voyage_detail"),
                      airlineLogo: Image.asset("assets/air-senegal.png"),
                      arilineName: "Air Sénégal",
                      nombrePersonne: 3,
                      dateDepart: DateTime.now(),
                    ),
                    SizedBox(height: 40,),
                    ReservationCard(
                      onTap: () => Navigator.pushNamed(context, "/ticket_voyage_detail"),
                      airlineLogo: Image.asset("assets/air-senegal.png"),
                      arilineName: "Air Sénégal",
                      nombrePersonne: 3,
                      dateDepart: DateTime.now(),
                    ),
                    SizedBox(height: 40,),
                  ] else
                    ...[
                      ReservationCard(
                        onTap: () => Navigator.pushNamed(context, "/ticket_hotel_detail"),
                        airlineLogo: Image.asset("assets/RadissonLogo.png"),
                        arilineName: "Radisson Blu Hotel",
                        nombrePersonne: 3,
                        isHotel: true,
                        dateDepart: DateTime.now(),
                      ),
                      SizedBox(height: 40,),
                      ReservationCard(
                        onTap: () => Navigator.pushNamed(context, "/ticket_hotel_detail"),
                        airlineLogo: Image.asset("assets/RadissonLogo.png"),
                        arilineName: "Radisson Blu Hotel",
                        nombrePersonne: 3,
                        isHotel: true,
                        dateDepart: DateTime.now(),
                      ),
                      SizedBox(height: 40,),
                      ReservationCard(
                        onTap: () => Navigator.pushNamed(context, "/ticket_hotel_detail"),
                        airlineLogo: Image.asset("assets/RadissonLogo.png"),
                        arilineName: "Radisson Blu Hotel",
                        nombrePersonne: 3,
                        isHotel: true,
                        dateDepart: DateTime.now(),
                      ),
                      SizedBox(height: 40,),
                    ],
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
