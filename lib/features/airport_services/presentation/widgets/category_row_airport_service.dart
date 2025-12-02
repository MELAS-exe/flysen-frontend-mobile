import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flysen_frontend_mobile/core/theme/theme.dart';

class CategoryRowAirportService extends StatefulWidget {
  @override
  State<CategoryRowAirportService> createState() =>
      _CategoryRowAirportServiceState();
}

class _CategoryRowAirportServiceState extends State<CategoryRowAirportService> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 7.h,
          child: Container(
            width: 1.sw - 32,
            height: 2.h,
            color: Colors.grey,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              spacing: 8.h,
              children: [
                CategoryRowElement(
                    image:
                        Image.asset("assets/icons/show-all.png", width: 24.r),
                    title: "Tout",
                    onTap: () {
                      setState(() {
                        _selected = 0;
                      });
                    },
                    selected: _selected == 0 ? true : false),
                CategoryRowElement(
                    image: Image.asset("assets/icons/playstation-buttons.png",
                        width: 24.r),
                    title: "Jeux",
                    onTap: () {
                      setState(() {
                        _selected = 1;
                      });
                    },
                    selected: _selected == 1 ? true : false),
                CategoryRowElement(
                    image:
                        Image.asset("assets/icons/recliner.png", width: 24.r),
                    title: "Lounge",
                    onTap: () {
                      setState(() {
                        _selected = 2;
                      });
                    },
                    selected: _selected == 2 ? true : false),
                CategoryRowElement(
                    image: Image.asset("assets/icons/shopping-bag.png",
                        width: 24.r),
                    title: "Boutiques",
                    onTap: () {
                      setState(() {
                        _selected = 3;
                      });
                    },
                    selected: _selected == 3 ? true : false),
                CategoryRowElement(
                    image: Image.asset("assets/icons/food-category.png",
                        width: 24.r),
                    title: "Restaurants",
                    onTap: () {
                      setState(() {
                        _selected = 4;
                      });
                    },
                    selected: _selected == 4 ? true : false),
                // CategoryRowElement(
                //   image: Image.asset("assets/icons/forest.png", width: 24.r),
                //   title: "Forêts",
                //   onTap: () {
                //     setState(() {
                //       _selected = 5;
                //     });
                //   },
                //   selected: _selected == 5 ? true : false,
                // ),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 30, child: image),
          // SizedBox(height: 5),
          Text(title, style: Theme.of(context).textTheme.bodySmall),
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
