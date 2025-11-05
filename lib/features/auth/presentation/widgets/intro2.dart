import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flysen_frontend_mobile/core/theme/theme.dart';
import 'package:stroke_text/stroke_text.dart';

class Intro2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
      Image.asset("assets/images/intro2.jpg", fit: BoxFit.cover, width: double.infinity, height: double.infinity),
      Container(
          alignment: Alignment(-0.6, 0.6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("assets/icons/intro2-text.png"),
              SizedBox(width:240, child:  Text("Vos voyages", style: TextStyle(color: AppTheme.lightTheme.colorScheme.primary, fontSize: 36, fontWeight: FontWeight.bold),)),
              SizedBox(width:260, child:  Text("Consultez les tarifs et  les durées des trajets.", style: TextStyle(color: AppTheme.lightTheme.colorScheme.primary, fontSize: 16),)),
            ],
          )),
      ],


    );
  }

}