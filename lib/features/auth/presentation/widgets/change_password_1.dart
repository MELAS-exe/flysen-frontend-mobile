import 'package:flutter/material.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_button.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_text_field.dart';
import 'package:flysen_frontend_mobile/core/theme/theme.dart';
import 'package:flysen_frontend_mobile/features/auth/presentation/widgets/change_password_2.dart';
import 'package:flysen_frontend_mobile/features/auth/presentation/widgets/login_screen.dart';

class ChangePassword1 extends StatefulWidget {
  @override
  State<ChangePassword1> createState() => _ChangePassword1State();
}

class _ChangePassword1State extends State<ChangePassword1> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Changer",
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Text(
          textAlign: TextAlign.center,
          "Entrez votre numéro de téléphone et nous vous enverrons un code.",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        SizedBox(height: 40),
        CustomTextField(hintText: "Numéro de téléphone"),

        SizedBox(height: 80),
        CustomButton(
          width: MediaQuery.of(context).size.width,
          height: 60,
          text: "Envoyer",
          onPressed: () {
            Navigator.pop(context);
            showModalBottomSheet(
              showDragHandle: true,
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20,
                      MediaQuery.of(context).viewInsets.bottom
                  ),
                  child: ChangePassword2(),
                );
              },
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
                  padding: EdgeInsets.fromLTRB(20, 20, 20,
                      MediaQuery.of(context).viewInsets.bottom
                  ),
                  child: LoginScreen(),
                );
              },
            );
          },
          child: RichText(
            text:
                TextSpan(
                  text: " Retourner à la page de connexion",
                  style: TextStyle(
                    color: AppTheme.lightTheme.colorScheme.tertiary,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    fontSize: 14,
                  ),
                ),
            ),
          ),
        SizedBox(height: 40,)
      ],
    );
  }
}