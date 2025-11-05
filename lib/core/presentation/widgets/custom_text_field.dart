import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flysen_frontend_mobile/core/theme/theme.dart';

class CustomTextField extends StatefulWidget {
  String? hintText;
  TextEditingController? controller;
  bool textHidable;
  bool searchable;
  double? width;
  double? height;
  bool enabled;
  double prefixWidth;
  GestureTapCallback? onTap;

  CustomTextField({
    this.prefixWidth = 0,
    this.enabled = true,
    this.hintText,
    this.controller,
    this.textHidable = false,
    this.searchable = false,
    this.width,
    this.height,
    this.onTap
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  bool obscureText = false;

  @override
  void initState() {
    if(widget.textHidable) obscureText = true;
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
          child: TextField(
            enabled: widget.enabled,
            controller: widget.controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
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
              hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(200),
              ),
            ),
          ),
        ),
        widget.searchable
            ? Container(
              margin: EdgeInsets.only(right: 20),
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: widget.onTap,
                child: SizedBox(
                  width: 30,
                  child: Image.asset("assets/icons/search.png"),
                ),
              ),
            )
            : SizedBox(),
        widget.textHidable
            ? Container(
          margin: EdgeInsets.only(right: 20),
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: 30,
            child: togglePassword(),
          ),
        )
            : SizedBox(),
      ],
    );
  }
}
