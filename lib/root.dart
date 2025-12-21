import 'package:calorie_calculator/models/user.dart';
import 'package:calorie_calculator/screens/home/home.dart';
import 'package:calorie_calculator/screens/login/login.dart';
import 'package:calorie_calculator/screens/welcome/welcome.dart';
import 'package:calorie_calculator/services/auth_service.dart';
import 'package:calorie_calculator/services/firestore_service.dart';
import 'package:calorie_calculator/widgets/loading_dialog/loading_dialog.dart';
import 'package:flutter/material.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<StatefulWidget> createState() => _RootState();
}

class _RootState extends State<Root> {
  String? _uid;
  bool _showLoader = true;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
    _startLoadingDelay();
  }

  void _startLoadingDelay() {
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _showLoader = false;
        });
      }
    });
  }

  Future<void> _checkAuthStatus() async {
    try {
      final uid = await authService.getCurrentUserId();
      if (!mounted) return;
      bool? isNewUser = await _checkIsNewUser(uid);
      if (isNewUser == true) {
        _uid = 'newUser';
      } else if (isNewUser == null) {
        _uid = 'guest';
      } else {
        _uid = uid;
      }
    } catch (e) {
      if (!mounted) return;
      _uid = 'guest';
    }
  }

  Future<bool?> _checkIsNewUser(String uid) async {
    try {
      final User? user = await firestoreService.getUserById(uid);
      return user!.isNewUser;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (_showLoader) {
      content = const Center(
        child: LoadingDialogWidget(),
      );
    } else if (_uid == 'guest') {
      content = const Login();
    } else if (_uid == 'newUser') {
      content = const Welcome();
    } else {
      content = const Home();
    }
    return Scaffold(
      body: _buildAnimatedTransition(content),
    );
  }

  Widget _buildAnimatedTransition(Widget child) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: child,
    );
  }
}
