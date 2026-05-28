import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../theme/app_theme.dart';
import '../models/gecko.dart';
import '../data/mock_data.dart';

class AddGeckoSheet extends StatefulWidget {
  const AddGeckoSheet({super.key});

  @override
  State<AddGeckoSheet> createState() => _AddGeckoSheetState();
}

class _AddGeckoSheetState extends State<AddGeckoSheet> {
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
          SheetField(
              controller: _nameController, label: 'Nombre', hint: 'Ej: Mondo'),
          const SizedBox(height: 12),
          SheetField(
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
              GenderChip(
                  label: 'Macho',
                  value: 'male',
                  selected: _gender == 'male',
                  onTap: () => setState(() => _gender = 'male')),
              const SizedBox(width: 8),
              GenderChip(
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

class SheetField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;

  const SheetField(
      {super.key, required this.controller, required this.label, required this.hint});

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

class GenderChip extends StatelessWidget {
  final String label;
  final String value;
  final bool selected;
  final VoidCallback onTap;

  const GenderChip(
      {super.key, required this.label,
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
