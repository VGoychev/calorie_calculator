import 'package:calorie_calculator/screens/register/register.dart';
import 'package:calorie_calculator/utils/validations/form_validation.dart';
import 'package:calorie_calculator/widgets/custom_checkbox/custom_checkbox.dart';
import 'package:calorie_calculator/widgets/custom_textformfield/custom_textformfield.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  final RegisterState state;

  const RegisterView(this.state, {super.key});
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height * 0.5,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    isDarkMode
                        ? Colors.black.withAlpha(60)
                        : Colors.white.withAlpha(60),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.095),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Create new profile",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: const Offset(2, 2),
                          blurRadius: 6,
                          color: Colors.black.withAlpha(210),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? Theme.of(context).scaffoldBackgroundColor
                        : Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, -10),
                      ),
                    ],
                  ),
                  child: Form(
                    key: state.formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.only(right: 12, left: 12),
                          child: CustomTextFormfield(
                            controller: state.nameCtrl,
                            validator: FormValidation.validateName,
                            label: 'Enter your name',
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(right: 12, left: 12),
                          child: CustomTextFormfield(
                            controller: state.emailCtrl,
                            validator: FormValidation.validateEmail,
                            keyboardType: TextInputType.emailAddress,
                            label: 'Enter your email',
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(right: 12, left: 12),
                          child: CustomTextFormfield(
                            controller: state.passCtrl,
                            validator: FormValidation.validatePassword,
                            obsecure: true,
                            label: 'Enter your password',
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(right: 12, left: 12),
                          child: CustomTextFormfield(
                            controller: state.confirmPassCtrl,
                            validator: FormValidation.validatePassword,
                            obsecure: true,
                            label: 'Confirm password',
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(right: 12, left: 12),
                          child: GestureDetector(
                            onTap: state.onTermsTap,
                            child: CustomCheckbox(
                              label: 'Terms & conditions.',
                              value: state.agreedToTerms,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: state.register,
                          child: Text(
                            'Sign up',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: size.height * 0.09,
            child: IconButton(
              icon: const ImageIcon(
                AssetImage('assets/icons/back.png'),
                color: Colors.white,
                size: 28,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
