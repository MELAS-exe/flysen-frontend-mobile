import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class TopBar extends StatefulWidget {
  final bool showBack;
  final bool showChatbot;

  TopBar({this.showChatbot = true, this.showBack = false});
  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.showBack
              ? GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Center(
                          child: Image.asset("assets/icons/less-than.png")),
                    ),
                  ),
                )
              : SizedBox(),
          widget.showChatbot
              ? GestureDetector(
                  onTap: () {
                    context.push('/chatbot');
                  },
                  child: Lottie.asset(
                    'assets/icons/chatBot.json',
                    width: 60, // Replace with your path
                    controller: _controller,
                    onLoaded: (composition) {
                      _controller.duration = composition.duration;
                      _controller.value = 0; // Set to the first frame
                    },
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
