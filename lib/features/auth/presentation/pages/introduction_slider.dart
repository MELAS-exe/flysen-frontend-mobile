import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flysen_frontend_mobile/core/theme/theme.dart';
import 'package:flysen_frontend_mobile/features/auth/auth.dart';
import 'package:flysen_frontend_mobile/features/auth/presentation/widgets/intro1.dart';
import 'package:flysen_frontend_mobile/features/auth/presentation/widgets/intro2.dart';
import 'package:flysen_frontend_mobile/features/auth/presentation/widgets/intro3.dart';
import 'package:flysen_frontend_mobile/features/auth/presentation/widgets/intro4.dart';
import 'package:flysen_frontend_mobile/injector.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroductionSlider extends StatefulWidget {
  const IntroductionSlider({super.key});

  @override
  State<IntroductionSlider> createState() => _IntroductionSliderState();
}

class _IntroductionSliderState extends State<IntroductionSlider> {
  PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(CheckAuthStatus());
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // If user is already authenticated, navigate directly to NavBar
        if (state is Authenticated) {
          context.go('/navigation');
        }
        // Note: Unauthenticated state is ignored here as it's the default for intro screen
      },
      child: Scaffold(
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
              children: [Intro1(), Intro2(), Intro3(), Intro4()],
            ),
            Container(
              alignment: Alignment(0, 0.90),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SmoothPageIndicator(
                    effect: WormEffect(
                      activeDotColor:
                      AppTheme.lightTheme.colorScheme.secondary,
                      dotColor: AppTheme.lightTheme.colorScheme.primary,
                    ),
                    controller: _pageController,
                    count: 4,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: 170,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppTheme.lightTheme.colorScheme.secondary,
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(),
                          Text(
                            "Allons-y",
                            style: AppTheme.lightTheme.textTheme.bodyLarge!
                                .copyWith(
                              color:
                              AppTheme.lightTheme.colorScheme.primary,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.read<AuthBloc>().add(
                                const SignInAnonymouslyRequested(),
                              );
                              // showModalBottomSheet(
                              //   showDragHandle: true,
                              //   isScrollControlled: true,
                              //   context: context,
                              //   builder: (BuildContext context) {
                              //     // Provide AuthBloc to the LoginScreen
                              //     return BlocProvider.value(
                              //       value: context.read<AuthBloc>(),
                              //       child: Padding(
                              //         padding: EdgeInsets.fromLTRB(
                              //           20,
                              //           20,
                              //           20,
                              //           MediaQuery.of(context)
                              //               .viewInsets
                              //               .bottom,
                              //         ),
                              //         child: LoginScreen(),
                              //       ),
                              //     );
                              //   },
                              // );
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color:
                                AppTheme.lightTheme.colorScheme.tertiary,
                              ),
                              child: Center(
                                child: Image.asset(
                                  "assets/icons/arrow-right.png",
                                  scale: 3.2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}