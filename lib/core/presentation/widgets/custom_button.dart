import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flysen_frontend_mobile/core/theme/theme.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final Function onPressed;
  final double fontSize;
  final bool isLoading;

  CustomButton({
    this.isLoading = false,
    required this.width,
    required this.height,
    required this.text,
    required this.onPressed,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => isLoading? (){} : onPressed(),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),

          color: AppTheme.lightTheme.colorScheme.tertiary,
        ),
        child: Center(
          child: isLoading? CircularProgressIndicator(
            color: Colors.black,
          ): Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppTheme.lightTheme.colorScheme.secondary,
              fontSize: fontSize,
            ),
          ),
        ),
      ),
    );
  }
}
