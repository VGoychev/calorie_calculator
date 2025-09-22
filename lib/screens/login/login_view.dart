import 'package:calorie_calculator/screens/login/login.dart';
import 'package:calorie_calculator/screens/register/register.dart';
import 'package:calorie_calculator/utils/validations/form_validation.dart';
import 'package:calorie_calculator/widgets/custom_textformfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginView extends StatelessWidget {
  final LoginState state;

  const LoginView(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        title: Text(
          "Nutrition counting simplified.",
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                  offset: Offset(2, 2),
                  blurRadius: 6,
                  color: Colors.black.withOpacity(0.8)),
              Shadow(
                  offset: Offset(0, 0),
                  blurRadius: 12,
                  color: Colors.black.withOpacity(0.7)),
            ],
          ),
        ),
        flexibleSpace: ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).colorScheme.onPrimary.withOpacity(0.6),
                Colors.transparent,
              ],
              stops: [0.7, 1],
            ).createShader(bounds);
          },
          blendMode: BlendMode.dstIn,
          child: Image.asset(
            'assets/images/login_screen_img.avif',
            fit: BoxFit.cover,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: state.formKey,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Image.asset(
                'assets/icons/app_logo.png',
                width: 100,
              ),
              const SizedBox(height: 10),
              Text(
                'Sign in',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: CustomTextFormfield(
                  controller: state.emailCtrl,
                  validator: FormValidation.validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  label: 'Enter your email',
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: CustomTextFormfield(
                  controller: state.passCtrl,
                  validator: FormValidation.validatePassword,
                  obsecure: true,
                  keyboardType: TextInputType.text,
                  label: 'Enter your password',
                ),
              ),
              ElevatedButton(
                  onPressed: state.login,
                  child: const Text(
                    'Log in',
                    style: TextStyle(color: Colors.white),
                  )),
              const SizedBox(height: 10),
              SignInButton(
                isDarkMode ? Buttons.Apple : Buttons.AppleDark,
                onPressed: () {},
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              ),
              const SizedBox(height: 2),
              SignInButton(
                isDarkMode ? Buttons.Google : Buttons.GoogleDark,
                onPressed: state.loginWithGoogle,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              ),
              const SizedBox(height: 2),
              SignInButton(
                Buttons.FacebookNew,
                onPressed: state.loginWithFacebook,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: "Don't have an account? ",
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: 'Register here.',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 500),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      Register(
                                onToggleTheme: state.widget.onToggleTheme,
                                themeMode: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? ThemeMode.dark
                                    : ThemeMode.light,
                              ),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20), // Extra space at the bottom
            ],
          ),
        ),
      ),
    );
  }
}
