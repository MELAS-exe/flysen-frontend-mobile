// Copyright (c) 2022, Adryan Eka Vandra
// https://github.com/adryanev/flutter-template-architecture-template
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flysen_frontend_mobile/features/auth/auth.dart';
import 'package:flysen_frontend_mobile/features/auth/presentation/blocs/bottom_sheet/bottom_sheet_cubit.dart';
import 'package:flysen_frontend_mobile/features/notification_message/presentation/bloc/notification_bloc.dart';
import 'package:flysen_frontend_mobile/firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flysen_frontend_mobile/app/router/app_router.dart';
import 'package:flysen_frontend_mobile/core/extensions/context_extensions.dart';
import 'package:flysen_frontend_mobile/core/utils/constants.dart';
import 'package:flysen_frontend_mobile/injector.dart';
import 'package:flysen_frontend_mobile/l10n/l10n.dart';
import 'package:flysen_frontend_mobile/shared/flash/presentation/blocs/cubit/flash_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(environment: Environment.development);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<FlashCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<NotificationBloc>(),
        ),
        BlocProvider(
            create: (context) => getIt<AuthBloc>(),
        ),
        BlocProvider(create: (context) => getIt<BottomSheetCubit>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<FlashCubit, FlashState>(
            listener: (context, state) {
              switch (state) {
                case FlashDisappeared():
                  break;
                case FlashAppeared():
                  context.showSnackbar(
                    message: state.message,
                  );
              }
            },
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(ScreenUtilSize.width, ScreenUtilSize.height),
          builder: (context, child) {
            return MaterialApp.router(
              scaffoldMessengerKey: rootScaffoldMessengerKey,
              theme: ThemeData(
                useMaterial3: true,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              routerConfig: router(),
              builder: (context, widget) {
                return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(textScaler: TextScaler.noScaling),
                  child: widget!,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
