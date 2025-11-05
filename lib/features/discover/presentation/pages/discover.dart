import 'package:flutter/material.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_text_field.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/top_bar.dart';
import 'package:flysen_frontend_mobile/features/discover/presentation/widgets/category_row.dart';
import 'package:flysen_frontend_mobile/features/discover/presentation/widgets/destination.dart';
import 'package:flysen_frontend_mobile/features/discover/presentation/widgets/event.dart';

class Discover extends StatefulWidget {
  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController recherche = TextEditingController();
    final destinationsListes = [
      {
        "nom": "Lac Rose",
        "image1": Image.asset("assets/lac_rose.jpg", fit: BoxFit.cover),
        "nombreEtoiles": 4.5,
        "heureVoyage": 1.0
      },
      {
        "nom": "Île de Gorée",
        "image1": Image.asset("assets/goree.jpeg", fit: BoxFit.cover),
        "nombreEtoiles": 5.0,
        "heureVoyage": 0.5
      },
    ];

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Image.asset(
                    "assets/icons/app-logo.png",
                    width: 120,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CustomTextField(
                  controller: recherche,
                  searchable: true,
                  hintText: "Que voulez vous découvrir?",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CategoryRow(),
              SizedBox(
                height: 40,
              ),
              ...[
                // Only show these if not loading
                Event(
                  image: Image.asset(
                    "assets/event.jpg",
                    fit: BoxFit.fill,
                  ),
                  title: "Festival de musique de Kédougou",
                  region: "Kédougou",
                  duration: "3 jours restants",
                ),
                SizedBox(
                  height: 20,
                ),
                ...destinationsListes.map((e) {
                  return Column(children: [
                    Destination(
                        onTap: () {
                          Navigator.pushNamed(context, "/destination_detail");
                        },
                        score: e["nombreEtoiles"] as double,
                        title: e["nom"] as String,
                        duration: (e["heureVoyage"] as double).toString(),
                        image: ''),
                    SizedBox(
                      height: 20,
                    )
                  ]);
                }).toList()
              ],
              SizedBox(
                height: 80,
              )
            ],
          ),
        ),
        Container(
          child: Align(
            alignment: Alignment.topCenter,
            child: TopBar(),
          ),
        )
      ],
    );
  }
}
