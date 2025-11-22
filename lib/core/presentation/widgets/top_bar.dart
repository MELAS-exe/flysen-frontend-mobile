import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  final bool showBack;
  final bool showChatbot;
  final String? title;

  TopBar({this.showChatbot = true, this.showBack = false, this.title});
  @override
  State<TopBar> createState() => _TopBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
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
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        widget.title ?? '',
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
      leading: widget.showBack
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  // Use GoRouter to pop for better navigation stack management if it's used app-wide
                  if (GoRouter.of(context).canPop()) {
                    GoRouter.of(context).pop();
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Center(
                    child: Image.asset(
                  "assets/icons/less-than.png",
                  width: 24.r,
                )),
              ),
            )
          : null,
      actions: [
        if (widget.showChatbot)
          GestureDetector(
            onTap: () {
              context.push('/chatbot');
            },
            child: Lottie.asset(
              'assets/icons/chatBot.json',
              width: 48.r,
              controller: _controller,
              onLoaded: (composition) {
                _controller.duration = composition.duration;
                _controller.value = 0;
              },
            ),
          ),
        SizedBox(width: 16.w), // To match original horizontal padding
      ],
    );
  }
}
