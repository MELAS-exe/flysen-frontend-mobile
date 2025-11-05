import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_button.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_text_field.dart';
import 'package:flysen_frontend_mobile/core/theme/theme.dart';
import 'package:flysen_frontend_mobile/features/auth/presentation/widgets/otp.dart';
import '../widgets/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _conditionsAccepted = false;
  bool pressed = false;
  TextEditingController prenom = TextEditingController();
  TextEditingController nom = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController telephone = TextEditingController();
  TextEditingController password1 = TextEditingController();
  TextEditingController password2 = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Inscription",
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            "Entrez vos informations en bas.",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 40),
          CustomTextField(hintText: "Prénom", controller: prenom),
          SizedBox(height: 20),
          CustomTextField(hintText: "Nom", controller: nom),
          SizedBox(height: 20),
          CustomTextField(hintText: "Email", controller: email),
          SizedBox(height: 20),
          CustomTextField(hintText: "Téléphone", controller: telephone),
          SizedBox(height: 20),
          CustomTextField(
            hintText: "Mot de passe",
            textHidable: true,
            controller: password1,
          ),
          SizedBox(height: 20),
          CustomTextField(
            hintText: "Confirmer mot de passe",
            textHidable: true,
            controller: password2,
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  Checkbox(
                    checkColor: AppTheme.lightTheme.colorScheme.tertiary,
                    value: _conditionsAccepted,
                    onChanged: (value) {
                      setState(() {
                        _conditionsAccepted = value!;
                      });
                    },
                  ),
                  GestureDetector(
                    child: RichText(
                      text: TextSpan(
                        text: "J'accepte les ",
                        style: TextStyle(
                          color: AppTheme.lightTheme.colorScheme.secondary,
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(
                            text: "conditions d'utilisation",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(),
            ],
          ),
          SizedBox(height: 40),
          if (pressed && (password1.text != password2.text))
            Text(
              "Les mots des passes ne correspondent pas",
              style: TextStyle(color: Colors.red),
            ),
          if (pressed &&
              (password1.text == password2.text && password1.text.length < 8))
            Text(
              "Le mot de passe doit contenir au moins 8 caractères",
              style: TextStyle(color: Colors.red),
            ),
          if (pressed && (_conditionsAccepted == false))
            Text(
              "Acceptez les conditions",
              style: TextStyle(color: Colors.red),
            ),
          if (pressed &&
              (telephone.text.isEmpty ||
                  password1.text.isEmpty ||
                  password2.text.isEmpty ||
                  email.text.isEmpty ||
                  nom.text.isEmpty ||
                  prenom.text.isEmpty))
            Text(
              "Veuillez remplir tous les champs",
              style: TextStyle(color: Colors.red),
            ),
          SizedBox(height: 20),
          CustomButton(
            width: MediaQuery.of(context).size.width,
            height: 60,
            text: "Envoyer",
            onPressed: () async {
              setState(() {
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
                        child: Otp(),
                      );
                    },
                  );
              });

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
                    child: LoginScreen(),
                  );
                },
              );
            },
            child: RichText(
              text: TextSpan(
                text: "Déjà inscrit?",
                style: TextStyle(
                  color: AppTheme.lightTheme.colorScheme.secondary,
                  fontSize: 14,
                ),
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
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
