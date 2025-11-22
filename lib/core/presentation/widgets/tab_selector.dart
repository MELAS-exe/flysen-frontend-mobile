import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'reusable_tab_button.dart'; // Import the button we just created

class TabSelector<T> extends StatefulWidget {
  const TabSelector({
    super.key,
    required this.options,
    required this.initialValue,
    required this.onSelectionChanged,
  });

  /// A map of values to their corresponding titles. e.g., { 0: 'Flights', 1: 'Hotels' }
  final Map<T, String> options;

  /// The value that should be selected when the widget is first built.
  final T initialValue;

  /// A callback that fires whenever the selection changes, providing the new value.
  final ValueChanged<T> onSelectionChanged;

  @override
  State<TabSelector<T>> createState() => _TabSelectorState<T>();
}

class _TabSelectorState<T> extends State<TabSelector<T>> {
  late T _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.options.entries.map((entry) {
          final value = entry.key;
          final title = entry.value;

          return Padding(
            // Add some spacing between the buttons
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ReusableTabButton<T>(
              title: title,
              value: value,
              height: 32.h,
              groupValue: _currentValue,
              onChanged: (newValue) {
                // Update the internal state to reflect the new selection
                setState(() {
                  _currentValue = newValue;
                });
                // Notify the parent widget of the change
                widget.onSelectionChanged(newValue);
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}