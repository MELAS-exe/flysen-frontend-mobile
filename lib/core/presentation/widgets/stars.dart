import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Stars extends StatelessWidget {
  final double score;
  final bool showContainer;
  Stars({
    required this.score,
    this.showContainer = true
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> starsList = [];
    int fullStars = score.floor();
    bool hasHalfStar = (score - fullStars) >= 0.5;

    for (int i = 0; i < fullStars; i++) {
      starsList.add(
        SizedBox(
          width: 20,
          child: Image.asset("assets/icons/star_filled.png")
        )
      );
    }

    if (hasHalfStar) {
      starsList.add(
        SizedBox(
          width: 20,
          child: Image.asset("assets/icons/star_half_filled.png") // Assuming you have a half-star asset
        )
      );
    }

    int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);
    for (int i = 0; i < emptyStars; i++) {
      starsList.add(
        SizedBox(
          width: 20,
          child: Image.asset("assets/icons/star.png") // Assuming you have an empty-star asset
        )
      );
    }

    return Container(
      width: 150,
      height: 40,
      padding: showContainer? EdgeInsets.symmetric(horizontal: 10): EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100)
      ),
      child: Center(
        child: Row(
          spacing: 5,
          mainAxisAlignment: showContainer? MainAxisAlignment.center: MainAxisAlignment.start, // Center stars horizontally
          children: starsList,
        ),
      ),
    );
  }
}