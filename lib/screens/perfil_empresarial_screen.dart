import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'personal/perfil_screen.dart';
import 'registro_perfil_screen.dart';
import 'empresarial_seleccion_screen.dart';

class PerfilEmpresarialScreen extends StatelessWidget {
  const PerfilEmpresarialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bg = const Color(0xFFFBF4EA);

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Arc with logo centered
              ClipPath(
                clipper: BottomArcClipper(),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
                  color: const Color(0xFFA0BC4D),
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 120,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              SizedBox(
               height: MediaQuery.of(context).size.height * 0.10, // 20% de la altura de la pantalla
              ),

              // Title
              const Text(
                'Empresarial',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              // Description centered block but text left-aligned
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: const Text(
                  'Registra tu clínica veterinaria y lleva un registro con seguimiento personalizado de tus pacientes ¡Mejora el orden y la productividad de tu clínica!',
                  style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 0, 0)),
                  textAlign: TextAlign.left,
                ),
              ),

              SizedBox(
               height: MediaQuery.of(context).size.height * 0.10, // 20% de la altura de la pantalla
              ),

              // Regresar button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const RegistroPerfilScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA0BC4D),
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Row(
                      children: [
                        const Expanded(child: Center(child: Text('Regresar', style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 0, 0))))),
                        Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(color: Color(0xFFFBF4EA), shape: BoxShape.circle),
                          child: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Siguiente button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const EmpresarialSeleccionScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA0BC4D),
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Row(
                      children: [
                        const Expanded(child: Center(child: Text('Siguiente', style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 0, 0))))),
                        Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(color: Color(0xFFFBF4EA), shape: BoxShape.circle),
                          child: const Icon(Icons.arrow_forward, color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
