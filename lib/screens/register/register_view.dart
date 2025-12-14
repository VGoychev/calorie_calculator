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
                            onTap: () => _showTermsBottomSheet(context),
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

  void _showTermsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      '''
  1. Acceptance of Terms
  By using this application, you agree to be bound by these terms and conditions.

  2. Use of Service
  You may use our service for lawful purposes only.

  3. Privacy Policy
  Your privacy is important to us. Please review our Privacy Policy.

  4. User Content
  You are responsible for any content you post or transmit through the service.

  5. Disclaimer
  The service is provided "as is" without any warranties, express or implied.

  6. Limitation of Liability
  In no event shall we be liable for any indirect, incidental, special, consequential, or punitive damages.

  7. Changes to Terms
  We reserve the right to modify these terms at any time.

  8. Governing Law
  These terms shall be governed by and construed in accordance with applicable laws.

  For questions about these terms, please contact our support team.
                        ''',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 32, 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        state.setAgreement(true);
                      },
                      child: Text(
                        'Accept',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Close',
                          style: Theme.of(context).textTheme.bodyLarge),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
