import 'package:flutter/material.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_button.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/top_bar.dart';
import 'package:flysen_frontend_mobile/core/theme/theme.dart';
import 'package:go_router/go_router.dart';

class StayStep1 extends StatefulWidget {
  @override
  State<StayStep1> createState() => _StayStep1State();
}

class _StayStep1State extends State<StayStep1> {
  DateTime? _selectedDateDebut;
  DateTime? _selectedDateFin;
  int _nombreEnfant = 0;
  int _nombreAdulte = 0;
  int _nombreBebe = 0;
  int _nombreChambre = 0;

  incrementEnfant(){
    _nombreEnfant++;
  }

  decrementEnfant(){
    if (_nombreEnfant > 0) {
    _nombreEnfant--;
    }
  }

  incrementAdulte(){
    _nombreAdulte++;
  }

  decrementAdulte(){
    if(_nombreAdulte > 0)
    _nombreAdulte--;
  }

  incrementBebe(){
    _nombreBebe++;
  }

  decrementBebe(){
    if(_nombreBebe > 0)
    _nombreBebe--;
  }

  incrementChambre(){
    _nombreChambre++;
  }

  decrementChambre(){
    if(_nombreChambre > 0)
    _nombreChambre--;
  }

  int _value = 1;

  @override
  initState() {
    super.initState();
  }

  Future<void> _selectDateDebut() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateDebut ?? DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      cancelText: "Annuler",
      confirmText: "Valider",
      helpText: "Sélectionnez une date",
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary:
                  AppTheme.lightTheme.colorScheme.tertiary, // Header background
              onPrimary: Colors.white, // Header text
              onSurface: Colors.black, // Body text
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor:
                    AppTheme
                        .lightTheme
                        .colorScheme
                        .tertiary, // Button text color
              ),
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDateDebut = picked;
      });
    }
  }

  Future<void> _selectDateFin() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateFin ?? DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      cancelText: "Annuler",
      confirmText: "Valider",
      helpText: "Sélectionnez une date",
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary:
                  AppTheme.lightTheme.colorScheme.tertiary, // Header background
              onPrimary: Colors.white, // Header text
              onSurface: Colors.black, // Body text
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor:
                    AppTheme
                        .lightTheme
                        .colorScheme
                        .tertiary, // Button text color
              ),
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDateFin = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Background image
            Image.asset(
              "assets/image/hotel.jpg",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(color: Colors.black.withOpacity(0.5)),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "La playa Hotel",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 40),
                    Row(
                      children: [
                        Text("Date de début: ", style: TextStyle(fontSize: 14)),
                        Text(
                          _selectedDateDebut == null
                              ? ''
                              : '${_selectedDateDebut!.day}/${_selectedDateDebut!.month}/${_selectedDateDebut!.year}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () async {
                            _selectDateDebut();
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.black,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Image.asset("assets/icons/calendar.png"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text("Date de fin: ", style: TextStyle(fontSize: 14)),
                        Text(
                          _selectedDateFin == null
                              ? ''
                              : '${_selectedDateFin!.day}/${_selectedDateFin!.month}/${_selectedDateFin!.year}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () async {
                            _selectDateFin();
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.black,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Image.asset("assets/icons/calendar.png"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      padding: EdgeInsets.only(right: 10, left: 20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(200),
                      ),
                      child: Row(
                        children: [
                          Text("Nombre d'enfants: ${_nombreEnfant}",
                              style: TextStyle(fontSize: 14)),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              setState(() {

                                decrementEnfant();
                              });
                            },
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.black,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Image.asset("assets/icons/minus.png"),
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                incrementEnfant();
                              });
                            },
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.black,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Image.asset("assets/icons/plus.png"),
                              ),
                            ),
                          ),
                        ])
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      padding: EdgeInsets.only(right: 10, left: 20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(200),
                      ),
                      child: Row(
                        children: [
                          Text("Nombre d'adultes: ${_nombreAdulte}",
                              style: TextStyle(fontSize: 14)),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                decrementAdulte();
                              });
                            },
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.black,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Image.asset("assets/icons/minus.png"),
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                incrementAdulte();
                              });
                            },
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.black,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Image.asset("assets/icons/plus.png"),
                              ),
                            ),
                          ),
                        ])
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      padding: EdgeInsets.only(right: 10, left: 20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(200),
                      ),
                      child: Row(
                        children: [
                          Text("Nombre de bébés: ${_nombreBebe}",
                              style: TextStyle(fontSize: 14)),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                decrementBebe();
                              });
                            },
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.black,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Image.asset("assets/icons/minus.png"),
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                incrementBebe();
                              });
                            },
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.black,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Image.asset("assets/icons/plus.png"),
                              ),
                            ),
                          ),
                        ])
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      padding: EdgeInsets.only(right: 10, left: 20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(200),
                      ),
                      child: Row(
                        children: [
                          Text("Nombre de chambres: ${_nombreChambre}",
                              style: TextStyle(fontSize: 14)),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                decrementChambre();
                              });
                            },
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.black,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Image.asset("assets/icons/minus.png"),
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                incrementChambre();
                              });
                            },
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.black,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Image.asset("assets/icons/plus.png"),
                              ),
                            ),
                          ),
                        ])
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          "Type de chambre: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      spacing: 20,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _value = 1;
                            });
                          },
                          child: Container(
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                              color: _value == 1 ? Colors.black : Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(width: 2, color: Colors.black),
                            ),
                            child: Center(
                              child: Text(
                                "Standard",
                                style: TextStyle(
                                  color:
                                      _value == 1 ? Colors.white : Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _value = 2;
                            });
                          },
                          child: Container(
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                              color: _value == 2 ? Colors.black : Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(width: 2, color: Colors.black),
                            ),
                            child: Center(
                              child: Text(
                                "Deluxe",
                                style: TextStyle(
                                  color:
                                      _value == 2 ? Colors.white : Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _value = 3;
                            });
                          },
                          child: Container(
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                              color: _value == 3 ? Colors.black : Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(width: 2, color: Colors.black),
                            ),
                            child: Center(
                              child: Text(
                                "Economique",
                                style: TextStyle(
                                  color:
                                      _value == 3 ? Colors.white : Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    CustomButton(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      text: "Suivant",
                      onPressed: () {
                        context.push('/stayStep2');
                      },
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 0,
              right: 0,
              child: TopBar(showBack: true),
            ),
          ],
        ),
      ),
    );
  }
}
