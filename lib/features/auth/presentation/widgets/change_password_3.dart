import 'package:flutter/material.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_button.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_text_field.dart';
import 'package:flysen_frontend_mobile/core/theme/theme.dart';
import 'package:flysen_frontend_mobile/features/auth/presentation/widgets/login_screen.dart';
import 'package:flysen_frontend_mobile/features/auth/presentation/widgets/register_screen.dart';

class ChangePassword3 extends StatefulWidget {
  @override
  State<ChangePassword3> createState() => _ChangePassword3State();
}

class _ChangePassword3State extends State<ChangePassword3> {
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
          "Entrez votre nouveau mot de passe en bas.",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        SizedBox(height: 40),
        CustomTextField(hintText: "Mot de passe", textHidable: true),
        SizedBox(height: 20),
        CustomTextField(hintText: "Confirmer mot de passe", textHidable: true),

        SizedBox(height: 80),
        CustomButton(
          width: MediaQuery.of(context).size.width,
          height: 60,
          text: "Confirmer",
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
                  child: LoginScreen(),
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
                  child: RegisterScreen(),
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