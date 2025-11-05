import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_dash/flutter_dash.dart';

class HotelTicket extends StatelessWidget {
  final String hotelName;
  final String chambre;
  final DateTime dateDebut;
  final DateTime dateFin;
  final String classe;
  final int price;
  final Image hotelLogo;

  const HotelTicket({
    Key? key,
    required this.hotelName,
    required this.chambre,
    required this.dateDebut,
    required this.dateFin,
    required this.classe,
    required this.price,
    required this.hotelLogo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dateFormat(DateTime date) {
      final formatter = DateFormat('dd/MM/yyyy');
      return formatter.format(date);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ImageSizedContainer(
        builder:
            (scale) => Padding(
              padding: EdgeInsets.fromLTRB(
                20.0 * scale,
                20.0 * scale,
                15.0 * scale,
                20.0 * scale,
              ),
              child: Row(
                children: [
                  Container(
                    width: 200 * scale,
                    child: Column(
                      children: [
                        Text(
                          "Hotel",
                          style: TextStyle(
                            fontSize: 12 * scale,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 5 * scale),
                        Text(
                          hotelName,
                          style: TextStyle(
                            fontSize: 16 * scale,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5 * scale),
                        SizedBox(height: 30),
                        Text(
                          chambre,
                          style: TextStyle(
                            fontSize: 12 * scale,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5*scale),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  radius: 5 * scale,
                                  backgroundColor: Colors.black,
                                ),
                                Dash(
                                  length: 120 * scale,
                                  direction: Axis.horizontal,
                                  dashColor: Colors.grey,
                                  dashLength: 5 * scale,
                                ),
                                CircleAvatar(
                                  radius: 5 * scale,
                                  backgroundColor: Colors.black,
                                ),
                              ],
                            ),
                            Image.asset("assets/lit.png", scale: 3 / scale),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Début",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12*scale,
                                  ),
                                ),
                                SizedBox(height: 5 * scale),
                                Text(
                                  dateFormat(dateDebut),
                                  style: TextStyle(
                                    fontSize: 14*scale,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "fin",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12*scale,
                                  ),
                                ),
                                SizedBox(height: 5 * scale),
                                Text(
                                  dateFormat(dateFin),
                                  style: TextStyle(
                                    fontSize: 14*scale,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 40*scale),
                  Container(
                    width: 120 * scale,
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                      Image.asset("assets/RadissonLogo.png", scale: 3 / scale),
                      SizedBox(height: 20*scale,),
                      Column(
                        children: [
                          Text(
                            "${price} F CFA",
                            style: TextStyle(
                              fontSize: 16 * scale,
                              fontWeight: FontWeight.bold,)),
                          Text(classe, style: TextStyle(color: Colors.grey, fontSize: 12 * scale)),
                        ],
                      )
                    ]),
                  ),
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
    _loadImage('assets/ticket-hotel.png');
  }

  Future<void> _loadImage(String assetPath) async {
    final imageProvider = AssetImage(assetPath);
    final config = ImageConfiguration();
    imageProvider
        .resolve(config)
        .addListener(
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
                image: AssetImage('assets/ticket-hotel.png'),
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
