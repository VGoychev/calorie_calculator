import 'package:calorie_calculator/data/models/user.dart';
import 'package:calorie_calculator/firebase_options.dart';
import 'package:calorie_calculator/screens/login/login.dart';
import 'package:calorie_calculator/services/shared_prefs_service.dart';
import 'package:calorie_calculator/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:rive/rive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  await RiveFile.initialize();
  await Hive.initFlutter(appDocumentDir.path);
  Hive.registerAdapter(UserAdapter());
  
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
  late ThemeMode _themeMode;
  @override
  void initState() {
    super.initState();
    _themeMode =
        widget.prefsService.getThemeMode() ? ThemeMode.dark : ThemeMode.light;
  }

  void _toggleTheme() async {
    final isDark = _themeMode == ThemeMode.dark;
    final newMode = isDark ? ThemeMode.light : ThemeMode.dark;
    await widget.prefsService.setThemeMode(!isDark);
    setState(() => _themeMode = newMode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calorie Calculator',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      home: Login(onToggleTheme: _toggleTheme, themeMode: _themeMode),
      debugShowCheckedModeBanner: false,
    );
  }
}
