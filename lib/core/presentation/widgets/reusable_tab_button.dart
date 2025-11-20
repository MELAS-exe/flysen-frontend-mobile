import 'package:flutter/material.dart';

class ReusableTabButton<T> extends StatelessWidget {
  const ReusableTabButton({
    super.key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.width = 100,
    this.height = 30,
    this.selectedColor = Colors.black,
    this.unselectedColor = Colors.white,
    this.selectedTextColor = Colors.white,
    this.unselectedTextColor = Colors.black,
    this.borderColor = Colors.black,
  });

  /// The text displayed on the button.
  final String title;

  /// The unique value that this button represents.
  final T value;

  /// The currently selected value for the entire group of buttons.
  final T groupValue;

  /// A callback function that is triggered when the button is tapped.
  /// It provides the `value` of this button.
  final ValueChanged<T> onChanged;

  /// Customizable properties for appearance.
  final double width;
  final double height;
  final Color selectedColor;
  final Color unselectedColor;
  final Color selectedTextColor;
  final Color unselectedTextColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    // Determine if this button is the currently selected one.
    final bool isSelected = value == groupValue;

    return GestureDetector(
      // When tapped, call the onChanged callback with this button's value.
      onTap: () => onChanged(value),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : unselectedColor,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(width: 1, color: borderColor),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? selectedTextColor : unselectedTextColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}