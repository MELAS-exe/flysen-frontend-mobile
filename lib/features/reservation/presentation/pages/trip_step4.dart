import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_button.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_text_field.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/top_bar.dart';
import 'package:flysen_frontend_mobile/core/theme/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class TripStep4 extends StatefulWidget {
  @override
  State<TripStep4> createState() => _TripStep4State();
}

class _TripStep4State extends State<TripStep4> {
  DateTime? _selectedDateNaissance;
  DateTime? _selectedDateExpiration;
  File? _selectedImage;
  int _value = 1;
  String dropdownGenreValue = "Homme";
  String dropdownIdValue = "CIN";

  Future<void> _selectDateNaissance() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateNaissance ?? DateTime.now(),
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
        _selectedDateNaissance = picked;
      });
    }
  }

  Future<void> _selectDateExpiration() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateExpiration ?? DateTime.now(),
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
        _selectedDateExpiration = picked;
      });
    }
  }

  Future _pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage!.path);
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Background image
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Voyager",
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 40),
                  Image.asset("assets/images/plane-1.png", fit: BoxFit.cover),
                ],
              ),
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
                      "Nombres de passagers",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 40),
                    CustomTextField(
                      hintText: "Nom complet",
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Text("Date de naissance: ", style: TextStyle(fontSize: 14)),
                        Text(
                          _selectedDateNaissance == null
                              ? ''
                              : '${_selectedDateNaissance!.day}/${_selectedDateNaissance!.month}/${_selectedDateNaissance!.year}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () async {
                            _selectDateNaissance();
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
                    SizedBox(height: 20,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      padding: EdgeInsets.only(right: 10, left: 20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(200),
                      ),
                      child: Center(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          underline: Container(),
                          value: dropdownGenreValue,
                          icon: const Icon(Icons.arrow_drop_down),
                          elevation: 16,
                          style: const TextStyle(color: Colors.black),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownGenreValue = value!;
                            });
                          },
                          items: <String>["Homme", "Femme"]
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      padding: EdgeInsets.only(right: 10, left: 20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(200),
                      ),
                      child: Center(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          underline: Container(),
                          value: dropdownIdValue,
                          icon: const Icon(Icons.arrow_drop_down),
                          elevation: 16,
                          style: const TextStyle(color: Colors.black),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownIdValue = value!;
                            });
                          },
                          items: <String>["CIN", "Passeport"]
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Text("Date d'expiration: ", style: TextStyle(fontSize: 14)),
                        Text(
                          _selectedDateExpiration == null
                              ? ''
                              : '${_selectedDateExpiration!.day}/${_selectedDateExpiration!.month}/${_selectedDateExpiration!.year}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () async {
                            _selectDateExpiration();
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
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Text("Copie du document : ", style: TextStyle(fontSize: 14)),
                        _selectedImage != null ? Row(
                          children: [
                            Image.asset("assets/icons/image.png", width: 30),
                            SizedBox(width: 5,),
                            Text(
                              _selectedImage!.path.split('/').last,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ) : SizedBox(),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            _pickImageFromGallery();
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.black,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Image.asset("assets/icons/paperclip.png"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
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
                                "Première",
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
                                "Business",
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
                        context.go('/navigation');
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

class DestinationElement extends StatefulWidget {
  final Image companyLogo;
  final DateTime date;
  final GestureTapCallback? onTap;
  final Color color;

  DestinationElement({
    required this.companyLogo,
    required this.date,
    this.onTap,
    required this.color,
  });
  @override
  State<DestinationElement> createState() => _DestinationElementState();
}

class _DestinationElementState extends State<DestinationElement> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(width: 2, color: widget.color),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Image.asset("assets/icons/calendar-black.png", width: 20),
                  SizedBox(width: 5),
                  Text(
                    "${widget.date.day}/${widget.date.month}/${widget.date.year}",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              Row(
                children: [
                  Image.asset("assets/icons/clock.png", width: 20),
                  SizedBox(width: 5),
                  Text(
                    "${widget.date.hour}h ${widget.date.minute}mn",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              SizedBox(width: 20, child: widget.companyLogo),
            ],
          ),
        ),
      ),
    );
  }
}
