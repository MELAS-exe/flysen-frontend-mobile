import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Stars extends StatelessWidget {
  final double score;
  final bool showContainer;
  Stars({required this.score, this.showContainer = true});

  @override
  Widget build(BuildContext context) {
    // List<Widget> starsList = [];
    // int fullStars = score.floor();
    // bool hasHalfStar = (score - fullStars) >= 0.5;

    // for (int i = 0; i < fullStars; i++) {
    //   starsList.add(
    //     SizedBox(
    //       width: 16.r,
    //       child: Image.asset("assets/icons/star_filled.png")
    //     )
    //   );
    // }
    //
    // if (hasHalfStar) {
    //   starsList.add(
    //     SizedBox(
    //       width: 16.r,
    //       child: Image.asset("assets/icons/star_half_filled.png") // Assuming you have a half-star asset
    //     )
    //   );
    // }
    //
    // int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);
    // for (int i = 0; i < emptyStars; i++) {
    //   starsList.add(
    //     SizedBox(
    //       width: 16.r,
    //       child: Image.asset("assets/icons/star.png") // Assuming you have an empty-star asset
    //     )
    //   );
    // }

    return Row(mainAxisSize: MainAxisSize.min, spacing: 5, children: [
      Text(
        "${score}",
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: Color(0xFFFFA800)),
      ),
      Icon(
        Icons.star,
        color: Color(0xFFFFA800),
        size: 16,
      ),
    ]);
  }
}
