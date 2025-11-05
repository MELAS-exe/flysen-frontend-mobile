import 'package:flutter/material.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_button.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_text_field.dart';

import 'package:flysen_frontend_mobile/core/theme/theme.dart';
import 'package:flysen_frontend_mobile/features/auth/presentation/widgets/change_password_3.dart';
import 'package:flysen_frontend_mobile/features/auth/presentation/widgets/register_screen.dart';

class ChangePassword2 extends StatefulWidget {
  @override
  State<ChangePassword2> createState() => _ChangePassword2State();
}

class _ChangePassword2State extends State<ChangePassword2> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Vérification",
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Text(
          "Entrez le code envoyé par SMS.",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(width: 40, height: 40,),
            SizedBox(width: 20),
            CustomTextField(width: 40, height: 40,),
            SizedBox(width: 20),
            CustomTextField(width: 40, height: 40,),
            SizedBox(width: 20),
            CustomTextField(width: 40, height: 40,),
            SizedBox(width: 20),
            CustomTextField(width: 40, height: 40,),
            SizedBox(width: 20),
            CustomTextField(width: 40, height: 40,),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Renvoyer le code",
                  style: TextStyle(
                      color: AppTheme.lightTheme.colorScheme.secondary,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w700,
                      fontSize: 14
                  ),
                ),
              ),
            ),
            SizedBox(),
          ],
        ),
        SizedBox(height: 80),
        CustomButton(
          width: MediaQuery.of(context).size.width,
          height: 60,
          text: "Suivant",
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
                  child: ChangePassword3(),
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