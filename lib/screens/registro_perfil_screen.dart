import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'perfil_empresarial_screen.dart';
import 'perfil_personal_screen.dart';

class RegistroPerfilScreen extends StatefulWidget {
  const RegistroPerfilScreen({super.key});

  @override
  State<RegistroPerfilScreen> createState() => _RegistroPerfilScreenState();
}

class _RegistroPerfilScreenState extends State<RegistroPerfilScreen> {
  String? _selected; // 'Empresarial' or 'Personal'

  final Color _defaultButton = const Color(0xFFA0BC4D);
  final Color _selectedButton = const Color(0xFFE1677C);
  final Color _bg = const Color(0xFFFBF4EA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 16),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              // Top image
              Image.asset(
                'assets/images/gecko_registro_2.png',
                width: MediaQuery.of(context).size.width * 0.7,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 12),

              // Title
              const Text(
                'Registro',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 0, 0)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // Description
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 380),
                child: const Text(
                  'Selecciona el tipo de cuenta a usar',
                  style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 0, 0)),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 24),

              // Option buttons
              SizedBox(
                width: 320,
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => setState(() => _selected = 'Empresarial'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selected == 'Empresarial' ? _selectedButton : _defaultButton,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const SizedBox(width: double.infinity, child: Center(child: Text('Empresarial', style: TextStyle(fontSize: 14, color: Colors.black)))),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => setState(() => _selected = 'Personal'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selected == 'Personal' ? _selectedButton : _defaultButton,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const SizedBox(width: double.infinity, child: Center(child: Text('Personal', style: TextStyle(fontSize: 14, color: Colors.black)))),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Regresar button
              SizedBox(
                width: 320,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _defaultButton,
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Center(
                          child: Text('Regresar', style: TextStyle(fontSize: 14, color: Colors.black)),
                        ),
                      ),
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(color: _bg, shape: BoxShape.circle),
                        child: Icon(Icons.arrow_back, color: Colors.black, size: 18),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Siguiente button
              SizedBox(
                width: 320,
                child: ElevatedButton(
                  onPressed: () {
                    if (_selected == 'Empresarial') {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const PerfilEmpresarialScreen()));
                      return;
                    }
                    if (_selected == 'Personal') {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const PerfilPersonalScreen()));
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Selecciona un tipo de cuenta')));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _defaultButton,
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Center(child: Text('Siguiente', style: TextStyle(fontSize: 14, color: Colors.black))),
                      ),
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(color: _bg, shape: BoxShape.circle),
                        child: Icon(Icons.arrow_forward, color: Colors.black, size: 18),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
            ),
          ),
        ),
      ),
    );
  }
}
