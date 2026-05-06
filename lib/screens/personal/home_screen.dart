import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../theme/app_theme.dart';
import '../../models/gecko.dart';
import '../../data/mock_data.dart';
import '../../widgets/common_widgets.dart';
import 'subpantallas/blog_screen.dart';
import 'main_shell.dart';
// import 'registro_screen.dart'; // import no usado, comentado

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _loadData();
  }

  void _loadData() async {
    await MockData.init();
    setState(() {});
  }

  // ignore: unused_element
  List<GeckoEvent> get _eventsForSelected {
    if (_selectedDay == null) return [];
    return MockData.events.where((e) =>
        e.date.year == _selectedDay!.year &&
        e.date.month == _selectedDay!.month &&
        e.date.day == _selectedDay!.day).toList();
  }

  List<GeckoEvent> get _upcomingEvents {
    final now = DateTime.now();
    return MockData.events
        .where((e) => e.date.isAfter(now.subtract(const Duration(days: 1))))
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }
  
  // Only show the 3 nearest upcoming events on the home screen
  List<GeckoEvent> get _upcomingEventsLimited {
    final events = _upcomingEvents;
    if (events.length <= 3) return events;
    return events.take(3).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── Header ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Hola, Cass',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textDark),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                width: 60,
                                height: 2,
                                color: AppColors.border,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Íconos de cabecera
                    Row(
                      children: [
                        _HeaderIcon(
                          icon: Icons.help_outline,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => Dialog(
                                backgroundColor: Colors.transparent,
                                child: Container(
                                  width: MediaQuery.of(ctx).size.width * 0.86,
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(16, 16, 8, 0),
                                        child: Row(
                                          children: [
                                            const Text('Avisos', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black)),
                                            const Spacer(),
                                            IconButton(
                                              padding: EdgeInsets.zero,
                                              constraints: const BoxConstraints(),
                                              icon: const Icon(Icons.close, size: 20, color: Colors.black),
                                              onPressed: () => Navigator.of(ctx).pop(),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                                        child: const Text('No hay avisos nuevos', style: TextStyle(fontSize: 14, color: Colors.black)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => PersonalMainShell.globalKey.currentState?.openPerfil(),
                          child: _AvatarIcon(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // ── Tip card ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: TipCard(
                  title: 'Cuida mejor, conoce más',
                  subtitle: '¿Sabías esto sobre tu mascota?',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BlogScreen(),
                      ),
                    );
                  },
                ),
              ),
            ),

            // ── Mis geckos ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: SectionHeader(
                  title: 'Mis geckos',
                  trailing: GreenFab(onTap: () => _showAddGeckoSheet(context)),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SizedBox(
                  height: 200,
                  child: MockData.geckos.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 150,
                                child: GestureDetector(
                                  onTap: () => _showAddGeckoSheet(context),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFBE3CF),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                          color: AppColors.border, width: 0.5),
                                    ),
                                    child: const Center(
                                      child: Text('Añadir mascota',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          scrollDirection: Axis.horizontal,
                          itemCount: MockData.geckos.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 12),
                          itemBuilder: (context, i) {
                            final gecko = MockData.geckos[i];
                            return SizedBox(
                              width: 150,
                              child: GeckoCard(
                                name: gecko.name,
                                age: gecko.age,
                                gender: gecko.gender,
                                imageUrl: gecko.imageUrl,
                                onTap: () {
                                  // Switch main shell to the Registro tab and pass the selected gecko index
                                  PersonalMainShell.globalKey.currentState?.openRegistro(geckoIndex: i);
                                },
                              ),
                            );
                          },
                        ),
                ),
              ),
            ),

            // ── Descripción ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: Text(
                  'Aquí podrás encontrar a tus bichitos',
                  style: const TextStyle(
                      fontSize: 12, color: Colors.black),
                ),
              ),
            ),

            // ── Mini calendario ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: Container(
                  height: 145,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBE3CF),
                    borderRadius: BorderRadius.circular(16),
                    border:
                        Border.all(color: AppColors.border, width: 0.5),
                  ),
                  child: TableCalendar(
                    firstDay: DateTime.utc(2024, 1, 1),
                    lastDay: DateTime.utc(2027, 12, 31),
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) =>
                        isSameDay(_selectedDay, day),
                    calendarFormat: CalendarFormat.week,
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                    eventLoader: (day) {
                      return MockData.events
                          .where((e) =>
                              e.date.year == day.year &&
                              e.date.month == day.month &&
                              e.date.day == day.day)
                          .toList();
                    },
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: const Color(0xFFFFF2E9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      selectedDecoration: BoxDecoration(
                        color: const Color(0xFFFF994D),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      markerDecoration: const BoxDecoration(
                        color: AppColors.orange,
                        shape: BoxShape.circle,
                      ),
                      todayTextStyle:
                          const TextStyle(color: AppColors.textDark),
                      selectedTextStyle:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      defaultTextStyle:
                          const TextStyle(color: AppColors.textDark),
                      weekendTextStyle:
                          const TextStyle(color: Colors.black),
                      outsideTextStyle:
                          const TextStyle(color: Colors.black),
                    ),
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark),
                      leftChevronIcon:
                          Icon(Icons.chevron_left, color: Colors.black),
                      rightChevronIcon:
                          Icon(Icons.chevron_right, color: Colors.black),
                    ),
                    daysOfWeekStyle: const DaysOfWeekStyle(
                      weekdayStyle:
                          const TextStyle(fontSize: 11, color: Colors.black),
                      weekendStyle:
                          const TextStyle(fontSize: 11, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),

            // ── Próximos eventos ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: SectionHeader(
                  title: 'Próximos eventos',
                  trailing: GreenFab(onTap: () => _showAddEventSheet(context)),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
                child: Text(
                  'Organiza tus momentos importantes',
                  style: const TextStyle(
                      fontSize: 12, color: Colors.black),
                ),
              ),
            ),
            // Rebuild when events change
            ValueListenableBuilder<int>(
              valueListenable: MockData.eventsNotifier,
              builder: (context, _, __) {
                final events = _upcomingEventsLimited;
                if (events.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                      child: Text(
                        'Aun no hay eventos registrados',
                        style: const TextStyle(fontSize: 13, color: Colors.black), textAlign: TextAlign.center
                      ),
                    ),
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) {
                      final event = events[i];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                        child: EventRow(
                          event: event,
                          onToggleCompleted: (e) {
                            setState(() {});
                          },
                          onDelete: (e) async {
                            await MockData.removeEvent(e);
                            setState(() {});
                          },
                        ),
                      );
                    },
                    childCount: events.length,
                  ),
                );
              },
            )
            ,
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }

  void _showAddGeckoSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _AddGeckoSheet(),
    ).then((_) => setState(() {}));
  }

  void _showAddEventSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _AddEventSheet(),
    ).then((_) => setState(() {}));
  }
}

// ─── Header icon button ───
class _HeaderIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _HeaderIcon({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFFA0BC4D),
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFA0BC4D), width: 0.5),
        ),
        child: Icon(icon, size: 20, color: const Color.fromARGB(255, 0, 0, 0)),
      ),
    );
  }
}

class _AvatarIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFA0BC4D), width: 2),
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/images/icono_perfil.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// ─── Bottom sheet: agregar gecko ───
class _AddGeckoSheet extends StatefulWidget {
  const _AddGeckoSheet();

  @override
  State<_AddGeckoSheet> createState() => _AddGeckoSheetState();
}

class _AddGeckoSheetState extends State<_AddGeckoSheet> {
  final _nameController = TextEditingController();
  final _morphController = TextEditingController();
  String _gender = 'unknown';
  String? _imagePath;
  DateTime? _birthday;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Agregar gecko',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 0, 0, 0))),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () async {
              final picker = ImagePicker();
              final XFile? file = await picker.pickImage(source: ImageSource.gallery);
              if (file != null) setState(() => _imagePath = file.path);
            },
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.cream,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border, width: 0.5),
              ),
              child: _imagePath == null
                  ? const Center(child: Icon(Icons.add_a_photo, size: 28))
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(File(_imagePath!), fit: BoxFit.cover),
                    ),
            ),
          ),
          const SizedBox(height: 12),
          _SheetField(
              controller: _nameController, label: 'Nombre', hint: 'Ej: Mondo'),
          const SizedBox(height: 12),
          _SheetField(
              controller: _morphController,
              label: 'Morph',
              hint: 'Ej: Albino Tremper'),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
                builder: (ctx, child) => Theme(
                  data: Theme.of(ctx).copyWith(
                    colorScheme: const ColorScheme.light(primary: AppColors.green),
                  ),
                  child: child!,
                ),
              );
              if (picked != null) setState(() => _birthday = picked);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.cream,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.border, width: 0.5),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16, color: AppColors.green),
                  const SizedBox(width: 10),
                  Text(
                    _birthday == null ? 'Fecha de nacimiento' : '${_birthday!.day}/${_birthday!.month}/${_birthday!.year}',
                    style: const TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text('Género',
              style: TextStyle(fontSize: 13, color: Colors.black)),
          const SizedBox(height: 8),
          Row(
            children: [
              _GenderChip(
                  label: 'Macho',
                  value: 'male',
                  selected: _gender == 'male',
                  onTap: () => setState(() => _gender = 'male')),
              const SizedBox(width: 8),
              _GenderChip(
                  label: 'Hembra',
                  value: 'female',
                  selected: _gender == 'female',
                  onTap: () => setState(() => _gender = 'female')),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
              child: ElevatedButton(
              onPressed: () async {
                final name = _nameController.text.trim();
                final morph = _morphController.text.trim();
                if (name.isEmpty) return;
                String ageStr = '0 meses';
                if (_birthday != null) {
                  final now = DateTime.now();
                  int years = now.year - _birthday!.year;
                  int months = now.month - _birthday!.month;
                  if (now.day < _birthday!.day) months -= 1;
                  if (months < 0) {
                    years -= 1;
                    months += 12;
                  }
                  if (years > 0) {
                    ageStr = years == 1 ? '1 año' : '$years años';
                    if (months > 0) ageStr += ' y $months meses';
                  } else {
                    ageStr = '$months meses';
                  }
                }
                final newGecko = Gecko(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: name,
                  morph: morph,
                  age: ageStr,
                  imageUrl: _imagePath,
                  gender: _gender,
                );
                await MockData.addGecko(newGecko);
                if (!mounted) return;
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: const Text('Guardar',
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}

class _SheetField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;

  const _SheetField(
      {required this.controller, required this.label, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 13, color: Colors.black)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle:
                const TextStyle(fontSize: 14, color: Colors.black),
            filled: true,
            fillColor: AppColors.cream,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: AppColors.border, width: 0.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: AppColors.border, width: 0.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: AppColors.green, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

class _GenderChip extends StatelessWidget {
  final String label;
  final String value;
  final bool selected;
  final VoidCallback onTap;

  const _GenderChip(
      {required this.label,
      required this.value,
      required this.selected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.greenCard : AppColors.cream,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected ? AppColors.green : AppColors.border,
            width: selected ? 1.5 : 0.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: selected ? AppColors.green : Colors.black,
          ),
        ),
      ),
    );
  }
}

// ─── Bottom sheet: agregar evento ───
class _AddEventSheet extends StatefulWidget {
  const _AddEventSheet();

  @override
  State<_AddEventSheet> createState() => _AddEventSheetState();
}

class _AddEventSheetState extends State<_AddEventSheet> {
  final _titleController = TextEditingController();
  String _type = 'salud';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  final _otherController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
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
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 0, 0, 0))),
          const SizedBox(height: 20),
          _SheetField(
              controller: _titleController,
              label: 'Descripción',
              hint: 'Ej: Revisión rutinaria'),
          const SizedBox(height: 12),
          const Text('Tipo',
              style: TextStyle(fontSize: 13, color: Colors.black)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
                _GenderChip(
                  label: 'Evento',
                  value: 'salud',
                  selected: _type == 'salud',
                  onTap: () => setState(() => _type = 'salud')),
                _GenderChip(
                  label: 'Recordatorio',
                  value: 'rutina',
                  selected: _type == 'rutina',
                  onTap: () => setState(() => _type = 'rutina')),
              _GenderChip(
                  label: 'Otro',
                  value: 'otro',
                  selected: _type == 'otro',
                  onTap: () => setState(() => _type = 'otro')),
            ],
          ),
          if (_type == 'otro') ...[
            const SizedBox(height: 8),
            TextField(
              controller: _otherController,
              decoration: const InputDecoration(
                hintText: 'Describe el tipo (ej: vacuna casera)',
              ),
            ),
          ],
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                builder: (ctx, child) => Theme(
                  data: Theme.of(ctx).copyWith(
                    colorScheme: const ColorScheme.light(
                        primary: AppColors.green),
                  ),
                  child: child!,
                ),
              );
              if (picked != null) {
                setState(() => _selectedDate = picked);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.cream,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.border, width: 0.5),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today,
                      size: 16, color: AppColors.green),
                  const SizedBox(width: 10),
                  Text(
                    '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                    style: const TextStyle(
                        fontSize: 14, color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () async {
              final picked = await showTimePicker(
                context: context,
                initialTime: _selectedTime,
              );
              if (picked != null) setState(() => _selectedTime = picked);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.cream,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.border, width: 0.5),
              ),
              child: Row(
                children: [
                  const Icon(Icons.access_time, size: 16, color: AppColors.green),
                  const SizedBox(width: 10),
                  Text('${_selectedTime.format(context)}', style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () async {
                  try {
                    final id = DateTime.now().millisecondsSinceEpoch.toString();
                    final typeValue = _type == 'otro' && _otherController.text.isNotEmpty
                        ? _otherController.text
                        : _type;
                    final timeStr = _selectedTime.format(context);
                    final ge = GeckoEvent(
                      id: id,
                      geckoId: '',
                      date: DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day),
                      title: _titleController.text.isNotEmpty ? _titleController.text : 'Evento',
                      type: typeValue,
                      time: timeStr,
                    );
                    // ignore: avoid_print
                    print('Adding event: ${ge.toJson()}');
                    await MockData.addEvent(ge);
                    // ignore: avoid_print
                    print('Event added successfully');
                  } catch (e, st) {
                    // ignore: avoid_print
                    print('Error saving event (personal): $e');
                    // ignore: avoid_print
                    print(st);
                  }
                  Navigator.pop(context);
                },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: const Text('Guardar',
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}
