import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../theme/app_theme.dart';
import '../../data/mock_data.dart';
import '../../models/gecko.dart';
import '../../widgets/common_widgets.dart';

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

  void _showAddEventSheet(BuildContext context) {
    final titleController = TextEditingController();
    String type = 'salud';
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();
    final otherController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(2)),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Nuevo evento',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color.fromARGB(255, 0, 0, 0))),
              const SizedBox(height: 20),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Descripción', style: TextStyle(fontSize: 13, color: Colors.black)),
                  const SizedBox(height: 6),
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: 'Ej: Revisión rutinaria',
                      hintStyle: const TextStyle(fontSize: 14, color: Colors.black),
                      filled: true,
                      fillColor: AppColors.cream,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.border, width: 0.5)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.border, width: 0.5)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.green, width: 1.5)),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),
              const Text('Tipo', style: TextStyle(fontSize: 13, color: Colors.black)),
              const SizedBox(height: 8),

              StatefulBuilder(builder: (context, setStateSB) {
                return Wrap(
                  spacing: 8,
                  children: [
                    GestureDetector(
                      onTap: () => setStateSB(() => type = 'salud'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: type == 'salud' ? AppColors.greenCard : AppColors.cream,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: type == 'salud' ? AppColors.green : AppColors.border, width: type == 'salud' ? 1.5 : 0.5),
                        ),
                        child: Text('Evento', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: type == 'salud' ? AppColors.green : Colors.black)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setStateSB(() => type = 'rutina'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: type == 'rutina' ? AppColors.greenCard : AppColors.cream,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: type == 'rutina' ? AppColors.green : AppColors.border, width: type == 'rutina' ? 1.5 : 0.5),
                        ),
                        child: Text('Recordatorio', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: type == 'rutina' ? AppColors.green : Colors.black)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setStateSB(() => type = 'otro'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: type == 'otro' ? AppColors.greenCard : AppColors.cream,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: type == 'otro' ? AppColors.green : AppColors.border, width: type == 'otro' ? 1.5 : 0.5),
                        ),
                        child: Text('Otro', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: type == 'otro' ? AppColors.green : Colors.black)),
                      ),
                    ),
                  ],
                );
              }),

              if (type == 'otro') ...[
                const SizedBox(height: 8),
                TextField(controller: otherController, decoration: const InputDecoration(hintText: 'Describe el tipo (ej: vacuna casera)')),
              ],

              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: ctx,
                    initialDate: selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                    builder: (c, child) => Theme(data: Theme.of(c).copyWith(colorScheme: const ColorScheme.light(primary: AppColors.green)), child: child!),
                  );
                  if (picked != null) setState(() => selectedDate = picked);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(color: AppColors.cream, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.border, width: 0.5)),
                  child: Row(children: [const Icon(Icons.calendar_today, size: 16, color: AppColors.green), const SizedBox(width: 10), Text('${selectedDate.day}/${selectedDate.month}/${selectedDate.year}', style: const TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 0, 0)))]),
                ),
              ),

              const SizedBox(height: 12),
              GestureDetector(
                onTap: () async {
                  final picked = await showTimePicker(context: ctx, initialTime: selectedTime);
                  if (picked != null) setState(() => selectedTime = picked);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(color: AppColors.cream, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.border, width: 0.5)),
                  child: Row(children: [const Icon(Icons.access_time, size: 16, color: AppColors.green), const SizedBox(width: 10), Text(selectedTime.format(ctx), style: const TextStyle(fontSize: 14))]),
                ),
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      final id = DateTime.now().millisecondsSinceEpoch.toString();
                      final typeValue = type == 'otro' && otherController.text.isNotEmpty ? otherController.text : type;
                      final timeStr = selectedTime.format(ctx);
                      final ge = GeckoEvent(
                        id: id, 
                        geckoId: '', 
                        date: DateTime(selectedDate.year, selectedDate.month, selectedDate.day, selectedTime.hour, selectedTime.minute), 
                        title: titleController.text.isNotEmpty ? titleController.text : 'Evento', 
                        type: typeValue, 
                        time: timeStr
                      );
                      await MockData.addEvent(ge);
                    } catch (e, st) {
                      // ignore: avoid_print
                      print('Error saving event (agenda): $e');
                      // ignore: avoid_print
                      print(st);
                    }
                    Navigator.pop(ctx);
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 0),
                  child: const Text('Guardar', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<GeckoEvent> get _upcomingEvents {
    return MockData.events.toList()..sort((a, b) => a.date.compareTo(b.date));
  }

  @override
  Widget build(BuildContext context) {
    final isYearly = _calendarFormat == CalendarFormat.week;

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SafeArea(
              child: ClipPath(
                clipper: BottomArcClipper(),
                child: Container(
                  width: double.infinity,
                  height: isYearly ? 650 : null,
                  color: const Color(0xFFA0BC4D),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                        child: _SegmentedFormatToggle(
                          selectedFormat: _calendarFormat,
                          onFormatChanged: (format) {
                            setState(() {
                              _calendarFormat = format;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (isYearly)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: YearlyCalendar(
                              year: _focusedDay.year,
                              selectedDay: _selectedDay ?? DateTime.now(),
                              onMonthTap: (date) {
                                setState(() {
                                  _calendarFormat = CalendarFormat.month;
                                  _focusedDay = date;
                                  _selectedDay = date;
                                });
                              },
                            ),
                          ),
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 60),
                          child: TableCalendar(
                            firstDay: DateTime.utc(2024, 1, 1),
                            lastDay: DateTime.utc(2027, 12, 31),
                            focusedDay: _focusedDay,
                            calendarFormat: CalendarFormat.month,
                            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                            onDaySelected: (selectedDay, focusedDay) {
                              try {
                                setState(() {
                                  _selectedDay = selectedDay;
                                  _focusedDay = focusedDay;
                                });
                              } catch (e, st) {
                                // ignore: avoid_print
                                print('Error en onDaySelected: $e');
                                // ignore: avoid_print
                                print(st);
                              }
                            },
                            eventLoader: (day) => MockData.events.where((e) => e.date.year == day.year && e.date.month == day.month && e.date.day == day.day).toList(),
                            calendarStyle: CalendarStyle(
                              todayDecoration: BoxDecoration(color: const Color(0xFFFBF4EA), borderRadius: BorderRadius.circular(8)),
                              todayTextStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w600),
                              selectedDecoration: BoxDecoration(color: const Color(0xFFFBF4EA), borderRadius: BorderRadius.circular(8)),
                              selectedTextStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w700),
                              markerDecoration: const BoxDecoration(color: AppColors.orange, shape: BoxShape.circle),
                              markerSize: 5,
                              markersMaxCount: 1,
                              defaultTextStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 13),
                              weekendTextStyle: const TextStyle(color: Color.fromARGB(179, 0, 0, 0), fontSize: 13),
                              outsideTextStyle: const TextStyle(color: Color.fromARGB(97, 0, 0, 0), fontSize: 13),
                              disabledTextStyle: const TextStyle(color: Color.fromARGB(60, 0, 0, 0), fontSize: 13),
                              cellMargin: const EdgeInsets.all(4),
                            ),
                            headerStyle: const HeaderStyle(
                              formatButtonVisible: false,
                              titleCentered: true,
                              titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color.fromARGB(255, 0, 0, 0)),
                              leftChevronIcon: Icon(Icons.chevron_left, color: Color.fromARGB(255, 0, 0, 0), size: 24),
                              rightChevronIcon: Icon(Icons.chevron_right, color: Color.fromARGB(255, 0, 0, 0), size: 24),
                              headerPadding: EdgeInsets.symmetric(vertical: 10),
                            ),
                            daysOfWeekStyle: const DaysOfWeekStyle(
                              weekdayStyle: TextStyle(fontSize: 11, color: Color.fromARGB(179, 0, 0, 0), fontWeight: FontWeight.w500),
                              weekendStyle: TextStyle(fontSize: 11, color: Color.fromARGB(179, 0, 0, 0), fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 6),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Próximos eventos', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                        Text('Organiza tus momentos importantes', style: TextStyle(fontSize: 11, color: Color.fromARGB(255, 0, 0, 0))),
                      ],
                    ),
                  ),
                  Container(width: 12, height: 12, decoration: BoxDecoration(color: AppColors.orange, borderRadius: BorderRadius.circular(3))),
                  const SizedBox(width: 4),
                  Container(width: 12, height: 12, decoration: BoxDecoration(color: AppColors.red, borderRadius: BorderRadius.circular(3))),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () => _showAddEventSheet(context),
                    child: Container(width: 40, height: 32, decoration: BoxDecoration(color: const Color(0xFFE1677D), borderRadius: BorderRadius.circular(15)), child: const Icon(Icons.add, color: Colors.black, size: 20)),
                  ),
                ],
              ),
            ),
          ),

          ValueListenableBuilder<int>(
            valueListenable: MockData.eventsNotifier,
            builder: (context, _, __) {
              final events = _upcomingEvents;
              if (events.isEmpty) {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text('Aun no hay eventos registrados', style: TextStyle(fontSize: 13, color: Colors.black), textAlign: TextAlign.center),
                    ),
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) => Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                    child: _EventCard(
                      event: events[i],
                      onDelete: (e) {
                        MockData.removeEvent(e);
                        setState(() {});
                      },
                    ),
                  ),
                  childCount: events.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class BottomArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(size.width / 2, size.height - 80, size.width, size.height - 20);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _EventCard extends StatefulWidget {
  final GeckoEvent event;
  final void Function(GeckoEvent)? onDelete;
  const _EventCard({required this.event, this.onDelete});

  Color get _barColor {
    switch (event.type) {
      case 'salud':
      case 'vaccine':
        return const Color(0xFFC53D3D);
      case 'rutina':
      case 'checkup':
        return const Color(0xFFFF994D);
      case 'food':
        return const Color(0xFFCB8C2A);
      default:
        return const Color(0xFFE1677D);
    }
  }

  String _weekdayName(DateTime d) {
    const days = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'];
    return days[d.weekday - 1];
  }

  String _monthName(int m) {
    const months = ['', 'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio', 'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'];
    return months[m];
  }

  @override
  State<_EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<_EventCard> {
  bool _showDelete = false;

  void _toggleDelete() => setState(() => _showDelete = !_showDelete);

  @override
  Widget build(BuildContext context) {
    final event = widget.event;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.only(left: 45, right: _showDelete ? 60 : 0, bottom: 8),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(color: const Color(0xFFFBE3CF), borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.border, width: 0.5)),
                child: GestureDetector(
                  onTap: _toggleDelete,
                  child: Row(
                    children: [
                      Container(width: 15, height: 52, decoration: BoxDecoration(color: widget._barColor, borderRadius: BorderRadius.circular(10))),
                      const SizedBox(width: 16),
                      Container(
                        width: 50,
                        height: 50,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: widget._barColor, borderRadius: BorderRadius.circular(10)),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                          Text(event.date.day.toString().padLeft(2, '0'), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color.fromARGB(255, 0, 0, 0))),
                          Text(widget._monthName(event.date.month).substring(0, 3), style: const TextStyle(fontSize: 10, color: Color.fromARGB(255, 0, 0, 0))),
                        ]),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text('${widget._weekdayName(event.date)} ${event.date.day} de ${widget._monthName(event.date.month)}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                          Text(event.title, style: const TextStyle(fontSize: 12, color: Color.fromARGB(255, 0, 0, 0))),
                        ]),
                      ),
                      if (event.time != null) Padding(padding: const EdgeInsets.only(top: 18), child: Text(event.time!, style: const TextStyle(fontSize: 12, color: Color.fromARGB(255, 0, 0, 0)))),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        Positioned(
          left: 0,
          top: 28,
          child: GestureDetector(
            onTap: () async {
              await MockData.toggleCompleted(widget.event);
              setState(() {});
            },
            child: Container(width: 28, height: 28, decoration: BoxDecoration(color: event.completed ? const Color(0xFFE1677D) : const Color(0xFFC5BD4F), shape: BoxShape.circle, border: Border.all(color: event.completed ? const Color(0xFFE1677D) : const Color(0xFFC5BD4F), width: 0)), child: event.completed ? const Icon(Icons.check, size: 16, color: Colors.black) : null),
          ),
        ),

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
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFA0BC4D), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), elevation: 0, minimumSize: const Size(48, 48)),
                    onPressed: () {
                      if (widget.onDelete != null) {
                        widget.onDelete!(widget.event);
                      } else {
                        MockData.removeEvent(widget.event);
                        setState(() {});
                      }
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
}

class _SegmentedFormatToggle extends StatefulWidget {
  final CalendarFormat selectedFormat;
  final Function(CalendarFormat) onFormatChanged;

  const _SegmentedFormatToggle({required this.selectedFormat, required this.onFormatChanged});

  @override
  State<_SegmentedFormatToggle> createState() => _SegmentedFormatToggleState();
}

class _SegmentedFormatToggleState extends State<_SegmentedFormatToggle> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
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
      decoration: BoxDecoration(color: const Color(0xFFFBF4EA), borderRadius: BorderRadius.circular(20)),
      child: Stack(children: [
        AnimatedBuilder(animation: _animationController, builder: (context, child) {
          final isMonth = widget.selectedFormat == CalendarFormat.month;
          return Positioned(left: isMonth ? 0 : 50, top: 0, bottom: 0, width: 50, child: AnimatedContainer(duration: const Duration(milliseconds: 300), decoration: BoxDecoration(color: const Color(0xFFFBE3CF), borderRadius: BorderRadius.circular(20))));
        }),
        Row(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(width: 50, child: GestureDetector(onTap: () => widget.onFormatChanged(CalendarFormat.month), child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8), child: const Text('Mes', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color.fromARGB(255, 0, 0, 0)),),),),),
          SizedBox(width: 50, child: GestureDetector(onTap: () => widget.onFormatChanged(CalendarFormat.week), child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8), child: const Text('Año', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color.fromARGB(255, 0, 0, 0)),),),),),
        ])
      ]),
    );
  }
}
