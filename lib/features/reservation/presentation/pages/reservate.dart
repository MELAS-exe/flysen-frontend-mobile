import 'package:flutter/material.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/top_bar.dart';
import 'package:flysen_frontend_mobile/features/reservation/presentation/widgets/reservation_card.dart';
import 'package:go_router/go_router.dart';

final List<Map<String, dynamic>> reservations = [
  {
    "vol": {
      "date_depart": "2024-08-15T10:00:00Z",
      "compagnie": "Air Sénégal"
    },
    "nombre_personnes": 2
  }
];


class Reservate extends StatefulWidget {
  @override
  State<Reservate> createState() => _ReservateState();
}

class _ReservateState extends State<Reservate> {
  int _value = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 20),
                  Image.asset("assets/icons/app-logo.png", width: 120),
                ],
              ),
              SizedBox(height: 40),
              // Voyager / Séjourner buttons
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                height: 130,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.push("/tripStep1"),
                      child: Image.asset("assets/images/travel-button.png", width: MediaQuery.of(context).size.width / 2.4),
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: () => context.push("/stayStep1"),
                      child: Image.asset("assets/images/hotel-button.png", width: MediaQuery.of(context).size.width / 2.4),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              // Titre et bouton historique
              Row(
                children: [
                  SizedBox(width: 20),
                  Text("Mes voyages et séjours", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Spacer(),
                  GestureDetector(
                    onTap: () => context.push('/history'),
                    child: Image.asset('assets/icons/past.png', width: 30),
                  ),
                  SizedBox(width: 20),
                ],
              ),
              SizedBox(height: 20),
              // Tabs Voyager / Séjourner
              Row(
                children: [
                  SizedBox(width: 20),
                  buildTabButton("Voyages", 1),
                  SizedBox(width: 20),
                  buildTabButton("Séjours", 2),
                ],
              ),
              SizedBox(height: 40),

              if (_value == 1)
                ...reservations.map((r) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ReservationCard(
                    onTap: () {
                      context.push("/tripTicketDetail", extra: r);
                    },
                    airlineLogo: Image.asset("assets/icons/air-senegal.png"),
                    arilineName: r["vol"]["compagnie"] as String? ?? "Air Sénégal",
                    nombrePersonne: (r["nombre_personnes"] as int?) ?? 1,
                    dateDepart: DateTime.parse(r["vol"]["date_depart"] as String? ?? DateTime.now().toString()),
                  ),
                ))
              else
              // Placeholder pour les séjours
                Column(
                  children: List.generate(
                    3,
                        (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: ReservationCard(
                        onTap: () => context.push("/hotelTicketDetail"),
                        airlineLogo: Image.asset("assets/icons/radisson-logo.png"),
                        arilineName: "Radisson Blu Hotel",
                        nombrePersonne: 3,
                        isHotel: true,
                        dateDepart: DateTime.now(),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        Container(
          child: Align(alignment: Alignment.topCenter, child: TopBar()),
        ),
      ],
    );
  }

  Widget buildTabButton(String title, int tabValue) {
    return GestureDetector(
      onTap: () => setState(() => _value = tabValue),
      child: Container(
        width: 100,
        height: 30,
        decoration: BoxDecoration(
          color: _value == tabValue ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(width: 2, color: Colors.black),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: _value == tabValue ? Colors.white : Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}