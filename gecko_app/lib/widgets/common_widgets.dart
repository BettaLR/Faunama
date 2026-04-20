import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

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
          color: AppColors.greenCard,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // Ícono gecko placeholder
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.orange,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.pets, color: Colors.white, size: 28),
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
                color: AppColors.green,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.chevron_right,
                  color: Colors.white, size: 20),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen
            Expanded(
              child: Container(
                width: double.infinity,
                color: AppColors.creamDark,
                child: imageUrl != null
                    ? Image.network(imageUrl!, fit: BoxFit.cover)
                    : const Center(
                        child: Icon(Icons.cruelty_free,
                            size: 48, color: AppColors.greenLight),
                      ),
              ),
            ),
            // Info
            Padding(
              padding: const EdgeInsets.all(10),
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
                                fontSize: 11, color: AppColors.textLight)),
                      ],
                    ),
                  ),
                  Icon(
                    gender == 'female' ? Icons.female : Icons.male,
                    size: 16,
                    color: gender == 'female'
                        ? AppColors.orange
                        : AppColors.green,
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

// ─── Evento del calendario en el home ───
class EventRow extends StatelessWidget {
  final DateTime date;
  final String title;
  final String type;
  final String? time;
  final bool isCompleted;

  const EventRow({
    super.key,
    required this.date,
    required this.title,
    required this.type,
    this.time,
    this.isCompleted = false,
  });

  Color get _typeColor {
    switch (type) {
      case 'vaccine':
        return AppColors.orange;
      case 'checkup':
        return AppColors.greenLight;
      case 'food':
        return const Color(0xFFCB8C2A);
      default:
        return AppColors.textLight;
    }
  }

  @override
  Widget build(BuildContext context) {
    final months = [
      '', 'ene', 'feb', 'mar', 'abr', 'may', 'jun',
      'jul', 'ago', 'sep', 'oct', 'nov', 'dic'
    ];

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Row(
        children: [
          // Indicador completado
          Icon(
            isCompleted ? Icons.check_circle : Icons.circle_outlined,
            color: isCompleted ? AppColors.green : AppColors.border,
            size: 18,
          ),
          const SizedBox(width: 8),
          // Barra de color tipo
          Container(
            width: 4,
            height: 36,
            decoration: BoxDecoration(
              color: _typeColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 10),
          // Fecha
          Column(
            children: [
              Text(
                '${date.day.toString().padLeft(2, '0')}',
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark),
              ),
              Text(
                months[date.month],
                style: const TextStyle(
                    fontSize: 10, color: AppColors.textLight),
              ),
            ],
          ),
          const SizedBox(width: 12),
          // Título y día
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _weekdayName(date),
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textDark),
                ),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 11, color: AppColors.textMedium),
                ),
              ],
            ),
          ),
          // Hora
          if (time != null)
            Text(time!,
                style: const TextStyle(
                    fontSize: 11, color: AppColors.textLight)),
        ],
      ),
    );
  }

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
        width: 36,
        height: 36,
        decoration: const BoxDecoration(
          color: AppColors.green,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 20),
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
