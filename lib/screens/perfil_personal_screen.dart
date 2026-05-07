import 'package:flutter/material.dart';

import 'personal/perfil_screen.dart';
import 'registro_perfil_screen.dart';
import 'personal_seleccion_screen.dart';

class PerfilPersonalScreen extends StatelessWidget {
  const PerfilPersonalScreen({super.key});

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
                'Personal',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              // Description centered block but text left-aligned
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: const Text(
                  'Registra a tu mascota, lleva un registro,\nconsulta dudas y compra productos\n¡Podrías incluso encontrar un nuevo amigo!',
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

              // Siguiente button -> personal_seleccion_screen
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const PersonalSeleccionScreen()));
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
