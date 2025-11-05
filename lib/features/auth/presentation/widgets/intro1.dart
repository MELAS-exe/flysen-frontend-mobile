import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flysen_frontend_mobile/core/theme/theme.dart';

class Intro1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
      Image.asset("assets/images/intro1.jpg", fit: BoxFit.cover, width: double.infinity, height: double.infinity),
      Container(
          alignment: Alignment(-0.6, 0.6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("assets/icons/intro1-text.png"),
              SizedBox(width:240, child:  Text("Dans toute sa beauté", style: TextStyle(color: AppTheme.lightTheme.colorScheme.primary, fontSize: 36, fontWeight: FontWeight.bold),)),
              SizedBox(width:260, child:  Text("Nous vous aidons à découvrir les meilleurs endroits du pays.", style: TextStyle(color: AppTheme.lightTheme.colorScheme.primary, fontSize: 16),)),
            ],
          )),
      ],


    );
  }

}