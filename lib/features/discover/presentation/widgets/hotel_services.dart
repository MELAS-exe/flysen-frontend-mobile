import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HotelServices extends StatelessWidget {
  final Image image;
  HotelServices({required this.image});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 200,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: ClipRRect(borderRadius: BorderRadius.circular(15), child: image),
    );
  }
}
