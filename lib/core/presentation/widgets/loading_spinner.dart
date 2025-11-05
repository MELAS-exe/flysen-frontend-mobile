import 'package:flutter/material.dart';

class LoadingSpinner extends StatelessWidget {
  final double size;
  final Color? color;

  const LoadingSpinner({
    Key? key,
    this.size = 48.0,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final spinner = CircularProgressIndicator(
      strokeWidth: 4.0,
      valueColor: AlwaysStoppedAnimation<Color>(
        color ?? Theme.of(context).primaryColor,
      ),
    );

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black.withOpacity(0.5),
          child: SizedBox(width: size, height: size, child: spinner),
        ),
      ),
    );
  }
}
