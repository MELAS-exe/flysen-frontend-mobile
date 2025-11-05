import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_dash/flutter_dash.dart';

class FlightTicket extends StatelessWidget {
  final String airlineName;
  final String departureAirport;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final String arrivalAirport;
  final String classe;
  final int price;
  final Image airlineLogo;

  const FlightTicket({
    Key? key,
    required this.airlineName,
    required this.departureAirport,
    required this.departureTime,
    required this.arrivalTime,
    required this.arrivalAirport,
    required this.classe,
    required this.price,
    required this.airlineLogo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Duration getFlightDuration(DateTime departure, DateTime arrival) {
      return arrival.difference(departure);
    }

    String formatDuration(Duration duration) {
      final hours = duration.inHours;
      final minutes = duration.inMinutes.remainder(60);
      return '${hours}h ${minutes}m';
    }

    String formatTime(DateTime time) {
      final formatter = DateFormat('HH:mm'); // 24-hour format
      return formatter.format(time);
    }

    final Image childImage = Image(image: AssetImage("assets/ticket-avion.png"));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ImageSizedContainer(
        builder: (scale) => Padding(
          padding: EdgeInsets.fromLTRB(20.0 * scale, 30.0 * scale, 20.0 * scale, 10.0 * scale),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Scale all dimensions like fontSize, spacing, width, height
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100 * scale,
                    child: Column(
                      children: [
                        Text(
                          departureAirport,
                          style: TextStyle(
                            fontSize: 16 * scale,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text("Départ", style: TextStyle(color: Colors.grey, fontSize: 14 * scale)),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 100 * scale,
                    child: Column(
                      children: [
                        Text("Durée", style: TextStyle(color: Colors.grey, fontSize: 14 * scale)),
                        Text(
                          formatDuration(getFlightDuration(this.departureTime, this.arrivalTime)),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16 * scale, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 100 * scale,
                    child: Column(
                      children: [
                        Text(arrivalAirport,
                            style: TextStyle(fontSize: 16 * scale, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis),
                        Text("Arrivée", style: TextStyle(color: Colors.grey, fontSize: 14 * scale)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40 * scale),
              Row(
                children: [
                  Text(formatTime(departureTime), style: TextStyle(fontSize: 14 * scale)),
                  SizedBox(width: 5 * scale),
                  CircleAvatar(radius: 5 * scale, backgroundColor: Colors.black),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Dash(
                        length: 250 * scale,
                        direction: Axis.horizontal,
                        dashColor: Colors.grey,
                        dashLength: 5 * scale,
                      ),
                      Image.asset("assets/modeavionon.png", scale: 3 / scale),
                    ],
                  ),
                  CircleAvatar(radius: 5 * scale, backgroundColor: Colors.black),
                  SizedBox(width: 5 * scale),
                  Text(formatTime(arrivalTime), style: TextStyle(fontSize: 14 * scale)),
                ],
              ),
              SizedBox(height: 45 * scale),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 50 * scale,
                        height: 50 * scale,
                        child: airlineLogo,
                      ),
                      SizedBox(width: 5 * scale),
                      Text(airlineName, style: TextStyle(fontSize: 14 * scale)),
                    ],
                  ),
                  Column(
                    children: [
                      Text("${price} F CFA", style: TextStyle(fontSize: 16 * scale, fontWeight: FontWeight.bold)),
                      Text(classe, style: TextStyle(color: Colors.grey, fontSize: 12 * scale)),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );

  }
}

class ImageSizedContainer extends StatefulWidget {
  final Widget Function(double scale) builder;
  const ImageSizedContainer({required this.builder});

  @override
  _ImageSizedContainerState createState() => _ImageSizedContainerState();
}

class _ImageSizedContainerState extends State<ImageSizedContainer> {
  ui.Image? image;

  @override
  void initState() {
    super.initState();
    _loadImage('assets/ticket-avion.png');
  }

  Future<void> _loadImage(String assetPath) async {
    final imageProvider = AssetImage(assetPath);
    final config = ImageConfiguration();
    imageProvider.resolve(config).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        setState(() => image = info.image);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        double originalWidth = image!.width.toDouble();
        double originalHeight = image!.height.toDouble();
        double maxWidth = constraints.maxWidth;

        // Scale based on available width
        double scale = maxWidth / originalWidth;
        double height = originalHeight * scale;

        return Center(
          child: Container(
            width: maxWidth,
            height: height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/ticket-avion.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: widget.builder(scale),
          ),
        );
      },
    );
  }
}
