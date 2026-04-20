import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../models/gecko.dart';

class AgendaScreen extends StatefulWidget {
  const AgendaScreen({super.key});

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  DateTime _focusedDay = DateTime(2026, 10, 1);
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime(2026, 10, 6);
  }

  List<GeckoEvent> get _upcomingEvents {
    return MockData.events.toList()..sort((a, b) => a.date.compareTo(b.date));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Calendario con fondo verde y curva abajo ──
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF7AAD3A),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text('Recordatorios',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)),
                        ),
                        _FormatToggle(
                          label: 'Mes',
                          selected: _calendarFormat == CalendarFormat.month,
                          onTap: () => setState(
                              () => _calendarFormat = CalendarFormat.month),
                        ),
                        const SizedBox(width: 6),
                        _FormatToggle(
                          label: 'Año',
                          selected: _calendarFormat == CalendarFormat.week,
                          onTap: () => setState(
                              () => _calendarFormat = CalendarFormat.week),
                        ),
                      ],
                    ),
                  ),
                  TableCalendar(
                    firstDay: DateTime.utc(2024, 1, 1),
                    lastDay: DateTime.utc(2027, 12, 31),
                    focusedDay: _focusedDay,
                    calendarFormat: _calendarFormat,
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                    eventLoader: (day) => MockData.events
                        .where((e) =>
                            e.date.year == day.year &&
                            e.date.month == day.month &&
                            e.date.day == day.day)
                        .toList(),
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1.5),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      todayTextStyle: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                      selectedDecoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                      selectedTextStyle: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                      markerDecoration: const BoxDecoration(
                          color: AppColors.orange, shape: BoxShape.circle),
                      markerSize: 5,
                      markersMaxCount: 1,
                      defaultTextStyle:
                          const TextStyle(color: Colors.white, fontSize: 13),
                      weekendTextStyle:
                          const TextStyle(color: Colors.white70, fontSize: 13),
                      outsideTextStyle:
                          const TextStyle(color: Colors.white38, fontSize: 13),
                      disabledTextStyle:
                          const TextStyle(color: Colors.white24, fontSize: 13),
                      cellMargin: const EdgeInsets.all(4),
                    ),
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                      leftChevronIcon: Icon(Icons.chevron_left,
                          color: Colors.white, size: 24),
                      rightChevronIcon: Icon(Icons.chevron_right,
                          color: Colors.white, size: 24),
                      headerPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                    daysOfWeekStyle: const DaysOfWeekStyle(
                      weekdayStyle: TextStyle(
                          fontSize: 11,
                          color: Colors.white70,
                          fontWeight: FontWeight.w500),
                      weekendStyle: TextStyle(
                          fontSize: 11,
                          color: Colors.white70,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),

            // ── Header próximos eventos ──
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 6),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Próximos eventos',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textDark)),
                        Text('Organiza tus momentos importantes',
                            style: TextStyle(
                                fontSize: 11, color: AppColors.textLight)),
                      ],
                    ),
                  ),
                  Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                          color: AppColors.orange, shape: BoxShape.circle)),
                  const SizedBox(width: 4),
                  Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                          color: AppColors.red, shape: BoxShape.circle)),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                          color: AppColors.green, shape: BoxShape.circle),
                      child:
                          const Icon(Icons.add, color: Colors.white, size: 18),
                    ),
                  ),
                ],
              ),
            ),

            // ── Lista eventos ──
            Expanded(
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                itemCount: _upcomingEvents.length,
                itemBuilder: (_, i) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _EventCard(event: _upcomingEvents[i]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final GeckoEvent event;
  const _EventCard({required this.event});

  Color get _barColor {
    switch (event.type) {
      case 'vaccine':
        return AppColors.orange;
      case 'checkup':
        return AppColors.red;
      case 'food':
        return const Color(0xFFCB8C2A);
      default:
        return AppColors.textLight;
    }
  }

  bool get _isCompleted => event.date.isBefore(DateTime.now());

  String _weekdayName(DateTime d) {
    const days = [
      'Lunes',
      'Martes',
      'Miércoles',
      'Jueves',
      'Viernes',
      'Sábado',
      'Domingo'
    ];
    return days[d.weekday - 1];
  }

  String _monthName(int m) {
    const months = [
      '',
      'enero',
      'febrero',
      'marzo',
      'abril',
      'mayo',
      'junio',
      'julio',
      'agosto',
      'septiembre',
      'octubre',
      'noviembre',
      'diciembre'
    ];
    return months[m];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Row(
        children: [
          Icon(
            _isCompleted ? Icons.check_circle : Icons.circle_outlined,
            color: _isCompleted ? AppColors.green : AppColors.border,
            size: 20,
          ),
          const SizedBox(width: 8),
          Container(
            width: 5,
            height: 44,
            decoration: BoxDecoration(
                color: _barColor, borderRadius: BorderRadius.circular(3)),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('${event.date.day.toString().padLeft(2, '0')}',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark)),
              Text(_monthName(event.date.month).substring(0, 3),
                  style: const TextStyle(
                      fontSize: 10, color: AppColors.textLight)),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_weekdayName(event.date)} ${event.date.day} de ${_monthName(event.date.month)}',
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark),
                ),
                Text(event.title,
                    style: const TextStyle(
                        fontSize: 11, color: AppColors.textMedium)),
              ],
            ),
          ),
          if (event.time != null)
            Text(event.time!,
                style:
                    const TextStyle(fontSize: 11, color: AppColors.textLight)),
        ],
      ),
    );
  }
}

class _FormatToggle extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FormatToggle(
      {required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected
              ? Colors.white.withOpacity(0.9)
              : Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: selected ? const Color(0xFF7AAD3A) : Colors.white)),
      ),
    );
  }
}
