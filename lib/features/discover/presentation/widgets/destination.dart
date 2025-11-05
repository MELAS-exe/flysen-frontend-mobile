import 'package:flutter/material.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/stars.dart';

class Destination extends StatelessWidget {
  final double score;
  final String title;
  final String duration;
  final GestureTapCallback? onTap;
  final String image;

  Destination({
   required this.score,
   required this.title,
   required this.duration,
   this.onTap,
   required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 40,
                height: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15)
                ),
                child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                  child: Image.network(image, fit: BoxFit.fill,),
                ),
              ),
              Positioned(
                  right: 20,
                  bottom: 20,
                  child: Image.asset("assets/icons/more-images.png")),
              Positioned(
                  left: 20,
                  top: 20,
                  child: Stars(
                    score: score
                  )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(title, style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
              width: 20,
              child: Image.asset("assets/icons/airplane-mode.png")),
              SizedBox(width: 10,),
              Text("${duration} heures", style: TextStyle(fontSize: 12),)
            ],
          )
        ],
      ),
    );
  }
}