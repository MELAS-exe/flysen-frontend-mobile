import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_button.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_text_field.dart';
import 'package:flysen_frontend_mobile/core/theme/theme.dart';
import 'package:flysen_frontend_mobile/features/auth/auth.dart';
import 'package:flysen_frontend_mobile/features/auth/presentation/widgets/register_screen.dart';
import 'package:go_router/go_router.dart';
import 'change_password_1.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          // Success! Navigate to NavBar
          Navigator.pop(context); // Close the bottom sheet
          context.go('/navigation');
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
              CustomTextField(
                hintText: "Email",
                controller: email,
                enabled: !isLoading,
              ),
              SizedBox(height: 20),
              CustomTextField(
                hintText: "Mot de passe",
                textHidable: true,
                controller: password,
                enabled: !isLoading,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(),
                  GestureDetector(
                    child: TextButton(
                      onPressed: isLoading
                          ? null
                          : () {
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
                  SizedBox(),
                ],
              ),
              SizedBox(height: 80),
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
                  text: "Se connecter",
                  onPressed: () {
                    // Dispatch sign-in event to AuthBloc
                    context.read<AuthBloc>().add(
                      SignInRequested(
                        email: email.text.trim(),
                        password: password.text,
                      ),
                    );
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
                        text: " Créez en un",
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
        },
      ),
    );
  }
}