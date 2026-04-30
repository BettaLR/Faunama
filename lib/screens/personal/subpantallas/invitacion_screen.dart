import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class InvitacionScreen extends StatelessWidget {
  const InvitacionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF4EA), // background requested
      body: SafeArea(
        child: Column(
          children: [
            // Header con botón regresar y título centrado
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFA0BC4D),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(Icons.arrow_back, color: Colors.black, size: 20),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Center(
                      child: Text('Invitar',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textDark)),
                    ),
                  ),
                  // espacio para mantener el título centrado
                  const SizedBox(width: 52),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Centrar el contenido principal debajo del header
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Invita a un ser querido para que juntos cuiden de su mascota', textAlign: TextAlign.left, style: TextStyle(fontSize: 14, color: Colors.black)),
                          SizedBox(height: 12),
                          Text('compartir con:', textAlign: TextAlign.left, style: TextStyle(fontSize: 13, color: Colors.black)),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Container con QR y link
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 90),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(color: const Color(0xFFFBE3CF), borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(color: const Color(0xFFFBF4EA), borderRadius: BorderRadius.circular(8)),
                              child: const Center(child: Icon(Icons.qr_code, size: 72, color: AppColors.textDark)),
                            ),
                            const SizedBox(height: 12),
                            const Align(alignment: Alignment.centerLeft, child: Text('https://invitation-link.example.com', textAlign: TextAlign.left, style: TextStyle(color: Colors.black))),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Share button fuera del container
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        width: 260,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFA0BC4D),
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 0,
                          ),
                          child: const Text('Compartir', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
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
    );
  }
}
