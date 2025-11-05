import 'package:flutter/material.dart';
import 'package:flysen_frontend_mobile/core/theme/theme.dart';
import 'package:stroke_text/stroke_text.dart';

class Intro4 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
      Image.asset("assets/images/intro4.jpg", fit: BoxFit.cover, width: double.infinity, height: double.infinity),
      Container(
          alignment: Alignment(-0.6, 0.6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("assets/icons/intro4-text.png"),
              SizedBox(width:240, child:  Text("La réalité augmentée", style: TextStyle(color: AppTheme.lightTheme.colorScheme.primary, fontSize: 36, fontWeight: FontWeight.bold),)),
              SizedBox(width:260, child:  Text("Navigez et informez vous facilement avec la réalité augmentée.", style: TextStyle(color: AppTheme.lightTheme.colorScheme.primary, fontSize: 16),)),
            ],
          )),
      ],


    );
  }

}