import 'package:flutter/material.dart';

import 'personal/main_shell.dart';

class PersonalSeleccionScreen extends StatefulWidget {
  const PersonalSeleccionScreen({super.key});

  @override
  State<PersonalSeleccionScreen> createState() => _PersonalSeleccionScreenState();
}

class _PersonalSeleccionScreenState extends State<PersonalSeleccionScreen> {
  final _userController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _userController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bg = const Color(0xFFFBF4EA);
    final buttonColor = const Color(0xFFA0BC4D);

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.vertical),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 280,
                    child: const Text('Cuenta', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black), textAlign: TextAlign.left),
                  ),
                  const SizedBox(height: 16),

                  // Compact form container
                  Center(
                    child: SizedBox(
                      width: 280,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextField(
                            controller: _userController,
                            decoration: const InputDecoration(labelText: 'Usuario', labelStyle: TextStyle(color: Colors.black)),
                            style: const TextStyle(color: Colors.black),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: _emailController,
                            decoration: const InputDecoration(labelText: 'Correo', labelStyle: TextStyle(color: Colors.black)),
                            style: const TextStyle(color: Colors.black),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(labelText: 'Contraseña', labelStyle: TextStyle(color: Colors.black)),
                            style: const TextStyle(color: Colors.black),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: _confirmController,
                            obscureText: true,
                            decoration: const InputDecoration(labelText: 'Confirmar contraseña', labelStyle: TextStyle(color: Colors.black)),
                            style: const TextStyle(color: Colors.black),
                          ),

                          const SizedBox(height: 50),

                          // Iniciar button same as empresarial (fixed width 200)
                          Center(
                            child: SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const PersonalMainShell()));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: buttonColor,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Expanded(
                                      child: Center(
                                        child: Text(
                                          'Iniciar',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 36,
                                      height: 36,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFFBF4EA),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.arrow_forward,
                                        color: Colors.black,
                                        size: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
