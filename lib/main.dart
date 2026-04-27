import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'screens/welcome_screen.dart';
import 'screens/personal/main_shell.dart';
import 'screens/profesional/main_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const GeckoApp());
}

class GeckoApp extends StatelessWidget {
  const GeckoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Faunama',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/personal': (context) => const PersonalMainShell(),
        '/profesional': (context) => const ProfesionalMainShell(),
      },
    );
  }
}
