import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  
  bool _isLoading = false;

  @override
  void dispose() {
    _userController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _registerUser() async {
    final user = _userController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirm = _confirmController.text.trim();

    if (user.isEmpty || email.isEmpty || password.isEmpty || confirm.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor llena todos los campos')),
      );
      return;
    }

    if (password != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // 1. Create user in Firebase Authentication
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 2. Save additional user data in Cloud Firestore
      if (userCredential.user != null) {
        await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
          'username': user,
          'email': email,
          'accountType': 'Personal',
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      // 3. Navigate to main shell
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => PersonalMainShell(key: PersonalMainShell.globalKey)),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Error: ${e.code} - ${e.message}';
      if (e.code == 'weak-password') {
        errorMessage = 'La contraseña es demasiado débil.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'Ya existe una cuenta con este correo electrónico.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'El correo electrónico no es válido.';
      }
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
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
                            keyboardType: TextInputType.emailAddress,
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

                          SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: SizedBox(
                                width: 200,
                                child: ElevatedButton(
                                  onPressed: _isLoading ? null : _registerUser,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: buttonColor,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: _isLoading 
                                    ? const SizedBox(
                                        width: 20, 
                                        height: 20, 
                                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                                      )
                                    : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Expanded(
                                        child: Center(
                                          child: Text(
                                            'Registrar',
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

