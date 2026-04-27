import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: ListView(
          children: [
            // Header verde con arco y avatar
            ClipPath(
              clipper: BottomArcClipper(),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 90),
                color: Color(0xFFA0BC4D),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        const Center(
                          child: Text('Perfil',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromARGB(255, 0, 0, 0))),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFBF4EA),
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Icon(Icons.settings_outlined,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    size: 25),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Avatar y información del perfil
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Avatar
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/icono_perfil.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Información del perfil
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Cassandra Batalla',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            const SizedBox(height: 4),
                            const Text('cassbat.02@gmail.com',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            const SizedBox(height: 2),
                            const Text('+52 (999) 201 0856',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            const SizedBox(height: 4),
                            const Text('cuidador',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Color.fromARGB(255, 0, 0, 0))),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFBF4EA),
                        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Editar',
                          style: TextStyle(fontSize: 13)),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Sección: Invitar familiar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _ProfileSection(
                title: 'Invitar familiar',
                trailing: Container(
                    width: 40,
                    height: 30,
                    decoration: BoxDecoration(
                        color: const Color(0xFFE1677D),
                        borderRadius: BorderRadius.circular(15)),
                    child: const Icon(Icons.add,
                        size: 20, color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBE3CF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Image(
                      image: AssetImage('assets/images/invitar_familiar.png'),
                      fit: BoxFit.contain,
                      width: 350,
                      height: 300,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Sección: Conviértete en...
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _ProfileSection(
                title: 'Conviértete en...',
                subtitle: 'El dueño que tu mascota desea',
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBE3CF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(0, 232, 132, 74).withOpacity(0.0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Image(
                          image: AssetImage('assets/images/planes.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Conoce todos nuestros planes...',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            Text('Con ellos podras desbloquear más funciones',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 0, 0, 0))),
                          ],
                        ),
                      ),
                      Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: Color(0xFFC5BD4F),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(Icons.chevron_right,
                              color: Colors.black, size: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Sección: Logros
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _ProfileSection(
                title: 'Logros',
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBE3CF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFFC53D3D),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Cuidado constante',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            Text(
                                'Has registrado 3 meses de cuidado constante',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 0, 0, 0))),
                          ],
                        ),
                      ),
                      const Icon(Icons.star,
                          color: Color(0xFFFF994D), size: 35),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
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
    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(
      size.width / 2, size.height - 80,
      size.width, size.height - 20,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _ProfileSection extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final Widget? trailing;

  const _ProfileSection(
      {required this.title, this.subtitle, required this.child, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark)),
            if (trailing != null) ...[
              const Spacer(),
              trailing!,
            ],
          ],
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(subtitle!,
              style: const TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 0, 0, 0))),
        ],
        const SizedBox(height: 15),
        child,
      ],
    );
  }
}

class _PlaceholderIllustration extends StatelessWidget {
  const _PlaceholderIllustration();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: AppColors.orangeSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Icon(Icons.people_outline,
            size: 40, color: AppColors.orange),
      ),
    );
  }
}
