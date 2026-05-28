import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../data/mock_data.dart';
import '../../models/gecko.dart';
import '../../widgets/add_gecko_sheet.dart';

class RegistroScreen extends StatefulWidget {
  final int? initialIndex;

  const RegistroScreen({super.key, this.initialIndex});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  int _selectedGeckoIndex = 0;
  Gecko? get _currentGecko => MockData.geckos.isNotEmpty ? MockData.geckos[_selectedGeckoIndex] : null;

  @override
  void initState() {
    super.initState();
    if (widget.initialIndex != null && MockData.geckos.isNotEmpty) {
      final i = widget.initialIndex!;
      if (i >= 0 && i < MockData.geckos.length) {
        _selectedGeckoIndex = i;
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void didUpdateWidget(covariant RegistroScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If the parent requests opening Registro with a specific gecko index,
    // apply it here so the already-mounted screen updates its selection.
    if (widget.initialIndex != null && widget.initialIndex != oldWidget.initialIndex) {
      final i = widget.initialIndex!;
      if (MockData.geckos.isNotEmpty && i >= 0 && i < MockData.geckos.length) {
        setState(() {
          _selectedGeckoIndex = i;
        });
      }
    }
  }

  Future<void> _deleteCurrentGecko() async {
    if (_currentGecko == null) return;
    final confirm = await showDialog<bool?>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar mascota'),
        content: const Text('¿Estás seguro de que quieres eliminar esta mascota? Esta acción no se puede deshacer.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancelar')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Eliminar')),
        ],
      ),
    );
    if (confirm != true) return;

    final idx = _selectedGeckoIndex;
    MockData.geckos.removeAt(idx);
    await MockData.save();
    if (MockData.geckos.isEmpty) {
      if (mounted) Navigator.pop(context);
      return;
    }
    setState(() {
      if (_selectedGeckoIndex >= MockData.geckos.length) {
        _selectedGeckoIndex = MockData.geckos.length - 1;
      }
    });
  }

  void _showAddGeckoSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const AddGeckoSheet(),
    ).then((_) => setState(() {}));
  }

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
                              child: GestureDetector(
                                onTap: MockData.geckos.isEmpty ? () => _showAddGeckoSheet(context) : null,
                                child: Text(
                                  MockData.geckos.isEmpty ? 'Añadir mascota' : _currentGecko!.name,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
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
              child: MockData.geckos.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(24.0),
                            child: Text(
                              'No hay mascotas registradas.',
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFA0BC4D),
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () => _showAddGeckoSheet(context),
                            child: const Text('Añadir mascota', style: TextStyle(fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    )
                  : ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        _TrackingSection(
                          title: 'Peso',
                          icon: Icons.monitor_weight_outlined,
                          iconColor: AppColors.green,
                          onHistorial: () {},
                          child: _WeightCard(gecko: _currentGecko!),
                        ),
                        const SizedBox(height: 12),
                        _TrackingSection(
                          title: 'Comida',
                          icon: Icons.restaurant_outlined,
                          iconColor: AppColors.orange,
                          onHistorial: () {},
                          child: _FoodCard(gecko: _currentGecko!),
                        ),
                        const SizedBox(height: 12),
                        _TrackingSection(
                          title: 'Comportamiento',
                          icon: Icons.psychology_outlined,
                          iconColor: AppColors.greenLight,
                          onHistorial: () {},
                          child: _BehaviorCard(gecko: _currentGecko!),
                        ),
                        const SizedBox(height: 12),
                        _TrackingSection(
                          title: 'Síntomas',
                          icon: Icons.medical_services_outlined,
                          iconColor: AppColors.orange,
                          onHistorial: () {},
                          child: _SymptomsCard(gecko: _currentGecko!),
                        ),
                        const SizedBox(height: 18),
                        Center(
                          child: SizedBox(
                            width: 200,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFF994D),
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: _deleteCurrentGecko,
                              child: const Text(
                                'Eliminar mascota',
                                style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
                              ),
                            ),
                          ),
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
          GestureDetector(
            onTap: () async {
              final controller = TextEditingController(text: gecko.weightKg > 0 ? gecko.weightKg.toString() : '');
              final res = await showDialog<double?>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Registrar peso (kg)'),
                  content: TextField(
                    controller: controller,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(hintText: 'Ej: 0.065'),
                  ),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
                    TextButton(onPressed: () => Navigator.pop(ctx, double.tryParse(controller.text)), child: const Text('Guardar')),
                  ],
                ),
              );
              if (res != null) {
                final idx = MockData.geckos.indexWhere((g) => g.id == gecko.id);
                if (idx >= 0) {
                  final updated = Gecko(
                    id: gecko.id,
                    name: gecko.name,
                    morph: gecko.morph,
                    age: gecko.age,
                    imageUrl: gecko.imageUrl,
                    gender: gecko.gender,
                    weightKg: res,
                    lastFed: gecko.lastFed,
                    behaviorNotes: gecko.behaviorNotes,
                    symptoms: gecko.symptoms,
                  );
                  MockData.geckos[idx] = updated;
                  (context as Element).markNeedsBuild();
                }
              }
            },
            child: Container(
              width: 40,
              height: 28,
              decoration: BoxDecoration(
                  color: const Color(0xFFFF994D),
                  borderRadius: BorderRadius.circular(15)),
              child: const Icon(Icons.add, color: Colors.black, size: 20),
            ),
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
    final timeText = gecko.lastFed == null ? '--:--' : '${gecko.lastFed!.hour.toString().padLeft(2,'0')}:${gecko.lastFed!.minute.toString().padLeft(2,'0')}';
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
              children: [
                const Text('Horario de comida',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0))),
                Text(timeText,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 0, 0, 0))),
                const Text('Tipo de comida | Grillo',
                    style: TextStyle(fontSize: 12, color: Color.fromARGB(255, 0, 0, 0))),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              final time = await showTimePicker(
                context: context,
                initialTime: gecko.lastFed != null ? TimeOfDay(hour: gecko.lastFed!.hour, minute: gecko.lastFed!.minute) : TimeOfDay.now(),
              );
              if (time != null) {
                final now = DateTime.now();
                final newDate = DateTime(now.year, now.month, now.day, time.hour, time.minute);
                final idx = MockData.geckos.indexWhere((g) => g.id == gecko.id);
                if (idx >= 0) {
                  final updated = Gecko(
                    id: gecko.id,
                    name: gecko.name,
                    morph: gecko.morph,
                    age: gecko.age,
                    imageUrl: gecko.imageUrl,
                    gender: gecko.gender,
                    weightKg: gecko.weightKg,
                    lastFed: newDate,
                    behaviorNotes: gecko.behaviorNotes,
                    symptoms: gecko.symptoms,
                  );
                  MockData.geckos[idx] = updated;
                  (context as Element).markNeedsBuild();
                }
              }
            },
            child: Container(
              width: 40,
              height: 28,
              decoration: BoxDecoration(
                  color: const Color(0xFFFF994D),
                  borderRadius: BorderRadius.circular(15)),
              child: const Icon(Icons.add, color: Colors.black, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class _BehaviorCard extends StatelessWidget {
  final Gecko gecko;
  const _BehaviorCard({required this.gecko});

  @override
  Widget build(BuildContext context) {
    final preview = gecko.behaviorNotes ?? 'Sin registros recientes';
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Actitudes nuevas',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0))),
                const SizedBox(height: 6),
                Text(preview, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              final controller = TextEditingController(text: gecko.behaviorNotes ?? '');
              final res = await showDialog<String?>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Observaciones / Comportamiento'),
                  content: TextField(
                    controller: controller,
                    maxLines: 5,
                    decoration: const InputDecoration(hintText: 'Escribe aquí...'),
                  ),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
                    TextButton(onPressed: () => Navigator.pop(ctx, controller.text.trim()), child: const Text('Guardar')),
                  ],
                ),
              );
              if (res != null) {
                final idx = MockData.geckos.indexWhere((g) => g.id == gecko.id);
                if (idx >= 0) {
                  final updated = Gecko(
                    id: gecko.id,
                    name: gecko.name,
                    morph: gecko.morph,
                    age: gecko.age,
                    imageUrl: gecko.imageUrl,
                    gender: gecko.gender,
                    weightKg: gecko.weightKg,
                    lastFed: gecko.lastFed,
                    behaviorNotes: res,
                    symptoms: gecko.symptoms,
                  );
                  MockData.geckos[idx] = updated;
                  (context as Element).markNeedsBuild();
                }
              }
            },
            child: Container(
              width: 40,
              height: 28,
              decoration: BoxDecoration(
                  color: const Color(0xFFFF994D),
                  borderRadius: BorderRadius.circular(15)),
              child: const Icon(Icons.add, color: Colors.black, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class _SymptomsCard extends StatelessWidget {
  final Gecko gecko;
  const _SymptomsCard({required this.gecko});

  @override
  Widget build(BuildContext context) {
    final preview = gecko.symptoms ?? 'Sin registros recientes';
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Observaciones',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0))),
                const SizedBox(height: 6),
                Text(preview, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              final controller = TextEditingController(text: gecko.symptoms ?? '');
              final res = await showDialog<String?>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Síntomas / Observaciones'),
                  content: TextField(
                    controller: controller,
                    maxLines: 5,
                    decoration: const InputDecoration(hintText: 'Escribe aquí...'),
                  ),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
                    TextButton(onPressed: () => Navigator.pop(ctx, controller.text.trim()), child: const Text('Guardar')),
                  ],
                ),
              );
              if (res != null) {
                final idx = MockData.geckos.indexWhere((g) => g.id == gecko.id);
                if (idx >= 0) {
                  final updated = Gecko(
                    id: gecko.id,
                    name: gecko.name,
                    morph: gecko.morph,
                    age: gecko.age,
                    imageUrl: gecko.imageUrl,
                    gender: gecko.gender,
                    weightKg: gecko.weightKg,
                    lastFed: gecko.lastFed,
                    behaviorNotes: gecko.behaviorNotes,
                    symptoms: res,
                  );
                  MockData.geckos[idx] = updated;
                  (context as Element).markNeedsBuild();
                }
              }
            },
            child: Container(
              width: 40,
              height: 28,
              decoration: BoxDecoration(
                  color: const Color(0xFFFF994D),
                  borderRadius: BorderRadius.circular(15)),
              child: const Icon(Icons.add, color: Colors.black, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
