import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'screens/welcome_screen.dart';
import 'screens/personal/main_shell.dart';
import 'screens/profesional/main_shell.dart';
import 'data/mock_data.dart';

void main() async {
  // Catch uncaught async errors
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Global Flutter error handler
    FlutterError.onError = (FlutterErrorDetails details) {
      // Print to console so runZonedGuarded can also catch
      FlutterError.dumpErrorToConsole(details);
    };

    await MockData.init();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    // Show error details in the UI when a build/paint error occurs.
    ErrorWidget.builder = (FlutterErrorDetails details) {
      // ignore: avoid_print
      print('ErrorWidget caught: ${details.exception}');
      return Material(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Text('Error en la UI:\n\n${details.exceptionAsString()}\n\n${details.stack}',
                style: const TextStyle(color: Colors.red)),
          ),
        ),
      );
    };

    runApp(const GeckoApp());
  }, (error, stack) {
    // ignore: avoid_print
    print('Uncaught error in zone: $error');
    // ignore: avoid_print
    print(stack);
  });
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
        '/personal': (context) => PersonalMainShell(key: PersonalMainShell.globalKey),
        '/profesional': (context) => const ProfesionalMainShell(),
      },
    );
  }
}
