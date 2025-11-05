import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_button.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_text_field.dart';
import 'package:flysen_frontend_mobile/core/theme/theme.dart';
import 'package:flysen_frontend_mobile/features/auth/presentation/widgets/login_screen.dart';

class Otp extends StatefulWidget {
  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {

  final TextEditingController code = TextEditingController();
  bool pressed = false;

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
          "Entrez le code envoyé par mail.",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        SizedBox(height: 40),
        CustomTextField(controller: code,),
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
        if (pressed && (code.text.isEmpty)) Text("Veuillez remplir tous les champs",style: TextStyle(color: Colors.red),),
        SizedBox(height: 20,),
        CustomButton(
          width: MediaQuery.of(context).size.width,
          height: 60,
          text: "S'inscrire",
          // isLoading: authViewModel.isLoading,
          onPressed: () async {
            setState(() {
              pressed = true;
            });
            print("${code.text}");
            // if(authViewModel.user != null ){
            //   authViewModel.verifyOtp(email: authViewModel.user!.email, otpCode: "${code.text}");
            //   if (authViewModel.isVerified) {
            //     Navigator.pushNamed(context, "/navbar");
            //   }
            // }
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
            text: TextSpan(
              text: "Déjà inscrit?",
              style: TextStyle(color: AppTheme.lightTheme.colorScheme.secondary, fontSize: 14),
              children: [
                TextSpan(
                  text: " Connectez vous",
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
        SizedBox(height: 40,)
      ],
    );
  }
}