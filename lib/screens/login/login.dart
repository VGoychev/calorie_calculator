import 'package:calorie_calculator/screens/login/login_view.dart';
import 'package:calorie_calculator/screens/welcome/welcome.dart';
import 'package:calorie_calculator/services/auth_service.dart';
import 'package:calorie_calculator/services/firestore_service.dart';
import 'package:calorie_calculator/services/shared_prefs_service.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<Login> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final TextEditingController passCtrl, emailCtrl;
  final SharedPrefsService _prefsService = SharedPrefsService();
  bool _isInitialized = false;
  final _authService = AuthService();
  final _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    emailCtrl = TextEditingController();
    passCtrl = TextEditingController();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    try {
      await _prefsService.init();
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    }
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (!_isInitialized) return;

    final email = emailCtrl.text.trim();
    final password = passCtrl.text;

    if (!formKey.currentState!.validate()) return;

    String? result =
        await _authService.loginUser(email: email, password: password);

    if (result == null) {
      emailCtrl.clear();
      passCtrl.clear();

      final user = _authService.getCurrentUser();
      if (user != null) {
        await _checkIfNewUser(user.uid, context);
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoginView(this);
  }

  Future<void> loginWithGoogle() async {
    if (!_isInitialized) return;

    final userCredential = await _authService.loginWithGoogle();

    if (userCredential != null) {
      await _checkIfNewUser(userCredential.uid, context);
    }
  }

  Future<void> loginWithFacebook() async {
    if (!_isInitialized) return;

    final userCredential = await _authService.loginWithFacebook();

    if (userCredential != null) {
      await _checkIfNewUser(userCredential.uid, context);
    }
  }

  Future<void> _checkIfNewUser(String uid, BuildContext context) async {
    final userDoc = await _firestoreService.getUserById(uid);

    if (userDoc == null) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1000),
          pageBuilder: (context, animation, secondaryAnimation) => Welcome(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
      return;
    }

    if (userDoc.isNewUser) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1000),
          pageBuilder: (context, animation, secondaryAnimation) => Welcome(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    } else {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }
}
