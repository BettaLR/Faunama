import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../theme/app_theme.dart';
import '../../models/gecko.dart';
import '../../data/mock_data.dart';
import '../../widgets/common_widgets.dart';
import 'subpantallas/blog_screen.dart';

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
  }

  List<GeckoEvent> get _upcomingEvents {
    final now = DateTime.now();
    return MockData.events
        .where((e) => e.date.isAfter(now.subtract(const Duration(days: 1))))
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  GeckoEvent? get _nextEvent {
    if (_upcomingEvents.isEmpty) return null;
    return _upcomingEvents.first;
  }

  String _formatEventDateTime(DateTime dateTime) {
    final months = ['enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
                    'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'];
    final weekdays = ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'];
    
    final dayName = weekdays[dateTime.weekday % 7];
    final day = dateTime.day;
    final month = months[dateTime.month - 1];
    return '$dayName $day de $month';
  }

  String _formatEventTime(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
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
                                'Hola "Wild Care"',
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
                    Row(
                      children: [
                        _HeaderIcon(icon: Icons.notifications_none, onTap: () {}),
                        const SizedBox(width: 8),
                        _AvatarIcon(),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // ── Tip card ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 16, 15, 0),
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

            // ── Próximo evento ──
            if (_nextEvent != null)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _formatEventDateTime(_nextEvent!.date),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark,
                        ),
                      ),
                      Text(
                        _formatEventTime(_nextEvent!.date),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
                  child: Center(
                    child: Text(
                      'No hay eventos registrados',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.textLight,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(100, 16, 100, 0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _showAddEventSheet(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFBE3CF),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: AppColors.border, width: 0.5),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Añadir evento',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // ── Pacientes ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
                child: SectionHeader(
                  title: 'Pacientes',
                  trailing: GreenFab(onTap: () => _showAddPatientSheet(context)),
                ),
              ),
            ),
            ValueListenableBuilder<int>(
              valueListenable: MockData.patientsNotifier,
              builder: (context, _, __) {
                if (MockData.patients.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(40.0),
                      child: Center(
                        child: Text(
                          'No hay pacientes registrados.',
                          style: TextStyle(color: AppColors.textLight),
                        ),
                      ),
                    ),
                  );
                }
                return SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, i) {
                        // Show only the 3 most recent patients
                        final recentPatients = MockData.patients.reversed.toList();
                        return PatientCard(
                          patient: recentPatients[i],
                          onEdit: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (_) => _AddPatientSheet(patient: recentPatients[i]),
                            );
                          },
                        );
                      },
                      childCount: MockData.patients.length > 3 ? 3 : MockData.patients.length,
                    ),
                  ),
                );
              },
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }

  void _showAddPatientSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _AddPatientSheet(),
    );
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

// ─── Bottom sheet: agregar paciente ───
class _AddPatientSheet extends StatefulWidget {
  final Patient? patient;
  const _AddPatientSheet({this.patient});

  @override
  State<_AddPatientSheet> createState() => _AddPatientSheetState();
}

class _AddPatientSheetState extends State<_AddPatientSheet> {
  late final TextEditingController _ownerController;
  late final TextEditingController _petNameController;
  late final TextEditingController _symptomsController;
  late final TextEditingController _notesController;
  
  late String _species;
  late String _gender;
  late String _maturity;
  late String _morph;
  late String _condition;
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _ownerController = TextEditingController(text: widget.patient?.ownerName);
    _petNameController = TextEditingController(text: widget.patient?.petName);
    _symptomsController = TextEditingController(text: widget.patient?.symptoms);
    _notesController = TextEditingController(text: widget.patient?.notes);
    
    _species = widget.patient?.species ?? 'Gecko';
    _gender = widget.patient?.gender ?? 'unknown';
    _maturity = widget.patient?.maturity ?? 'Adulto';
    _morph = widget.patient?.morph ?? 'Albino';
    _condition = widget.patient?.condition ?? 'mild';
    _imagePath = widget.patient?.imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    final bool isEditing = widget.patient != null;

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
      child: SingleChildScrollView(
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
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(isEditing ? 'Editar Paciente' : 'Información General',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            const SizedBox(height: 20),
            
            _SheetField(controller: _ownerController, label: 'Dueño*', hint: 'Escribir'),
            const SizedBox(height: 12),
            _SheetField(controller: _petNameController, label: 'Nombre de la mascota*', hint: 'Escribir'),
            const SizedBox(height: 12),
            
            const Text('Especie*', style: TextStyle(fontSize: 13, color: Colors.black)),
            const SizedBox(height: 6),
            _DropdownField(
              value: _species,
              items: const ['Gecko', 'Serpiente', 'Ave', 'Otro'],
              onChanged: (v) => setState(() => _species = v!),
            ),
            
            const SizedBox(height: 12),
            const Text('Sexo', style: TextStyle(fontSize: 13, color: Colors.black)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _GenderChipExtended(label: 'Macho', value: 'male', selected: _gender == 'male', onTap: () => setState(() => _gender = 'male'), icon: Icons.male),
                _GenderChipExtended(label: 'Hembra', value: 'female', selected: _gender == 'female', onTap: () => setState(() => _gender = 'female'), icon: Icons.female),
                _GenderChipExtended(label: 'Mixto', value: 'mixed', selected: _gender == 'mixed', onTap: () => setState(() => _gender = 'mixed'), icon: Icons.group),
                _GenderChipExtended(label: 'Desconocido', value: 'unknown', selected: _gender == 'unknown', onTap: () => setState(() => _gender = 'unknown'), icon: Icons.help_outline),
              ],
            ),
            
            const SizedBox(height: 12),
            const Text('Madurez*', style: TextStyle(fontSize: 13, color: Colors.black)),
            const SizedBox(height: 6),
            _DropdownField(
              value: _maturity,
              items: const ['Cría', 'Juvenil', 'Sub-adulto', 'Adulto'],
              onChanged: (v) => setState(() => _maturity = v!),
            ),
            
            const SizedBox(height: 12),
            const Text('Fase*', style: TextStyle(fontSize: 13, color: Colors.black)),
            const SizedBox(height: 6),
            _DropdownField(
              value: _morph,
              items: const ['Albino', 'Tremper', 'Pied', 'Normal', 'Otro'],
              onChanged: (v) => setState(() => _morph = v!),
            ),
            
            const SizedBox(height: 12),
            const Text('Condición*', style: TextStyle(fontSize: 13, color: Colors.black)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _ConditionChip(label: 'Leve', value: 'mild', selected: _condition == 'mild', color: const Color(0xFFA0BC4D), onTap: () => setState(() => _condition = 'mild')),
                _ConditionChip(label: 'Grave', value: 'severe', selected: _condition == 'severe', color: const Color(0xFFC53D3D), onTap: () => setState(() => _condition = 'severe')),
                _ConditionChip(label: 'Crónico', value: 'chronic', selected: _condition == 'chronic', color: const Color(0xFFE1677D), onTap: () => setState(() => _condition = 'chronic')),
                _ConditionChip(label: 'Agudo', value: 'acute', selected: _condition == 'acute', color: const Color(0xFFFF994D), onTap: () => setState(() => _condition = 'acute')),
              ],
            ),
            
            const SizedBox(height: 12),
            _SheetField(controller: _symptomsController, label: 'Síntomas*', hint: 'Escribir', maxLines: 3),
            
            const SizedBox(height: 20),
            const Text('Imagen*', style: TextStyle(fontSize: 13, color: Colors.black)),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                final picker = ImagePicker();
                final XFile? file = await picker.pickImage(source: ImageSource.gallery);
                if (file != null) setState(() => _imagePath = file.path);
              },
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.cream,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border, width: 0.5),
                ),
                child: _imagePath == null
                    ? const Center(child: Icon(Icons.add_a_photo, size: 48, color: AppColors.textLight))
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: _imagePath!.startsWith('assets/') 
                          ? Image.asset(_imagePath!, fit: BoxFit.cover)
                          : Image.file(File(_imagePath!), fit: BoxFit.cover),
                      ),
              ),
            ),
            
            const SizedBox(height: 12),
            _SheetField(controller: _notesController, label: 'Notas', hint: 'Escribir', maxLines: 4),
            
            const SizedBox(height: 24),
            Row(
              children: [
                if (isEditing) ...[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        await MockData.removePatient(widget.patient!.id);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC53D3D),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      child: const Text('Eliminar',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_ownerController.text.isEmpty || _petNameController.text.isEmpty) return;
                      
                      final p = Patient(
                        id: isEditing ? widget.patient!.id : DateTime.now().millisecondsSinceEpoch.toString(),
                        ownerName: _ownerController.text.trim(),
                        petName: _petNameController.text.trim(),
                        species: _species,
                        gender: _gender,
                        maturity: _maturity,
                        morph: _morph,
                        condition: _condition,
                        symptoms: _symptomsController.text.trim(),
                        notes: _notesController.text.trim(),
                        imageUrl: _imagePath,
                        nextAppointment: widget.patient?.nextAppointment ?? DateTime.now().add(const Duration(days: 7)),
                      );
                      
                      if (isEditing) {
                        await MockData.updatePatient(p);
                      } else {
                        await MockData.addPatient(p);
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
                    child: Text(isEditing ? 'Actualizar' : 'Guardar',
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SheetField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final int maxLines;

  const _SheetField(
      {required this.controller, required this.label, required this.hint, this.maxLines = 1});

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
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle:
                const TextStyle(fontSize: 14, color: AppColors.textLight),
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

class _DropdownField extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _DropdownField({required this.value, required this.items, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          items: items.map((s) => DropdownMenuItem(value: s, child: Text(s, style: const TextStyle(fontSize: 14)))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _GenderChipExtended extends StatelessWidget {
  final String label;
  final String value;
  final bool selected;
  final VoidCallback onTap;
  final IconData icon;

  const _GenderChipExtended(
      {required this.label,
      required this.value,
      required this.selected,
      required this.onTap,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 40,
            decoration: BoxDecoration(
              color: selected ? (value == 'male' ? const Color(0xFFA0BC4D) : value == 'female' ? const Color(0xFFE1677D) : value == 'mixed' ? const Color(0xFFC53D3D) : const Color(0xFFFF994D)) : AppColors.cream,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selected ? Colors.transparent : AppColors.border,
                width: 0.5,
              ),
            ),
            child: Icon(icon, size: 24, color: selected ? Colors.black : Colors.black54),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class _ConditionChip extends StatelessWidget {
  final String label;
  final String value;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _ConditionChip({required this.label, required this.value, required this.selected, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? color : AppColors.cream,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: selected ? Colors.transparent : AppColors.border, width: 0.5),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            color: selected ? Colors.black : Colors.black87,
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
                _ConditionChip(
                  label: 'Evento',
                  value: 'salud',
                  selected: _type == 'salud',
                  color: const Color(0xFFA0BC4D),
                  onTap: () => setState(() => _type = 'salud')),
                _ConditionChip(
                  label: 'Recordatorio',
                  value: 'rutina',
                  selected: _type == 'rutina',
                  color: const Color(0xFFA0BC4D),
                  onTap: () => setState(() => _type = 'rutina')),
              _ConditionChip(
                  label: 'Otro',
                  value: 'otro',
                  selected: _type == 'otro',
                  color: const Color(0xFFA0BC4D),
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
                      date: DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, _selectedTime.hour, _selectedTime.minute),
                      title: _titleController.text.isNotEmpty ? _titleController.text : 'Evento',
                      type: typeValue,
                      time: timeStr,
                    );
                    await MockData.addEvent(ge);
                  } catch (e, st) {
                    // ignore: avoid_print
                    print('Error saving event (prof): $e');
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
