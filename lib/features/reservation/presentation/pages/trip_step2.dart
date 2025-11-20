import 'package:flutter/material.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/top_bar.dart';
import 'package:flysen_frontend_mobile/core/theme/theme.dart';
import 'package:flysen_frontend_mobile/core/utils/dimensions.dart';
import 'package:flysen_frontend_mobile/features/reservation/presentation/widgets/destination_element.dart';

class TripStep2 extends StatefulWidget {
  @override
  State<TripStep2> createState() => _TripStep2State();
}

class _TripStep2State extends State<TripStep2> {
  int _selected = 1;
  @override
  Widget build(BuildContext context) {
    List<DestinationElement> _listDestinations = [
      DestinationElement(
        isCheapest: true,
        color: _selected == 1
            ? AppTheme.lightTheme.colorScheme.tertiary
            : Colors.grey,
        companyLogo: Image.asset("assets/icons/air-senegal.png"),
        date: DateTime.now(),
        onTap: () {
          setState(() {
            _selected = 1;
          });
        },
      ),
    ];
    return Scaffold(
      appBar: TopBar(
        showBack: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: Dimension.aroundPadding,
            child: Column(
              children:  _listDestinations.map((element) {
                return Column(
                  children: [element, SizedBox(height: 10)],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
