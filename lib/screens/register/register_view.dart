import 'package:calorie_calculator/screens/register/register.dart';
import 'package:calorie_calculator/utils/validations/form_validation.dart';
import 'package:calorie_calculator/widgets/custom_checkbox.dart';
import 'package:calorie_calculator/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  final RegisterState state;

  const RegisterView(this.state, {super.key});
  @override
  Widget build(BuildContext context) {
    final isDarkMode = state.widget.themeMode == ThemeMode.dark;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height * 0.20,
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
                        ? Colors.black.withAlpha(150)
                        : Colors.white.withAlpha(150),
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
                            onTap: () => _showTermsDialog(context),
                            child: CustomCheckbox(
                              label: 'I agree to the terms & conditions.',
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
        ],
      ),
    );
  }

  void _showTermsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Terms & Conditions'),
          content: const SingleChildScrollView(
            child: Text(
              '''1. Acceptance of Terms
By using this application, you agree to be bound by these terms and conditions.

2. Use of Service
You may use our service for lawful purposes only. You agree not to use the service in any way that could damage, disable, overburden, or impair the service.

3. Privacy Policy
Your privacy is important to us. Please review our Privacy Policy, which also governs your use of the service.

4. User Content
You are responsible for any content you post or transmit through the service. You grant us a non-exclusive, royalty-free license to use, copy, and display such content.

5. Disclaimer
The service is provided "as is" without any warranties, express or implied.

6. Limitation of Liability
In no event shall we be liable for any indirect, incidental, special, consequential, or punitive damages.

7. Changes to Terms
We reserve the right to modify these terms at any time. Continued use of the service constitutes acceptance of modified terms.

8. Governing Law
These terms shall be governed by and construed in accordance with applicable laws.

For questions about these terms, please contact our support team.''',
              style: TextStyle(fontSize: 14),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                state.setAgreement(true);
              },
              child: const Text('Accept'),
            ),
          ],
        );
      },
    );
  }
}
