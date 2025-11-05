import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PersonTicketInfo extends StatefulWidget {
  final String nom;
  final Color color;
  PersonTicketInfo(
  {
    required this.nom,
    this.color = Colors.black
}
      );
  @override
  State<PersonTicketInfo> createState() => _PersonTicketInfoState();
}

class _PersonTicketInfoState extends State<PersonTicketInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets .all(10),
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(100)
          ),
          child: Center(
            child: Image.asset(widget.color == Colors.black? "assets/utilisateursexeneutre-white.png": "assets/utilisateursexeneutre.png")
          ),
        ),
        SizedBox(height: 10,),
        SizedBox(
            width: 100,
            child: Text(widget.nom, maxLines: 2, textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, overflow: TextOverflow.ellipsis, ) ,))
      ],
    );
  }
}