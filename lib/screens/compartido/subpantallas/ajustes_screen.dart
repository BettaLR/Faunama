import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class AjustesScreen extends StatefulWidget {
  const AjustesScreen({super.key});

  @override
  State<AjustesScreen> createState() => _AjustesScreenState();
}

// Simple custom switch without Material overlay/border
class _CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeTrackColor;
  final Color inactiveTrackColor;
  final Color activeThumbColor;
  final Color inactiveThumbColor;

  const _CustomSwitch({
    required this.value,
    required this.onChanged,
    required this.activeTrackColor,
    required this.inactiveTrackColor,
    required this.activeThumbColor,
    required this.inactiveThumbColor,
  });

  @override
  State<_CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<_CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    final trackColor = widget.value ? widget.activeTrackColor : widget.inactiveTrackColor;
    final thumbColor = widget.value ? widget.activeThumbColor : widget.inactiveThumbColor;

    return GestureDetector(
      onTap: () => widget.onChanged(!widget.value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 52,
        height: 30,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: trackColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Align(
          alignment: widget.value ? Alignment.centerRight : Alignment.centerLeft,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 22,
            height: 22,
            decoration: BoxDecoration(color: thumbColor, shape: BoxShape.circle),
          ),
        ),
      ),
    );
  }
}

class _AjustesScreenState extends State<AjustesScreen> {
  bool _format24 = false;
  bool _darkMode = false;

  Widget _optionRow(String text, {Widget? trailing, String? trailingText}) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Expanded(child: Text(text, style: const TextStyle(fontSize: 14, color: Colors.black))),
            if (trailingText != null) ...[
              Text(trailingText, style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w300)),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right, color: Colors.black),
            ] else if (trailing != null) ...[
              trailing,
            ] else ...[
              const Icon(Icons.chevron_right, color: Colors.black),
            ]
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF4EA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                const SizedBox(height: 24),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(color: const Color(0xFFA0BC4D), shape: BoxShape.circle),
                        child: const Center(child: Icon(Icons.arrow_back, color: Colors.black, size: 20)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Center(
                        child: Text('Configuración', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textDark)),
                      ),
                    ),
                    const SizedBox(width: 52),
                  ],
                ),

                const SizedBox(height: 18),

                const Text('Información', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(color: const Color(0xFFFBE3CF), borderRadius: BorderRadius.circular(8)),
                  child: Column(children: [
                    _optionRow('Contáctanos'),
                    _optionRow('Gestión de suscripción'),
                    _optionRow('Opciones de pago'),
                    _optionRow('Centro de ayuda'),
                  ]),
                ),

                const SizedBox(height: 20),

                const Text('General', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(color: const Color(0xFFFBE3CF), borderRadius: BorderRadius.circular(8)),
                  child: Column(children: [
                    _optionRow('Mi cuenta'),
                    _optionRow('Idioma', trailingText: 'Español'),
                    // Formato 24 hrs with switch replacing chevron
                    _optionRow(
                      'Formato 24 hrs',
                      trailing: _CustomSwitch(
                        value: _format24,
                        onChanged: (v) => setState(() => _format24 = v),
                        activeTrackColor: const Color(0xFFE1677D),
                        inactiveTrackColor: const Color(0xFFC5BD4F),
                        activeThumbColor: const Color(0xFFB94055),
                        inactiveThumbColor: const Color(0xFF899E3F),
                      ),
                    ),
                    _optionRow('Notificaciones', trailingText: 'Si'),
                    _optionRow(
                      'Modo oscuro',
                      trailing: _CustomSwitch(
                        value: _darkMode,
                        onChanged: (v) => setState(() => _darkMode = v),
                        activeTrackColor: const Color(0xFFE1677D),
                        inactiveTrackColor: const Color(0xFFC5BD4F),
                        activeThumbColor: const Color(0xFFB94055),
                        inactiveThumbColor: const Color(0xFF899E3F),
                      ),
                    ),
                  ]),
                ),

                const SizedBox(height: 20),

                const Text('Privacidad', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(color: const Color(0xFFFBE3CF), borderRadius: BorderRadius.circular(8)),
                  child: Column(children: [
                    _optionRow('Permisos del dispositivo'),
                    _optionRow('Información'),
                  ]),
                ),

                const SizedBox(height: 20),

                const Text('Búsquedas', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(color: const Color(0xFFFBE3CF), borderRadius: BorderRadius.circular(8)),
                  child: Column(children: [
                    _optionRow('Me gusta'),
                    _optionRow('Búsquedas recientes'),
                  ]),
                ),

                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(onPressed: () {}, child: const Text('Eliminar perfil', style: TextStyle(color: Colors.red))),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
