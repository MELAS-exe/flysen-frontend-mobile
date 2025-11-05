import 'package:flutter/material.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/stars.dart';

class HotelProximity extends StatelessWidget {
  final Image logo;
  final Image image;
  final double score;
  final GestureTapCallback? onTap;

  HotelProximity({required this.logo, required this.image, required this.score, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: image,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: 300,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
              border: Border.all(color: Colors.grey, width: 1),
              color: Colors.white,
            ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: 100,
                      child: logo),
                  Stars(score: score),
                ],
              )
          ))
        ],
      ),
    );
  }
}