import 'dart:io';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/gecko.dart';
import '../data/mock_data.dart';

// ─── Tip card verde del home ("Cuida mejor, conoce más") ───
class TipCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const TipCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFFBE3CF),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // Ícono gecko placeholder
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFFBE3CF),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                'assets/images/gecko_blog.png',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark)),
                  const SizedBox(height: 2),
                  Text(subtitle,
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.textMedium)),
                ],
              ),
            ),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFFC5BD4F),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.chevron_right,
                  color: Colors.black, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Tarjeta de gecko en el home ───
class GeckoCard extends StatelessWidget {
  final String name;
  final String age;
  final String gender;
  final String? imageUrl;
  final VoidCallback? onTap;

  const GeckoCard({
    super.key,
    required this.name,
    required this.age,
    required this.gender,
    this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        clipBehavior: Clip.hardEdge,
        child: AspectRatio(
          aspectRatio: 1,
          child: Stack(
            children: [
              // Imagen de fondo cuadrada con bordes suavizados
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFBE3CF),
                  borderRadius: BorderRadius.circular(16),
                  image: imageUrl != null
                      ? DecorationImage(
                          image: imageUrl!.toLowerCase().startsWith('http')
                              ? NetworkImage(imageUrl!)
                              : FileImage(File(imageUrl!)) as ImageProvider,
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: imageUrl == null
                    ? const Center(
                        child: Icon(Icons.image,
                            size: 48, color: Color(0xFFFBF4EA)),
                      )
                    : null,
              ),
              // Recuadro de información dentro de la imagen, separado ligeramente del borde inferior
              Positioned(
                left: 10,
                right: 10,
                bottom: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.92),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border, width: 0.5),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(name,
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textDark)),
                            Text(age,
                                style: const TextStyle(
                                    fontSize: 11,
                                    color: AppColors.textLight)),
                          ],
                        ),
                      ),
                      Icon(
                        gender == 'female' ? Icons.female : Icons.male,
                        size: 16,
                        color: Colors.black,
                      ),
                    ],
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

// ─── Evento del calendario en el home ───
class EventRow extends StatefulWidget {
  final GeckoEvent event;
  final void Function(GeckoEvent)? onToggleCompleted;
  final void Function(GeckoEvent)? onDelete;

  const EventRow({
    super.key,
    required this.event,
    this.onToggleCompleted,
    this.onDelete,
  });

  @override
  State<EventRow> createState() => _EventRowState();
}

class _EventRowState extends State<EventRow> {
  bool _showDelete = false;

  void _toggleDelete() => setState(() => _showDelete = !_showDelete);

  Color get _typeColor {
    switch (widget.event.type) {
      // accept both Spanish and English-like types
      case 'salud':
      case 'vaccine':
        return const Color(0xFFC53D3D);
      case 'rutina':
      case 'checkup':
        return const Color(0xFFFF994D);
      case 'food':
        return const Color(0xFFCB8C2A);
      case 'otro':
      default:
        return const Color(0xFFE1677D);
    }
  }

  @override
  Widget build(BuildContext context) {
    final months = [
      '', 'ene', 'feb', 'mar', 'abr', 'may', 'jun',
      'jul', 'ago', 'sep', 'oct', 'nov', 'dic'
    ];

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Row layout: main card and delete button. Use AnimatedContainer for safe shifting.
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.only(bottom: 10, left: 45, right: _showDelete ? 60 : 0),
                padding: const EdgeInsets.fromLTRB(12, 8, 16, 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFBE3CF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border, width: 0.5),
                ),
                child: GestureDetector(
                  onTap: _toggleDelete,
                  child: Row(
                    children: [
                      // Barra de color tipo
                      Container(
                        width: 15,
                        height: 52,
                        decoration: BoxDecoration(
                          color: _typeColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Título y fecha
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.event.title,
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textDark),
                            ),
                            Text(
                              '${widget.event.date.day.toString().padLeft(2, '0')} ${months[widget.event.date.month]}',
                              style: const TextStyle(
                                  fontSize: 12, color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Línea vertical junto a la hora
                      Container(
                        width: 2,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Hora
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: _typeColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text(
                              widget.event.time ?? '',
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // (removed inline delete button; using positioned delete button on the right)
          ],
        ),
        // Indicador completado fuera del recuadro, centrado a la izquierda
        Positioned(
          left: 0,
          top: 28,
          child: GestureDetector(
            onTap: () async {
              // toggle in model, then call optional callback to let parent update UI
              await MockData.toggleCompleted(widget.event);
              if (widget.onToggleCompleted != null) widget.onToggleCompleted!(widget.event);
            },
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: widget.event.completed ? const Color(0xFFE1677D) : const Color(0xFFC5BD4F),
                shape: BoxShape.circle,
                border: Border.all(
                  color: widget.event.completed ? const Color(0xFFE1677D) : const Color(0xFFC5BD4F),
                  width: 0,
                ),
              ),
              child: widget.event.completed
                  ? const Icon(Icons.check, size: 16, color: Colors.black)
                  : null,
            ),
          ),
        ),

        // Delete button (appears when _showDelete). Use IgnorePointer so it's not hit-testable when hidden.
        Positioned(
          right: 0,
          top: 8,
          bottom: 8,
          child: IgnorePointer(
            ignoring: !_showDelete,
            child: AnimatedOpacity(
              opacity: _showDelete ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: SizedBox(
                width: 56,
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA0BC4D),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 0,
                      minimumSize: const Size(48, 48),
                    ),
                    onPressed: () {
                      if (widget.onDelete != null) widget.onDelete!(widget.event);
                    },
                    child: const Icon(Icons.delete, color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ignore: unused_element
  String _weekdayName(DateTime d) {
    const days = [
      'Lunes', 'Martes', 'Miércoles', 'Jueves',
      'Viernes', 'Sábado', 'Domingo'
    ];
    return '${days[d.weekday - 1]} ${d.day} de ${_monthName(d.month)}';
  }

  String _monthName(int m) {
    const months = [
      '', 'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
      'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'
    ];
    return months[m];
  }
}

// ─── FAB verde con ícono + ───
class GreenFab extends StatelessWidget {
  final VoidCallback onTap;

  const GreenFab({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 30,
        decoration: BoxDecoration(
          color: const Color(0xFFE1677D),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(Icons.add, color: Colors.black, size: 20),
      ),
    );
  }
}

// ─── Sección header con título y acción ───
class SectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const SectionHeader({super.key, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark)),
        if (trailing != null) trailing!,
      ],
    );
  }
}
