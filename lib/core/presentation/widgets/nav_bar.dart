import 'package:flutter/material.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/top_bar.dart';
import 'package:flysen_frontend_mobile/core/theme/theme.dart';
import 'package:flysen_frontend_mobile/features/discover/presentation/pages/discover.dart';
import 'package:flysen_frontend_mobile/features/profile/presentation/pages/profile.dart';
import 'package:flysen_frontend_mobile/features/reservation/presentation/pages/reservate.dart';

class NavBar extends StatefulWidget {
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int pageIndex = 0;

  final pages = [Discover(), Discover(), Reservate(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body: SafeArea(
        child: Stack(
          children: [
            pages[pageIndex],
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: buildMyNavBar(context)),
            ),
          ],
        ),
      ),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      width: 240,
      height: 60,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(width: 2, color: Colors.grey)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                pageIndex = 0;
              });
            },
            child: CircleAvatar(
              backgroundColor: pageIndex == 0
                  ? AppTheme.lightTheme.colorScheme.tertiary
                  : Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: pageIndex == 0
                      ? Image.asset("assets/icons/gogles.png")
                      : Image.asset("assets/icons/gogles-white.png"),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                pageIndex = 1;
              });
            },
            child: CircleAvatar(
              backgroundColor: pageIndex == 1
                  ? AppTheme.lightTheme.colorScheme.tertiary
                  : Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: pageIndex == 1
                      ? Image.asset("assets/icons/shopping_cart_black.png")
                      : Image.asset("assets/icons/shopping_cart_white.png"),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                pageIndex = 2;
              });
            },
            child: CircleAvatar(
              backgroundColor: pageIndex == 2
                  ? AppTheme.lightTheme.colorScheme.tertiary
                  : Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: pageIndex == 2
                      ? Image.asset("assets/icons/case.png")
                      : Image.asset("assets/icons/case_white.png"),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                pageIndex = 3;
              });
            },
            child: CircleAvatar(
              backgroundColor: pageIndex == 3
                  ? AppTheme.lightTheme.colorScheme.tertiary
                  : Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: pageIndex == 3
                      ? Image.asset("assets/icons/user.png")
                      : Image.asset("assets/icons/user-white.png"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
