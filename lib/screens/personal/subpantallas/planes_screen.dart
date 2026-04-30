import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class PlanesScreen extends StatefulWidget {
  const PlanesScreen({super.key});

  @override
  State<PlanesScreen> createState() => _PlanesScreenState();
}

class _PlanesScreenState extends State<PlanesScreen> {
  int _selected = 0; // 0: gratuito, 1: cuidado continuo, 2: cuidador apasionado

  static const double _largeHeight = 220.0;
  static const double _smallHeight = 100.0;

  void _select(int idx) {
    setState(() => _selected = idx);
  }

  Widget _buildPlanTile({required int idx, required String title, String? subtitle, double innerContentTranslate = 0, double outerVisualOffset = 0}) {
    final isSelected = _selected == idx;
    final height = isSelected ? _largeHeight : _smallHeight;

    return GestureDetector(
      onTap: () => _select(idx),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: height,
        width: double.infinity,
        child: Transform.translate(
          offset: Offset(outerVisualOffset, 0),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: const Color(0xFFFBE3CF), borderRadius: BorderRadius.circular(12)),
            child: Transform.translate(
              offset: Offset(innerContentTranslate, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black)),
                  if (subtitle != null) ...[
                    const SizedBox(height: 6),
                    Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.black)),
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF4EA),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(color: const Color(0xFFA0BC4D), shape: BoxShape.circle),
                      child: const Center(child: Icon(Icons.arrow_back, color: Colors.black, size: 20)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Center(
                      child: Text('Planes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textDark)),
                    ),
                  ),
                  const SizedBox(width: 52),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Plans area
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                child: Column(
                  children: [
                    // Top big (or small) container
                    _buildPlanTile(idx: 0, title: 'Plan gratuito'),

                    const SizedBox(height: 12),

                    // Bottom two stacked as a staircase (vertical with horizontal offset)
                    Column(
                      children: [
                        _buildPlanTile(idx: 1, title: 'Plan cuidado continuo', subtitle: 'metodo de pago mensual'),
                        const SizedBox(height: 12),
                        _buildPlanTile(idx: 2, title: 'Plan cuidador apasionado', subtitle: 'metodo de pago anual', outerVisualOffset: 0, innerContentTranslate: 0),
                      ],
                    ),

                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFA0BC4D),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          elevation: 0,
                        ),
                        child: const Text('Elegir', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
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
