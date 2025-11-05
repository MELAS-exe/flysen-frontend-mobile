import 'package:flutter/material.dart';
import 'package:flysen_frontend_mobile/core/theme/theme.dart';

class CategoryRow extends StatefulWidget {
  @override
  State<CategoryRow> createState() => _CategoryRowState();
}

class _CategoryRowState extends State<CategoryRow> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 7,
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            height: 2,
            color: Colors.grey,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              spacing: 10,
              children: [
                SizedBox(width: 20),
                CategoryRowElement(
                    image: Image.asset("assets/icons/show-all.png"),
                    title: "Tout",
                    onTap: () {
                      setState(() {
                        _selected = 0;
                      });
                    },
                    selected: _selected == 0 ? true : false),
                CategoryRowElement(
                    image: Image.asset("assets/icons/3-star-hotel.png"),
                    title: "Hôtels",
                    onTap: () {
                      setState(() {
                        _selected = 1;
                      });
                    },
                    selected: _selected == 1 ? true : false),
                CategoryRowElement(
                    image: Image.asset("assets/icons/national-parc.png"),
                    title: "Parcs",
                    onTap: () {
                      setState(() {
                        _selected = 2;
                      });
                    },
                    selected: _selected == 2 ? true : false),
                CategoryRowElement(
                    image: Image.asset("assets/icons/beach.png"),
                    title: "Plage",
                    onTap: () {
                      setState(() {
                        _selected = 3;
                      });
                    },
                    selected: _selected == 3 ? true : false),
                CategoryRowElement(
                    image: Image.asset("assets/icons/monument.png"),
                    title: "Monuments",
                    onTap: () {
                      setState(() {
                        _selected = 4;
                      });
                    },
                    selected: _selected == 4 ? true : false),
                CategoryRowElement(
                  image: Image.asset("assets/icons/forest.png"),
                  title: "Forêts",
                  onTap: () {
                    setState(() {
                      _selected = 5;
                    });
                  },
                  selected: _selected == 5 ? true : false,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CategoryRowElement extends StatelessWidget {
  final Image image;
  final String title;
  final GestureTapCallback? onTap;
  final bool selected;

  CategoryRowElement({
    required this.image,
    required this.title,
    this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(width: 30, child: image),
          // SizedBox(height: 5),
          Text(title, style: TextStyle(fontSize: 16, color: Colors.black)),
          SizedBox(height: 10),
          if (selected)
            Container(
              width: 80,
              height: 5,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.tertiary,
                borderRadius: BorderRadius.circular(10),
              ),
            )
          else
            SizedBox(),

          Container(width: 80, height: 5),
        ],
      ),
    );
  }
}
