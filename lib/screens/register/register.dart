import 'package:calorie_calculator/screens/register/register_view.dart';
import 'package:calorie_calculator/services/auth_service.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final ThemeMode themeMode;

  const Register(
      {super.key, required this.onToggleTheme, required this.themeMode});

  @override
  State<StatefulWidget> createState() => RegisterState();
}

class RegisterState extends State<Register> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final TextEditingController nameCtrl,
      passCtrl,
      emailCtrl,
      confirmPassCtrl;
  bool _agreedToTerms = false;
  bool _isLoading = false;

  void setAgreement(bool? value) {
    setState(() {
      _agreedToTerms = value ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController();
    emailCtrl = TextEditingController();
    passCtrl = TextEditingController();
    confirmPassCtrl = TextEditingController();
  }

  Future<void> register() async {
    if (!formKey.currentState!.validate()) return;

    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("You must agree to the terms & conditions.")),
      );
      return;
    }

    final name = nameCtrl.text.trim();
    final email = emailCtrl.text.trim();
    final password = passCtrl.text.trim();
    final confirmPassword = confirmPassCtrl.text.trim();

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    setState(() => _isLoading = true); // Start loading

    String? result = await AuthService().registerUser(
      name: name,
      email: email,
      password: passCtrl.text,
    );

    setState(() => _isLoading = false); // Stop loading

    if (result == null) {
      emailCtrl.clear();
      passCtrl.clear();
      confirmPassCtrl.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account created successfully!")),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }
  }

  get agreedToTerms => _agreedToTerms;
  get isLoading => _isLoading;

  @override
  Widget build(BuildContext context) {
    return RegisterView(this);
  }
}
