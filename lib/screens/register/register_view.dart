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
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: state.widget.onToggleTheme,
            icon: Icon(
              isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
              color: isDarkMode ? Colors.black : Colors.white,
              size: 36,
            ),
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: state.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Form(
                  key: state.formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Register',
                        style: TextStyle(fontSize: 32),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: CustomTextFormfield(
                          controller: state.nameCtrl,
                          validator: FormValidation.validateName,
                          label: 'Enter your name',
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: CustomTextFormfield(
                          controller: state.emailCtrl,
                          validator: FormValidation.validateEmail,
                          keyboardType: TextInputType.emailAddress,
                          label: 'Enter your email',
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: CustomTextFormfield(
                          controller: state.passCtrl,
                          validator: FormValidation.validatePassword,
                          obsecure: true,
                          label: 'Enter your password',
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: CustomTextFormfield(
                          controller: state.confirmPassCtrl,
                          validator: FormValidation.validatePassword,
                          obsecure: true,
                          label: 'Confirm password',
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: GestureDetector(
                          onTap: () => _showTermsDialog(context),
                          child: CustomCheckbox(
                            label: 'I agree to the terms & conditions.',
                            value: state.agreedToTerms,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: state.register,
                          child: const Text('Register')),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
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
                // Optionally auto-check the agreement checkbox
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
