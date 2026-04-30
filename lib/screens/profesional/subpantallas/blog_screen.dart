import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  String _selectedCategory = 'Todo';
  final List<String> _categories = ['Todo', 'Cuidado', 'Alimentación', 'Salud', 'Curiosidades'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Column(
          children: [
            // Header con título centrado, botón atrás y búsqueda
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
              child: Row(
                children: [
                  // Botón para regresar
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFA0BC4D),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(Icons.arrow_back,
                            color: Color.fromARGB(255, 0, 0, 0), size: 20),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Título centrado
                  const Expanded(
                    child: Center(
                      child: Text('Blogs',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textDark)),
                    ),
                  ),
                  // Botón de búsqueda
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFA0BC4D),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(Icons.search,
                          color: Color.fromARGB(255, 0, 0, 0), size: 20),
                    ),
                  ),
                ],
              ),
            ),
            // Subtítulo con botón de añadir
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('¡Date un tiempo de lectura o crea!',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark)),
                  GestureDetector(
                    onTap: () {
                      // Acción para crear nuevo blog
                    },
                    child: Container(
                      width: 40,
                      height: 30,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE1677D),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(Icons.add, color: Colors.black, size: 20),
                    ),
                  ),
                ],
              ),
            ),
            // Filtros/etiquetas para cambiar de página
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _categories.map((cat) {
                    final selected = cat == _selectedCategory;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedCategory = cat),
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 8),
                        decoration: BoxDecoration(
                          color: selected
                              ? const Color(0xFFE1677D)
                              : const Color(0xFFA0BC4D),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: selected
                                  ? const Color(0xFFE1677D)
                                  : const Color(0xFFA0BC4D),
                              width: 0.5),
                        ),
                        child: Text(cat,
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 0, 0, 0))),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            // Lista de blogs
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return _BlogCard(
                    onVerMas: () {
                      // Acción para ver más
                    },
                    onIr: () {
                      // Acción para ir al blog completo
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

class _BlogCard extends StatelessWidget {
  final VoidCallback onVerMas;
  final VoidCallback onIr;

  const _BlogCard({required this.onVerMas, required this.onIr});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFBE3CF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen a la izquierda
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFFBF4EA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(Icons.image,
                  size: 36, color: Color(0xFFFBE3CF)),
            ),
          ),
          const SizedBox(width: 12),
          // Contenido a la derecha
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Subtítulo
                const Text('Cómo cuidar a tu gecko',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark)),
                const SizedBox(height: 4),
                // Texto
                const Text(
                    'Aprende los mejores consejos para mantener a tu mascota saludable y feliz...',
                    style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 0, 0, 0)),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 8),
                // Ver más y botón ir
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: onVerMas,
                      child: const Text('Ver más',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFFF994D))),
                    ),
                    GestureDetector(
                      onTap: onIr,
                      child: Container(
                        width: 30,
                        height: 20,
                        decoration: BoxDecoration(
                            color: const Color(0xFFFF994D),
                            borderRadius: BorderRadius.circular(15)),
                        child: const Icon(Icons.chevron_right,
                            size: 20, color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}