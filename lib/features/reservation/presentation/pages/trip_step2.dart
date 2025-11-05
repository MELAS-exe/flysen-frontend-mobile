import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_button.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/top_bar.dart';
import 'package:flysen_frontend_mobile/core/theme/theme.dart';
import 'package:flysen_frontend_mobile/features/reservation/presentation/pages/trip_step3.dart';
import 'package:go_router/go_router.dart';

class TripStep2 extends StatefulWidget {
  @override
  State<TripStep2> createState() => _TripStep2State();
}

class _TripStep2State extends State<TripStep2> {
  int _selected = 1;
  @override
  Widget build(BuildContext context) {
    List<DestinationElement> _listDestinations = [
      DestinationElement(
        color: _selected == 1
            ? AppTheme.lightTheme.colorScheme.tertiary
            : Colors.grey,
        companyLogo: Image.asset("assets/icons/air-senegal.png"),
        date: DateTime.now(),
        onTap: () {
          setState(() {
            _selected = 1;
          });
        },
      ),
      DestinationElement(
        color: _selected == 2
            ? AppTheme.lightTheme.colorScheme.tertiary
            : Colors.grey,
        companyLogo: Image.asset("assets/icons/air-senegal.png"),
        date: DateTime.now(),
        onTap: () {
          setState(() {
            _selected = 2;
          });
        },
      ),
      DestinationElement(
        color: _selected == 3
            ? AppTheme.lightTheme.colorScheme.tertiary
            : Colors.grey,
        companyLogo: Image.asset("assets/icons/air-senegal.png"),
        date: DateTime.now(),
        onTap: () {
          setState(() {
            _selected = 3;
          });
        },
      ),
      DestinationElement(
        color: _selected == 4
            ? AppTheme.lightTheme.colorScheme.tertiary
            : Colors.grey,
        companyLogo: Image.asset("assets/icons/air-senegal.png"),
        date: DateTime.now(),
        onTap: () {
          setState(() {
            _selected = 4;
          });
        },
      ),
    ];
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Background image
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Voyager",
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 40),
                  Image.asset("assets/icons/plane-1.png", fit: BoxFit.cover),
                ],
              ),
            ),
            Container(color: Colors.black.withOpacity(0.5)),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Voyages disponibles",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 40),
                    Row(
                      children: [
                        CircleAvatar(backgroundColor: Colors.black, radius: 10),
                        Dash(
                          direction: Axis.horizontal,
                          length: MediaQuery.of(context).size.width / 1.3,
                          dashThickness: 2,
                          dashColor: Colors.grey,
                        ),
                        Image.asset("assets/icons/airplane-mode.png", width: 30),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          "Dakar-AIBD",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Kedougou-AB",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    SizedBox(
                      height: 400,
                      child: SingleChildScrollView(
                        child: Column(
                          children: _listDestinations.map((element) {
                            return Column(
                              children: [element, SizedBox(height: 10)],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Container(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 2,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      text: "Suivant",
                      onPressed: () => context.push('/tripStep3')
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 0,
              right: 0,
              child: TopBar(showBack: true),
            ),
          ],
        ),
      ),
    );
  }
}

class DestinationElement extends StatefulWidget {
  final Image companyLogo;
  final DateTime date;
  final GestureTapCallback? onTap;
  final Color color;

  DestinationElement({
    required this.companyLogo,
    required this.date,
    this.onTap,
    required this.color,
  });
  @override
  State<DestinationElement> createState() => _DestinationElementState();
}

class _DestinationElementState extends State<DestinationElement> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(width: 2, color: widget.color),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Image.asset("assets/icons/calendar-black.png", width: 20),
                  SizedBox(width: 5),
                  Text(
                    "${widget.date.day}/${widget.date.month}/${widget.date.year}",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              Row(
                children: [
                  Image.asset("assets/icons/clock.png", width: 20),
                  SizedBox(width: 5),
                  Text(
                    "${widget.date.hour}h ${widget.date.minute}mn",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              SizedBox(width: 20, child: widget.companyLogo),
            ],
          ),
        ),
      ),
    );
  }
}
