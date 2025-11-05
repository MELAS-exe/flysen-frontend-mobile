import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ReservationCard extends StatelessWidget {

  final Image airlineLogo;
  final String arilineName;
  final int nombrePersonne;
  final DateTime dateDepart;
  final bool isHotel;
  final GestureTapCallback? onTap;

  ReservationCard({
    this.onTap,
    this.isHotel = false,
    required this.airlineLogo,
    required this.arilineName,
    required this.nombrePersonne,
    required this.dateDepart,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 40,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                "assets/images/hotel.jpg",
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: MediaQuery.of(context).size.width - 40,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
                    border: Border.all(color: Colors.grey, width: 1),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isHotel? Text(arilineName, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)): SizedBox(height: 10,),
                          isHotel? SizedBox(height: 10,): SizedBox(height: 0,),
                          SizedBox(
                              width: 40,
                              child: airlineLogo),
                        ],
                      ),
                      SizedBox(width: 10,),
                      isHotel? SizedBox(): Text(arilineName, style: TextStyle(fontSize: 14)),
                      Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 100,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset("assets/icons/user.png", width: 20),
                                SizedBox(width: 5,),
                                Text("$nombrePersonne personnes", style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          SizedBox(
                            width: 100,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset("assets/icons/calendar-black.png", width: 20),
                                SizedBox(width: 5,),
                                Text("${dateDepart.day}/${dateDepart.month}/${dateDepart.year}", style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  )
              ))
        ],
      ),
    );
  }
}