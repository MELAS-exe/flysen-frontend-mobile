import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_button.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_text_field.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/top_bar.dart';
import 'package:flysen_frontend_mobile/features/reservation/presentation/pages/trip_step2.dart';
import 'package:go_router/go_router.dart';

class TripStep1 extends StatefulWidget {
  @override
  State<TripStep1> createState() => _TripStep1State();
}

class _TripStep1State extends State<TripStep1> {
  bool isRoundTrip = false;
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
                      "Choisissez votre destination",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 40),
                    Stack(
                      children: [
                        Column(
                          children: [
                            CustomTextField(
                              prefixWidth: 60,
                              hintText: "Départ",
                            ),
                            SizedBox(height: 20,),
                            CustomTextField(
                              prefixWidth: 60,
                              hintText: "Arrivée",
                            ),
                          ],
                        ),
                        Positioned(
                          left: 20,
                          top: 20,
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 10,
                              ),
                              Dash(
                                direction: Axis.vertical,
                                length: 50,
                                dashThickness: 2,
                                dashColor: Colors.grey,
                              ),
                              Image.asset("assets/icons/plane_vertical.png", width: 30,),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Text("Retour", style: TextStyle(fontSize: 14)),
                        SizedBox(width: 5,),
                        Switch(
                          value: isRoundTrip,
                          onChanged: (value) {
                            setState(() {
                              isRoundTrip = value;
                            });
                          },
                          activeColor: Colors.white,
                          activeTrackColor: const Color(0xFF4DC2E0),
                          inactiveThumbColor: Colors.black,
                          inactiveTrackColor: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          isRoundTrip ? 'Oui' : 'Non',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    CustomButton(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      text: "Suivant",
                      onPressed: () {
                        context.push("/tripStep2");
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
