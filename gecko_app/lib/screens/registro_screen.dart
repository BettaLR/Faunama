import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../models/gecko.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  int _selectedGeckoIndex = 0;

  Gecko get _currentGecko => MockData.geckos[_selectedGeckoIndex];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Column(
          children: [
            // Header verde
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              decoration: const BoxDecoration(
                color: AppColors.green,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(24)),
              ),
              child: Column(
                children: [
                  const Text('Seguimiento',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
                  const SizedBox(height: 12),
                  // Selector de gecko
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (_selectedGeckoIndex > 0) {
                            setState(() => _selectedGeckoIndex--);
                          }
                        },
                        child: const Icon(Icons.chevron_left,
                            color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _currentGecko.name,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          if (_selectedGeckoIndex <
                              MockData.geckos.length - 1) {
                            setState(() => _selectedGeckoIndex++);
                          }
                        },
                        child: const Icon(Icons.chevron_right,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Contenido de seguimiento
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _TrackingSection(
                    title: 'Peso',
                    icon: Icons.monitor_weight_outlined,
                    iconColor: AppColors.green,
                    onHistorial: () {},
                    child: _WeightCard(gecko: _currentGecko),
                  ),
                  const SizedBox(height: 12),
                  _TrackingSection(
                    title: 'Comida',
                    icon: Icons.restaurant_outlined,
                    iconColor: AppColors.orange,
                    onHistorial: () {},
                    child: _FoodCard(gecko: _currentGecko),
                  ),
                  const SizedBox(height: 12),
                  _TrackingSection(
                    title: 'Comportamiento',
                    icon: Icons.psychology_outlined,
                    iconColor: AppColors.greenLight,
                    onHistorial: () {},
                    child: _BehaviorCard(),
                  ),
                  const SizedBox(height: 12),
                  _TrackingSection(
                    title: 'Síntomas',
                    icon: Icons.medical_services_outlined,
                    iconColor: AppColors.orange,
                    onHistorial: () {},
                    child: _SymptomsCard(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TrackingSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onHistorial;
  final Widget child;

  const _TrackingSection({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.onHistorial,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark)),
            const Spacer(),
            GestureDetector(
              onTap: onHistorial,
              child: Row(
                children: [
                  const Text('Historial',
                      style: TextStyle(
                          fontSize: 12, color: AppColors.textLight)),
                  const SizedBox(width: 4),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        color: AppColors.greenCard,
                        borderRadius: BorderRadius.circular(6)),
                    child: const Icon(Icons.chevron_right,
                        size: 14, color: AppColors.green),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

class _WeightCard extends StatelessWidget {
  final Gecko gecko;
  const _WeightCard({required this.gecko});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
                color: AppColors.greenCard,
                borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.monitor_weight_outlined,
                color: AppColors.green, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Registrar peso actual',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textDark)),
                Row(
                  children: [
                    Text(
                      '${gecko.weightKg} kg',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark),
                    ),
                    const SizedBox(width: 8),
                    const Text('Día | Mes',
                        style: TextStyle(
                            fontSize: 11, color: AppColors.textLight)),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
                color: AppColors.green, shape: BoxShape.circle),
            child: const Icon(Icons.add, color: Colors.white, size: 16),
          ),
        ],
      ),
    );
  }
}

class _FoodCard extends StatelessWidget {
  final Gecko gecko;
  const _FoodCard({required this.gecko});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
                color: AppColors.orangeSurface,
                borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.restaurant_outlined,
                color: AppColors.orange, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Horario de comida',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textDark)),
                Text('0:00 am/pm',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark)),
                Text('Tipo de comida | Grillo',
                    style:
                        TextStyle(fontSize: 11, color: AppColors.textLight)),
              ],
            ),
          ),
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
                color: AppColors.green, shape: BoxShape.circle),
            child: const Icon(Icons.add, color: Colors.white, size: 16),
          ),
        ],
      ),
    );
  }
}

class _BehaviorCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
                color: AppColors.greenCard,
                borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.psychology_outlined,
                color: AppColors.greenLight, size: 24),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Actitudes nuevas',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textDark)),
                Text('| notas.',
                    style: TextStyle(
                        fontSize: 11, color: AppColors.textLight)),
              ],
            ),
          ),
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
                color: AppColors.green, shape: BoxShape.circle),
            child: const Icon(Icons.add, color: Colors.white, size: 16),
          ),
        ],
      ),
    );
  }
}

class _SymptomsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
                color: AppColors.orangeSurface,
                borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.medical_services_outlined,
                color: AppColors.orange, size: 24),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Observaciones',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textDark)),
                Text('Sin registros recientes',
                    style: TextStyle(
                        fontSize: 11, color: AppColors.textLight)),
              ],
            ),
          ),
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
                color: AppColors.green, shape: BoxShape.circle),
            child: const Icon(Icons.add, color: Colors.white, size: 16),
          ),
        ],
      ),
    );
  }
}
