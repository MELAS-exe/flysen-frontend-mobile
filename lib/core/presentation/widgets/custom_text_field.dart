import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flysen_frontend_mobile/core/theme/theme.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final bool textHidable;
  final bool readOnly;
  final bool searchable;
  final double? width;
  final double? height;
  final bool enabled;
  final double prefixWidth;
  final GestureTapCallback? onTap;
  final FocusNode? focusNode; // New: To handle focus state
  final ValueChanged<String>?
      onChanged; // New: To notify parent of text changes
  final FormFieldValidator<String>? validator; // New: For form validation

  const CustomTextField({
    super.key,
    this.prefixWidth = 0,
    this.enabled = true,
    this.readOnly = false,
    this.hintText,
    this.controller,
    this.textHidable = false,
    this.searchable = false,
    this.width,
    this.height,
    this.onTap,
    this.focusNode, // New
    this.onChanged, // New
    this.validator, // New
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = false;

  @override
  void initState() {
    if (widget.textHidable) obscureText = true;
    super.initState();
  }

  Widget? togglePassword() {
    return IconButton(
      onPressed: () {
        setState(() {
          obscureText = !obscureText;
        });
      },
      icon: Icon(!obscureText ? Icons.visibility : Icons.visibility_off),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: widget.width,
          height: widget.height,
          // Use TextFormField instead of TextField to get validation capabilities
          child: TextFormField(
            focusNode: widget.focusNode, // Pass the focus node
            onChanged: widget.onChanged, // Pass the onChanged callback
            validator: widget.validator, // Pass the validator function
            readOnly: widget.readOnly,
            enabled: widget.enabled,
            controller: widget.controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(200),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppTheme.lightTheme.colorScheme.tertiary,
                ),
                borderRadius: BorderRadius.circular(200),
              ),
              prefix: SizedBox(width: widget.prefixWidth),
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(200),
              ),
              // You can customize error style here if you want
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 1),
                borderRadius: BorderRadius.circular(200),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 2),
                borderRadius: BorderRadius.circular(200),
              ),
            ),
          ),
        ),
        if (widget.searchable)
          Container(
            margin: const EdgeInsets.only(right: 20),
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: widget.onTap,
              child: SizedBox(
                width: 30,
                child: Image.asset(
                  "assets/icons/search.png",
                  width: 24.r,
                ),
              ),
            ),
          ),
        if (widget.textHidable)
          Container(
            margin: const EdgeInsets.only(right: 20),
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 30,
              child: togglePassword(),
            ),
          ),
      ],
    );
  }
}
