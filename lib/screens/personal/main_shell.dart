import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'home_screen.dart';
import 'store_screen.dart';
import 'agenda_screen.dart';
import 'registro_screen.dart';
import 'perfil_screen.dart';

class PersonalMainShell extends StatefulWidget {
  static final GlobalKey<_PersonalMainShellState> globalKey = GlobalKey<_PersonalMainShellState>();

  const PersonalMainShell({Key? key}) : super(key: key);

  @override
  State<PersonalMainShell> createState() => _PersonalMainShellState();
}

class _PersonalMainShellState extends State<PersonalMainShell> {
  int _currentIndex = 2;
  int? _registroInitialIndex;

  void openRegistro({int? geckoIndex}) {
    setState(() {
      _currentIndex = 3;
      _registroInitialIndex = geckoIndex;
    });
  }

  void openPerfil() {
    setState(() {
      _currentIndex = 4;
    });
  }

  List<Widget> get _screens => [
        const StoreScreen(),
        const AgendaScreen(),
        const HomeScreen(),
        RegistroScreen(initialIndex: _registroInitialIndex),
        const PerfilScreen(),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFFBF4EA),
          boxShadow: [
            BoxShadow(
              color: Color(0x12000000),
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Image.asset(
                  'assets/images/linea_divisora.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _NavItem(
                      imagePath: 'assets/images/tienda_ss.png',
                      label: 'Tienda',
                      index: 0,
                      currentIndex: _currentIndex,
                      onTap: (i) => setState(() => _currentIndex = i),
                    ),
                    _NavItem(
                      imagePath: 'assets/images/calendario_ss.png',
                      label: 'Calendario',
                      index: 1,
                      currentIndex: _currentIndex,
                      onTap: (i) => setState(() => _currentIndex = i),
                    ),
                    _NavItem(
                      imagePath: 'assets/images/inicio_ss.png',
                      label: 'Inicio',
                      index: 2,
                      currentIndex: _currentIndex,
                      onTap: (i) => setState(() => _currentIndex = i),
                    ),
                    _NavItem(
                      imagePath: 'assets/images/registros_ss.png',
                      label: 'Registro',
                      index: 3,
                      currentIndex: _currentIndex,
                      onTap: (i) => setState(() => _currentIndex = i),
                    ),
                    _NavItem(
                      imagePath: 'assets/images/perfil_ss.png',
                      label: 'Perfil',
                      index: 4,
                      currentIndex: _currentIndex,
                      onTap: (i) => setState(() => _currentIndex = i),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String imagePath;
  final String label;
  final int index;
  final int currentIndex;
  final void Function(int) onTap;

  const _NavItem({
    required this.imagePath,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final selected = index == currentIndex;
    final displayImagePath = selected 
      ? imagePath.replaceAll('_ss.png', '_s.png')
      : imagePath;
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              displayImagePath,
              width: 26,
              height: 26,
              color: selected ? null : Colors.black,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: selected ? AppColors.green : AppColors.textLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
