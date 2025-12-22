import 'package:calorie_calculator/firebase_options.dart';
import 'package:calorie_calculator/root.dart';
import 'package:calorie_calculator/screens/home/home.dart';
import 'package:calorie_calculator/screens/login/login.dart';
import 'package:calorie_calculator/screens/onboarding/onboarding.dart';
import 'package:calorie_calculator/screens/register/register.dart';
import 'package:calorie_calculator/screens/setup/setup.dart';
import 'package:calorie_calculator/screens/welcome/welcome.dart';
import 'package:calorie_calculator/services/shared_prefs_service.dart';
import 'package:calorie_calculator/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RiveFile.initialize();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  try {
    final prefsService = SharedPrefsService();
    await prefsService.init();
    runApp(MyApp(
      prefsService: prefsService,
    ));
  } catch (e) {
    throw ErrorDescription('Error: $e');
  }
}

class MyApp extends StatefulWidget {
  final SharedPrefsService prefsService;
  const MyApp({super.key, required this.prefsService});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calorie Calculator',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      routes: {
        '/': (context) => Root(),
        '/login': (context) => Login(),
        '/register': (context) => Register(),
        '/home': (context) => Home(),
        '/welcome': (context) => Welcome(),
        '/onboarding': (context) => Onboarding(),
        '/setup': (context) => Setup(),
      },
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
    );
  }
}
