import 'package:flutter/material.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/top_bar.dart';
import 'package:flysen_frontend_mobile/core/theme/theme.dart';
import 'package:flysen_frontend_mobile/features/airport_services/presentation/pages/airport_services_page.dart';
import 'package:flysen_frontend_mobile/features/discover/presentation/pages/discover.dart';
import 'package:flysen_frontend_mobile/features/profile/presentation/pages/profile.dart';
import 'package:flysen_frontend_mobile/features/reservation/presentation/pages/reservate.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key}); // Add super.key for good practice

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _pageIndex = 0;
  // Create a PageController to control the PageView
  late final PageController _pageController;

  // Keep a single instance of each page to preserve their state.
  final List<Widget> _pages = [
    const Discover(), // Add const
    const AirportServicesPage(
        // Add const
        airportId: "550e8400-e29b-41d4-a716-446655440001",
        airportName: "Aéroport de Dakar-Blaise Diagne"),
    Reservate(), // Add const
    Profile() // Add const
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose(); // Always dispose of controllers
    super.dispose();
  }

  // Method to handle page changes from both taps and swipes
  void _onPageChanged(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  // Method to handle taps on the navigation bar items
  void _onNavItemTapped(int index) {
    // Use the controller to animate to the new page
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The TopBar is now part of the main scaffold, not individual pages
      appBar: TopBar(),
      body: SafeArea(
        child: Stack(
          children: [
            // Use PageView to enable swiping and preserve state
            PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged, // Called when a swipe completes
              children: _pages, // Use the list of page widgets
            ),
            // Your custom navigation bar remains at the bottom
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: _buildMyNavBar(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyNavBar(BuildContext context) {
    return Container(
      width: 240,
      height: 60,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
              width: 2, color: Colors.grey.shade300)), // Lighter grey
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
              0, "assets/icons/gogles.png", "assets/icons/gogles-white.png"),
          _buildNavItem(1, "assets/icons/shopping_cart_black.png",
              "assets/icons/shopping_cart_white.png"),
          _buildNavItem(
              2, "assets/icons/case.png", "assets/icons/case_white.png"),
          _buildNavItem(
              3, "assets/icons/user.png", "assets/icons/user-white.png"),
        ],
      ),
    );
  }

  // Helper widget to reduce code duplication for nav items
  Widget _buildNavItem(int index, String activeIcon, String inactiveIcon) {
    final bool isSelected = _pageIndex == index;
    return GestureDetector(
      onTap: () => _onNavItemTapped(index),
      child: CircleAvatar(
        radius: 22, // Slightly smaller for better padding
        backgroundColor: isSelected
            ? AppTheme.lightTheme.colorScheme.tertiary
            : Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(isSelected ? activeIcon : inactiveIcon),
        ),
      ),
    );
  }
}
