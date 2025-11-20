import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCounter extends StatefulWidget {
  final VoidCallback increment;
  final VoidCallback decrement;
  final int label;
  const CustomCounter(
      {super.key,
      required this.increment,
      required this.decrement,
      required this.label});

  @override
  State<CustomCounter> createState() => _CustomCounterState();
}

class _CustomCounterState extends State<CustomCounter> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 160.w,
        height: 60,
        padding: EdgeInsets.only(right: 20, left: 20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(200),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          GestureDetector(
            onTap: widget.decrement,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.black,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Image.asset("assets/icons/minus.png"),
              ),
            ),
          ),
          Text("${widget.label}",
              style: TextStyle(fontSize: 14)),
          GestureDetector(
            onTap: widget.increment,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.black,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Image.asset("assets/icons/plus.png"),
              ),
            ),
          ),
        ]));
  }
}
