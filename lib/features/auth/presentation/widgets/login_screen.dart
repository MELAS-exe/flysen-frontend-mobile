import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_button.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_text_field.dart';
import 'package:flysen_frontend_mobile/core/theme/theme.dart';
import 'package:flysen_frontend_mobile/features/auth/presentation/blocs/bottom_sheet_cubit.dart';
import 'package:flysen_frontend_mobile/features/auth/presentation/widgets/register_screen.dart';
import 'package:flysen_frontend_mobile/features/notification_message/domain/repositories/notification_repository.dart';
import 'package:flysen_frontend_mobile/injector.dart';
import 'package:go_router/go_router.dart';
import 'change_password_1.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool pressed = false;

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Connexion",
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Text(
          "Entrez vos informations en bas.",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        SizedBox(height: 40),
        CustomTextField(hintText: "Email", controller: email,),
        SizedBox(height: 20),
        CustomTextField(hintText: "Mot de passe", textHidable: true, controller: password,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(),
            GestureDetector(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  showModalBottomSheet(
                    showDragHandle: true,
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(
                          20,
                          20,
                          20,
                          MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: ChangePassword1(),
                      );
                    },
                  );
                },
                child: Text(
                  "Mot de passe oublié?",
                  style: TextStyle(
                    color: AppTheme.lightTheme.colorScheme.secondary,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 40),
        SizedBox(height: 20),
        CustomButton(
          width: MediaQuery.of(context).size.width,
          height: 60,
          text: "Se connecter",
          // isLoading: authViewModel.isLoading,
          onPressed: () async {
            // context.go('/navigation');
              // Utilisez getIt pour obtenir une instance de votre repository
              final notificationRepo = getIt<NotificationRepository>();

              // Appelez la nouvelle méthode
              final result = await notificationRepo.getFCMToken();

              // Gérer le résultat (optionnel, car il est déjà imprimé dans la console)
              result.fold(
                      (failure) => print('Erreur: ${failure.message}'),
              (token) => print('Token récupéré avec succès depuis lUI.'),
              );
          },
        ),
        SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            showModalBottomSheet(
              showDragHandle: true,
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                    20,
                    20,
                    20,
                    MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: RegisterScreen(),
                );
              },
            );
          },
          child: RichText(
            text: TextSpan(
              text: "Pas de compte?",
              style: TextStyle(
                color: AppTheme.lightTheme.colorScheme.secondary,
                fontSize: 14,
              ),
              children: [
                TextSpan(
                  text: " Créer un compte",
                  style: TextStyle(
                    color: AppTheme.lightTheme.colorScheme.tertiary,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 40),
      ],
    );
  }
}
