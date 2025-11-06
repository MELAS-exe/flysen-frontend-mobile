import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_button.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_text_field.dart';
import 'package:flysen_frontend_mobile/core/theme/theme.dart';
import 'package:flysen_frontend_mobile/features/auth/auth.dart';
import 'package:flysen_frontend_mobile/features/auth/presentation/widgets/login_screen.dart';

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
  void dispose() {
    prenom.dispose();
    nom.dispose();
    email.dispose();
    telephone.dispose();
    password1.dispose();
    password2.dispose();
    super.dispose();
  }

  bool _validateFields() {
    if (prenom.text.isEmpty ||
        nom.text.isEmpty ||
        email.text.isEmpty ||
        telephone.text.isEmpty ||
        password1.text.isEmpty ||
        password2.text.isEmpty) {
      return false;
    }
    if (password1.text != password2.text) {
      return false;
    }
    if (password1.text.length < 8) {
      return false;
    }
    if (!_conditionsAccepted) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );

          // Auto sign-in after successful registration
          Future.delayed(const Duration(milliseconds: 500), () {
            context.read<AuthBloc>().add(
              SignInRequested(
                email: email.text.trim(),
                password: password1.text,
              ),
            );
          });
        } else if (state is Authenticated) {
          // After auto sign-in, close bottom sheet and navigate
          Navigator.pop(context);
        } else if (state is AuthError) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final isLoading = state is AuthLoading;

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
                CustomTextField(
                  hintText: "Prénom",
                  controller: prenom,
                  enabled: !isLoading,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hintText: "Nom",
                  controller: nom,
                  enabled: !isLoading,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hintText: "Email",
                  controller: email,
                  enabled: !isLoading,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hintText: "Téléphone",
                  controller: telephone,
                  enabled: !isLoading,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hintText: "Mot de passe",
                  textHidable: true,
                  controller: password1,
                  enabled: !isLoading,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hintText: "Confirmer mot de passe",
                  textHidable: true,
                  controller: password2,
                  enabled: !isLoading,
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
                          onChanged: isLoading
                              ? null
                              : (value) {
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
                                color:
                                AppTheme.lightTheme.colorScheme.secondary,
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
                    (password1.text == password2.text &&
                        password1.text.length < 8))
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
                if (isLoading)
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  )
                else
                  CustomButton(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    text: "Envoyer",
                    onPressed: () async {
                      setState(() {
                        pressed = true;
                      });

                      if (_validateFields()) {
                        // Dispatch sign-up event to AuthBloc
                        context.read<AuthBloc>().add(
                          SignUpRequested(
                            email: email.text.trim(),
                            password: password1.text,
                          ),
                        );
                      }
                    },
                  ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: isLoading
                      ? null
                      : () {
                    Navigator.pop(context);
                    showModalBottomSheet(
                      showDragHandle: true,
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return BlocProvider.value(
                          value: context.read<AuthBloc>(),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                              20,
                              20,
                              20,
                              MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: LoginScreen(),
                          ),
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
        },
      ),
    );
  }
}