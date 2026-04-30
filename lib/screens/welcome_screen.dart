import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'personal/main_shell.dart';
import 'profesional/main_shell.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo o título de la app
              const Icon(
                Icons.pets,
                size: 100,
                color: AppColors.green,
              ),
              const SizedBox(height: 24),
              Text(
                'Faunama',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: AppColors.green,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Cuidado de tus reptiles',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textMedium,
                ),
              ),
              const SizedBox(height: 60),
              // Botón de registro
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TipoCuentaScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 48,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 4,
                ),
                child: const Text(
                  'Registrarse',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Botón de iniciar sesión (opcional)
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TipoCuentaScreen(),
                    ),
                  );
                },
                child: Text(
                  'Iniciar sesión',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Pantalla para seleccionar tipo de cuenta
class TipoCuentaScreen extends StatelessWidget {
  const TipoCuentaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.green,
        foregroundColor: Colors.white,
        title: const Text('Selecciona tu tipo de cuenta'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '¿Qué tipo de cuenta deseas crear?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              // Cuenta Personal
              _TipoCuentaCard(
                titulo: 'Cuenta Personal',
                descripcion: 'Para dueños de reptiles que quieren seguir el cuidado de sus mascotas',
                icono: Icons.person,
                color: AppColors.orange,
                onTap: () {
                  try {
                    Navigator.pushReplacementNamed(context, '/personal');
                  } catch (err, st) {
                    // fallback and show error
                    // ignore: avoid_print
                    print('Navigation error to /personal: $err');
                    // ignore: avoid_print
                    print(st);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => PersonalMainShell(key: PersonalMainShell.globalKey)));
                  }
                },
              ),
              const SizedBox(height: 20),
              // Cuenta Profesional
              _TipoCuentaCard(
                titulo: 'Cuenta Profesional',
                descripcion: 'Para criadores y profesionales del cuidado de reptiles',
                icono: Icons.business,
                color: AppColors.green,
                onTap: () {
                  try {
                    Navigator.pushReplacementNamed(context, '/profesional');
                  } catch (err, st) {
                    // ignore: avoid_print
                    print('Navigation error to /profesional: $err');
                    // ignore: avoid_print
                    print(st);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ProfesionalMainShell()));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TipoCuentaCard extends StatelessWidget {
  final String titulo;
  final String descripcion;
  final IconData icono;
  final Color color;
  final VoidCallback onTap;

  const _TipoCuentaCard({
    required this.titulo,
    required this.descripcion,
    required this.icono,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: color, width: 2),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icono, size: 40, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    descripcion,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textMedium,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: color),
          ],
        ),
      ),
    );
  }
}