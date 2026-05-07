import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../screens/profesional/main_shell.dart';

class EmpresarialSeleccionScreen extends StatefulWidget {
  const EmpresarialSeleccionScreen({super.key});

  @override
  State<EmpresarialSeleccionScreen> createState() => _EmpresarialSeleccionScreenState();
}

class _EmpresarialSeleccionScreenState extends State<EmpresarialSeleccionScreen> {
  final _nameController = TextEditingController();
  final _regController = TextEditingController();
  final _rfcController = TextEditingController();
  final _locationController = TextEditingController();
  final _emailController = TextEditingController();
  final _urlController = TextEditingController();

  File? _pickedImage;

  Future<void> _pickImage() async {
    try {
      final XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (file != null) {
        setState(() {
          _pickedImage = File(file.path);
        });
      }
    } catch (_) {}
  }

  @override
  void dispose() {
    _nameController.dispose();
    _regController.dispose();
    _rfcController.dispose();
    _locationController.dispose();
    _emailController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bg = const Color(0xFFFBF4EA);
    final buttonColor = const Color(0xFFA0BC4D);
    final textBlack = const TextStyle(color: Colors.black);

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text('Logo', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black)),
              const SizedBox(height: 8),
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFBE3CF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: _pickedImage == null
                      ? const Center(child: Icon(Icons.image, color: Color(0xFFFBF4EA), size: 84))
                      : ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.file(_pickedImage!, fit: BoxFit.cover)),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Form fields
              TextField(
                controller: _nameController,
                style: textBlack,
                decoration: const InputDecoration(labelText: 'Nombre de la veterinaria', labelStyle: TextStyle(color: Colors.black)),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _regController,
                style: textBlack,
                decoration: const InputDecoration(labelText: 'Número de registro', labelStyle: TextStyle(color: Colors.black)),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _rfcController,
                style: textBlack,
                decoration: const InputDecoration(labelText: 'RFC', labelStyle: TextStyle(color: Colors.black)),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _locationController,
                style: textBlack,
                decoration: const InputDecoration(labelText: 'Ubicación', labelStyle: TextStyle(color: Colors.black)),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _emailController,
                style: textBlack,
                decoration: const InputDecoration(labelText: 'Correo electrónico', labelStyle: TextStyle(color: Colors.black)),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _urlController,
                style: textBlack,
                decoration: const InputDecoration(labelText: 'URL de página web', labelStyle: TextStyle(color: Colors.black)),
              ),

              const SizedBox(height: 50),

              // Iniciar button (same design as welcome_screen)
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ProfesionalMainShell()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
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
                              decoration: BoxDecoration(
                                color: bg,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
