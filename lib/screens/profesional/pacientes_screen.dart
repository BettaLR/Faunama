import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../theme/app_theme.dart';
import '../../data/mock_data.dart';
import '../../models/gecko.dart';
import '../../widgets/common_widgets.dart';

class PacientesScreen extends StatefulWidget {
  final int? initialIndex;

  const PacientesScreen({super.key, this.initialIndex});

  @override
  State<PacientesScreen> createState() => _PacientesScreenState();
}

class _PacientesScreenState extends State<PacientesScreen> {
  String _selectedCondition = 'all';

  void _showAddPatientSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _AddPatientSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xFFA0BC4D),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.search, color: Colors.black, size: 20),
                  ),
                  const Text(
                    'Pacientes',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  GreenFab(
                    onTap: () => _showAddPatientSheet(context),
                  ),
                ],
              ),
            ),

            // Condition Filters
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: _FilterChip(
                      label: 'Leve',
                      color: const Color(0xFFA0BC4D),
                      selected: _selectedCondition == 'mild',
                      onTap: () => setState(() => _selectedCondition = _selectedCondition == 'mild' ? 'all' : 'mild'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _FilterChip(
                      label: 'Grave',
                      color: const Color(0xFFC53D3D),
                      selected: _selectedCondition == 'severe',
                      onTap: () => setState(() => _selectedCondition = _selectedCondition == 'severe' ? 'all' : 'severe'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _FilterChip(
                      label: 'Crónico',
                      color: const Color(0xFFE1677D),
                      selected: _selectedCondition == 'chronic',
                      onTap: () => setState(() => _selectedCondition = _selectedCondition == 'chronic' ? 'all' : 'chronic'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _FilterChip(
                      label: 'Agudo',
                      color: const Color(0xFFFF994D),
                      selected: _selectedCondition == 'acute',
                      onTap: () => setState(() => _selectedCondition = _selectedCondition == 'acute' ? 'all' : 'acute'),
                    ),
                  ),
                ],
              ),
            ),

            // Patient List
            Expanded(
              child: ValueListenableBuilder<int>(
                valueListenable: MockData.patientsNotifier,
                builder: (context, _, __) {
                  final filteredPatients = _selectedCondition == 'all'
                      ? MockData.patients
                      : MockData.patients.where((p) => p.condition == _selectedCondition).toList();

                  if (filteredPatients.isEmpty) {
                    return const Center(
                      child: Text(
                        'No hay pacientes con esta condición.',
                        style: TextStyle(color: AppColors.textLight),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    itemCount: filteredPatients.length,
                    itemBuilder: (context, i) {
                      final p = filteredPatients[i];
                      return PatientCard(
                        patient: p,
                        onEdit: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (_) => _AddPatientSheet(patient: p),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
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
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? color : AppColors.cream,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: selected ? Colors.transparent : AppColors.border, width: 0.5),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            color: selected ? Colors.black : Colors.black87,
          ),
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? color : color.withOpacity(0.4),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? Colors.black26 : Colors.transparent,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.black : Colors.black54,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            fontSize: 11,
          ),
        ),
      ),
    );
  }
}
