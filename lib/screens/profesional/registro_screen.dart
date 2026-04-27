import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../data/mock_data.dart';
import '../../models/gecko.dart';

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
            // Header verde con arco
            ClipPath(
              clipper: _BottomArcClipper(),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 90),
                decoration: const BoxDecoration(
                  color: Color(0xFFA0BC4D),
                ),
                child: Column(
                  children: [
                    const Text('Seguimiento',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.black)),
                    const SizedBox(height: 12),
                    // Selector de gecko
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: GestureDetector(
                            onTap: () {
                              if (_selectedGeckoIndex > 0) {
                                setState(() => _selectedGeckoIndex--);
                              }
                            },
                            child: const Icon(Icons.chevron_left,
                                color: Colors.black),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFBF4EA),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                _currentGecko.name,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: GestureDetector(
                            onTap: () {
                              if (_selectedGeckoIndex <
                                  MockData.geckos.length - 1) {
                                setState(() => _selectedGeckoIndex++);
                              }
                            },
                            child: const Icon(Icons.chevron_right,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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

class _BottomArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(
      size.width / 2,
      size.height - 80,
      size.width,
      size.height - 20,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
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
                          fontSize: 13, color: Color.fromARGB(255, 0, 0, 0))),
                  const SizedBox(width: 10),
                  Container(
                    width: 30,
                    height: 20,
                    decoration: BoxDecoration(
                        color: const Color(0xFFE1677D),
                        borderRadius: BorderRadius.circular(15)),
                    child: const Icon(Icons.chevron_right,
                        size: 20, color: Color.fromARGB(255, 0, 0, 0)),
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
        color: const Color(0xFFFBE3CF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
                color: const Color.fromARGB(0, 234, 243, 222),
                borderRadius: BorderRadius.circular(10)),
            child: Image.asset('assets/images/peso.png'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Registrar peso actual',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0))),
                const SizedBox(height: 0),
                Text(
                  '${gecko.weightKg} kg',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 0, 0, 0)),
                ),
                const SizedBox(height: 0),
                const Text('Día | Mes',
                    style: TextStyle(
                        fontSize: 12, color: Color.fromARGB(255, 0, 0, 0))),
              ],
            ),
          ),
          Container(
            width: 40,
            height: 28,
            decoration: BoxDecoration(
                color: const Color(0xFFFF994D),
                borderRadius: BorderRadius.circular(15)),
            child: const Icon(Icons.add, color: Colors.black, size: 20),
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
        color: const Color(0xFFFBE3CF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
                color: const Color.fromARGB(0, 234, 243, 222),
                borderRadius: BorderRadius.circular(10)),
            child: Image.asset('assets/images/comida.png'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Horario de comida',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0))),
                Text('0:00 am/pm',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 0, 0, 0))),
                Text('Tipo de comida | Grillo',
                    style:
                        TextStyle(fontSize: 12, color: Color.fromARGB(255, 0, 0, 0))),
              ],
            ),
          ),
          Container(
            width: 40,
            height: 28,
            decoration: BoxDecoration(
                color: const Color(0xFFFF994D),
                borderRadius: BorderRadius.circular(15)),
            child: const Icon(Icons.add, color: Colors.black, size: 20),
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
        color: const Color(0xFFFBE3CF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
                color: const Color.fromARGB(0, 234, 243, 222),
                borderRadius: BorderRadius.circular(10)),
            child: Image.asset('assets/images/comportamiento.png'),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Actitudes nuevas',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0))),
                Text('| notas.',
                    style: TextStyle(
                        fontSize: 12, color: Color.fromARGB(255, 0, 0, 0))),
              ],
            ),
          ),
          Container(
            width: 40,
            height: 28,
            decoration: BoxDecoration(
                color: const Color(0xFFFF994D),
                borderRadius: BorderRadius.circular(15)),
            child: const Icon(Icons.add, color: Colors.black, size: 20),
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
        color: const Color(0xFFFBE3CF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
                color: const Color.fromARGB(0, 234, 243, 222),
                borderRadius: BorderRadius.circular(10)),
            child: Image.asset('assets/images/observaciones.png'),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Observaciones',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0))),
                Text('Sin registros recientes',
                    style: TextStyle(
                        fontSize: 12, color: Color.fromARGB(255, 0, 0, 0))),
              ],
            ),
          ),
          Container(
            width: 40,
            height: 28,
            decoration: BoxDecoration(
                color: const Color(0xFFFF994D),
                borderRadius: BorderRadius.circular(15)),
            child: const Icon(Icons.add, color: Colors.black, size: 20),
          ),
        ],
      ),
    );
  }
}
