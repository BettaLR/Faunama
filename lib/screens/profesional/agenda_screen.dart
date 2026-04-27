import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../theme/app_theme.dart';
import '../../data/mock_data.dart';
import '../../models/gecko.dart';

class AgendaScreen extends StatefulWidget {
  const AgendaScreen({super.key});

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  late DateTime _focusedDay;
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
  }

  List<GeckoEvent> get _upcomingEvents {
    return MockData.events.toList()..sort((a, b) => a.date.compareTo(b.date));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: SafeArea(
                child: ClipPath(
                  clipper: BottomArcClipper(),
                  child: Container(
                    width: double.infinity,
                    color: const Color(0xFFA0BC4D),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 40, 10, 0),
                          child: _SegmentedFormatToggle(
                            selectedFormat: _calendarFormat,
                            onFormatChanged: (format) {
                              setState(() {
                                _calendarFormat = format;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 60),
                          child: TableCalendar(
                            firstDay: DateTime.utc(2024, 1, 1),
                            lastDay: DateTime.utc(2027, 12, 31),
                            focusedDay: _focusedDay,
                            calendarFormat: _calendarFormat,
                            selectedDayPredicate: (day) =>
                                isSameDay(_selectedDay, day),
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
                                color: const Color(0xFFFBF4EA),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              todayTextStyle: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w600),
                              selectedDecoration: BoxDecoration(
                                color: const Color(0xFFFBF4EA),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              selectedTextStyle: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w700),
                              markerDecoration: const BoxDecoration(
                                  color: AppColors.orange, shape: BoxShape.circle),
                              markerSize: 5,
                              markersMaxCount: 1,
                              defaultTextStyle: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0), fontSize: 13),
                              weekendTextStyle: const TextStyle(
                                  color: Color.fromARGB(179, 0, 0, 0), fontSize: 13),
                              outsideTextStyle: const TextStyle(
                                  color: Color.fromARGB(97, 0, 0, 0), fontSize: 13),
                              disabledTextStyle: const TextStyle(
                                  color: Color.fromARGB(60, 0, 0, 0), fontSize: 13),
                              cellMargin: const EdgeInsets.all(4),
                            ),
                            headerStyle: const HeaderStyle(
                              formatButtonVisible: false,
                              titleCentered: true,
                              titleTextStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                              leftChevronIcon: Icon(Icons.chevron_left,
                                  color: Color.fromARGB(255, 0, 0, 0), size: 24),
                              rightChevronIcon: Icon(Icons.chevron_right,
                                  color: Color.fromARGB(255, 0, 0, 0), size: 24),
                              headerPadding: EdgeInsets.symmetric(vertical: 10),
                            ),
                            daysOfWeekStyle: const DaysOfWeekStyle(
                              weekdayStyle: TextStyle(
                                  fontSize: 11,
                                  color: Color.fromARGB(179, 0, 0, 0),
                                  fontWeight: FontWeight.w500),
                              weekendStyle: TextStyle(
                                  fontSize: 11,
                                  color: Color.fromARGB(179, 0, 0, 0),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 👇 separación controlada
            const SizedBox(height: 16),

            // ── Header próximos eventos ──
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 6),
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
                                fontSize: 11, color: Color.fromARGB(255, 0, 0, 0))),
                      ],
                    ),
                  ),
                  Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                          color: AppColors.orange, borderRadius: BorderRadius.circular(3))),
                  const SizedBox(width: 4),
                  Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                          color: AppColors.red, borderRadius: BorderRadius.circular(3))),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 40,
                      height: 32,
                      decoration: BoxDecoration(
                          color: const Color(0xFFE1677D),
                          borderRadius: BorderRadius.circular(15)),
                      child:
                          const Icon(Icons.add, color: Colors.black, size: 20),
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

// Clipper para el arco inferior
class BottomArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    //const double offset = 40;
    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(
      size.width / 2, size.height - 80, // Control point
      size.width, size.height - 20, // End point
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
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
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 45),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFFBE3CF),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border, width: 0.5),
          ),
          child: Row(
            children: [
              Container(
                width: 15,
                height: 52,
                decoration: BoxDecoration(
                    color: _barColor, borderRadius: BorderRadius.circular(10)),
              ),
              const SizedBox(width: 16),
              Container(
                width: 50,
                height: 50,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFC5BD4F),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('${event.date.day.toString().padLeft(2, '0')}',
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 0, 0, 0))),
                    Text(_monthName(event.date.month).substring(0, 3),
                        style: const TextStyle(
                            fontSize: 10, color: Color.fromARGB(255, 0, 0, 0))),
                  ],
                ),
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
                            fontSize: 12, color: Color.fromARGB(255, 0, 0, 0))),
                  ],
                ),
              ),
              if (event.time != null)
              Padding(
                padding: const EdgeInsets.only(top: 18),
                child:Text(event.time!,
                    style: const TextStyle(
                        fontSize: 12, color: Color.fromARGB(255, 0, 0, 0))
                        ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          child: Center(
            child: Icon(
              _isCompleted ? Icons.check_circle : Icons.circle,
              color: _isCompleted
                  ? const Color(0xFFE1677D)
                  : const Color(0xFFC5BD4F),
              size: 24,
            ),
          ),
        ),
      ],
    );
  }
}

class _SegmentedFormatToggle extends StatefulWidget {
  final CalendarFormat selectedFormat;
  final Function(CalendarFormat) onFormatChanged;

  const _SegmentedFormatToggle({
    required this.selectedFormat,
    required this.onFormatChanged,
  });

  @override
  State<_SegmentedFormatToggle> createState() => _SegmentedFormatToggleState();
}

class _SegmentedFormatToggleState extends State<_SegmentedFormatToggle>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(_SegmentedFormatToggle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedFormat != widget.selectedFormat) {
      _animationController.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFBF4EA),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              final isMonth = widget.selectedFormat == CalendarFormat.month;

              return Positioned(
                left: isMonth ? 0 : 50,
                top: 0,
                bottom: 0,
                width: 50,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBE3CF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              );
            },
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 50,
                child: GestureDetector(
                  onTap: () {
                    widget.onFormatChanged(CalendarFormat.month);
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: const Text(
                      'Mes',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 50,
                child: GestureDetector(
                  onTap: () {
                    widget.onFormatChanged(CalendarFormat.week);
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: const Text(
                      'Año',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
          color: selected ? const Color(0xFFFBE3CF) : const Color(0xFFFBF4EA),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(label,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 0, 0, 0))),
      ),
    );
  }
}
