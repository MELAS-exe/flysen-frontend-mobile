import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Event extends StatelessWidget {
  final GestureTapCallback? onTap;
  final Image image;
  final String title;
  final String region;
  final String duration;

  const Event({
    super.key,
    this.onTap,
    required this.image,
    required this.title,
    required this.region,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 40,
          height: 200,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: image,
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.width - 40,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(
                0.5,
              ), // Semi-transparent white background
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        SizedBox(
                          width: 150,
                          child: Text(
                            title,
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                              color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                            region,
                            style: TextStyle(
                                color: Colors.white, fontSize: 12)
                        ),
                      ],
                    ),
                    Text(duration, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
