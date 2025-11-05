import 'package:flutter/material.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_button.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/top_bar.dart';
import 'package:flysen_frontend_mobile/features/reservation/presentation/pages/trip_step4.dart';
import 'package:go_router/go_router.dart';

class TripStep3 extends StatefulWidget {
  @override
  State<TripStep3> createState() => _TripStep3State();
}

class _TripStep3State extends State<TripStep3> {
  int _nombreEnfant = 0;
  int _nombreAdulte = 0;
  int _nombreBebe = 0;

  incrementEnfant() {
    _nombreEnfant++;
  }

  decrementEnfant() {
    if (_nombreEnfant > 0) {
      _nombreEnfant--;
    }
  }

  incrementAdulte() {
    _nombreAdulte++;
  }

  decrementAdulte() {
    if (_nombreAdulte > 0) _nombreAdulte--;
  }

  incrementBebe() {
    _nombreBebe++;
  }

  decrementBebe() {
    if (_nombreBebe > 0) _nombreBebe--;
  }

  @override
  Widget build(BuildContext context) {
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
                  Image.asset("assets/images/plane-1.png", fit: BoxFit.cover),
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
                      "Nombres de passagers",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 40),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      padding: EdgeInsets.only(right: 10, left: 20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(200),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Nombre d'enfants: ${_nombreEnfant}",
                            style: TextStyle(fontSize: 14),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                decrementEnfant();
                              });
                            },
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.black,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Image.asset("assets/icons/minus.png"),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                incrementEnfant();
                              });
                            },
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.black,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Image.asset("assets/icons/plus.png"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      padding: EdgeInsets.only(right: 10, left: 20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(200),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Nombre d'adultes: ${_nombreAdulte}",
                            style: TextStyle(fontSize: 14),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                decrementAdulte();
                              });
                            },
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.black,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Image.asset("assets/icons/minus.png"),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                incrementAdulte();
                              });
                            },
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.black,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Image.asset("assets/icons/plus.png"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      padding: EdgeInsets.only(right: 10, left: 20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(200),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Nombre de bébés: ${_nombreBebe}",
                            style: TextStyle(fontSize: 14),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                decrementBebe();
                              });
                            },
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.black,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Image.asset("assets/icons/minus.png"),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                incrementBebe();
                              });
                            },
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.black,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Image.asset("assets/icons/plus.png"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    CustomButton(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      text: "Suivant",
                      onPressed: () {
                        context.push('/tripStep4');
                      },
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
