import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_text_field.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/top_bar.dart';
import 'package:flysen_frontend_mobile/core/theme/theme.dart';
import 'package:flysen_frontend_mobile/core/utils/dimensions.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:lottie/lottie.dart';

class ChatBot extends StatefulWidget {
  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> with SingleTickerProviderStateMixin {
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

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 130,
                  child: Column(
                    children: [
                      Lottie.asset(
                        height: 100,
                        'assets/icons/chatBot.json', // Replace with your asset path
                        controller: _controller,
                        onLoaded: (composition) {
                          _controller.duration = composition.duration;
                          _controller.forward(); // Play the animation once
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      if (isloading)
                        JumpingDots(
                          color: AppTheme.lightTheme.colorScheme.tertiary,
                          radius: 10,
                          numberOfDots: 3,
                          verticalOffset: -5,
                          animationDuration: Duration(milliseconds: 200),
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Salut!",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                      color: AppTheme
                                          .lightTheme.colorScheme.onSurface,
                                      fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Prêt a découvrir  les trésors du Sénégal ?",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                      color: AppTheme.lightTheme.hintColor),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 16.h,
                          children: [
                            GestureDetector(
                                child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    padding: Dimension.aroundPadding,
                                    height: 220.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: AppTheme
                                          .lightTheme.colorScheme.onSurface,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: AppTheme
                                                  .lightTheme
                                                  .colorScheme
                                                  .tertiary,
                                              radius: 16.w,
                                              child: Center(
                                                  child: Image.asset(
                                                      "assets/icons/compass.png", width: 16.w,)),
                                            ),
                                            Image.asset(
                                              "assets/icons/top-right-white.png",
                                              width: 32.w,
                                            )
                                          ],
                                        ),
                                        Text(
                                          "Explorer les destinations",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  color: AppTheme
                                                      .lightTheme.canvasColor,
                                                  fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ))),

                            Column(
                              spacing: 16.w,
                              children: [
                                GestureDetector(
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width / 2.5,
                                        padding: Dimension.aroundPadding,
                                        height: 102.w,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          color: AppTheme
                                              .lightTheme.colorScheme.onSurface,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor: AppTheme
                                                      .lightTheme
                                                      .colorScheme
                                                      .tertiary,
                                                  radius: 16.w,
                                                  child: Center(
                                                      child: Image.asset(
                                                          "assets/icons/calendar-black.png", width: 16.w)),
                                                ),
                                                Image.asset(
                                                  "assets/icons/top-right-white.png",
                                                  width: 32.w,
                                                )
                                              ],
                                            ),
                                            Text(
                                              "Evènements",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      color: AppTheme
                                                          .lightTheme.canvasColor,
                                                      fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ))),
                                GestureDetector(
                                    child: Container(
                                        width:
                                        MediaQuery.of(context).size.width / 2.5,
                                        padding: Dimension.aroundPadding,
                                        height: 102.w,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          color: AppTheme
                                              .lightTheme.colorScheme.onSurface,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor: AppTheme
                                                      .lightTheme
                                                      .colorScheme
                                                      .tertiary,
                                                  radius: 16.w,
                                                  child: Center(
                                                      child: Image.asset(
                                                          "assets/icons/tag.png", width: 16.w)),
                                                ),
                                                Image.asset(
                                                  "assets/icons/top-right-white.png",
                                                  width: 32.w,
                                                )
                                              ],
                                            ),
                                            Text(
                                              "Offres spéciales",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                  color: AppTheme
                                                      .lightTheme.canvasColor,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ))),
                              ],
                            )
                          ],
                        ),

                        // BubbleSpecialThree(
                        //   text: 'Added iMessage shape bubbles',
                        //   color: AppTheme.lightTheme.colorScheme.secondary,
                        //   sent: true,
                        //   tail: true,
                        //   textStyle: TextStyle(
                        //       color: Colors.white,
                        //       fontSize: 16
                        //   ),
                        // ),
                        // BubbleSpecialThree(
                        //   text: 'Sure',
                        //   color: Color(0xFFE8E8EE),
                        //   tail: true,
                        //   isSender: false,
                        // ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  margin: EdgeInsets.only(bottom: 20),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomTextField(
                        hintText: "Posez votre question ici...",
                      ),
                      Positioned(
                        right: 10,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isloading = true;
                            });
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.black,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Image.asset("assets/icons/send.png"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Align(
              alignment: Alignment.topCenter,
              child: TopBar(
                showBack: true,
                showChatbot: false,
              ),
            ),
          )
        ],
      ),
    ));
  }
}
