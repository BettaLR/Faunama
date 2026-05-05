import 'package:flutter/material.dart';

class PerfilPersonalScreen extends StatelessWidget {
  const PerfilPersonalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil Personal')),
      body: const Center(child: Text('Pantalla de perfil personal')),
    );
  }
}
