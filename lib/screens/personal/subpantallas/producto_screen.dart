import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import '../../../models/gecko.dart';
import '../../../data/mock_data.dart';

class ProductoScreen extends StatelessWidget {
  final StoreItem item;
  final String imagePath;

  const ProductoScreen({super.key, required this.item, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipPath(
                clipper: _BottomArcClipper(),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(20, 40, 20, 240),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(color: const Color(0xFFFBF4EA), shape: BoxShape.circle),
                          child: const Center(child: Icon(Icons.arrow_back, color: Colors.black, size: 20)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Price
                    Text(
                      item.price == 0.0 ? '\$0.0' : '\$${item.price.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
                    ),
                    const SizedBox(height: 8),
                    // Name
                    Text(item.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black)),
                    const SizedBox(height: 6),
                    // Publisher
                    const Text('Publicado por: Tienda Faunama', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300, color: Colors.black)),
                    const SizedBox(height: 14),

                    // Descripción subtitle
                    const Text('Descripción', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black)),
                    const SizedBox(height: 8),
                    // Details lines
                    const Text('Especie: Leopard Gecko', style: TextStyle(fontSize: 13, color: Colors.black)),
                    const SizedBox(height: 4),
                    const Text('Fase: Adulto', style: TextStyle(fontSize: 13, color: Colors.black)),
                    const SizedBox(height: 4),
                    const Text('Sexo: Macho', style: TextStyle(fontSize: 13, color: Colors.black)),
                    const SizedBox(height: 4),
                    const Text('Origen: Crianza', style: TextStyle(fontSize: 13, color: Colors.black)),
                    const SizedBox(height: 12),

                    // Description container
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: const Color(0xFFFBE3CF), borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.border, width: 0.5)),
                      child: const Text('Ejemplar en buen estado, criado en ambiente controlado. Alimentación y cuidados disponibles bajo pedido.', style: TextStyle(fontSize: 13, color: Colors.black)),
                    ),
                    const SizedBox(height: 12),

                    // Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFA0BC4D), foregroundColor: Colors.black, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                            child: const Text('Añadir al carrito'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFA0BC4D), foregroundColor: Colors.black, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                            child: const Text('Comprar ahora'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Shipping subtitle
                    const Text('Envío y políticas', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black)),
                    const SizedBox(height: 8),
                    const Text('Envíos a todo el país. Consulta políticas de devolución y tiempos estimados en la sección de ayuda.', style: TextStyle(fontSize: 13, color: Colors.black)),
                    const SizedBox(height: 16),

                    // Seller container
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: const Color(0xFFFBE3CF), borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.border, width: 0.5)),
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.border, width: 0.5)),
                            child: ClipOval(child: Image.asset('assets/images/icono_perfil.png', fit: BoxFit.cover)),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                              Text('Tienda Faunama', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black)),
                              SizedBox(height: 4),
                              Text('Ubicación: Ciudad, País • Registrado desde 2022', style: TextStyle(fontSize: 12, color: Colors.black)),
                            ]),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // More items
                    const Text('Más articulos de la tienda', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black)),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 220,
                      child: ValueListenableBuilder<int>(
                        valueListenable: MockData.storeNotifier,
                        builder: (context, _, __) {
                          final others = MockData.storeItems.where((s) => s.id != item.id).toList();
                          if (others.isEmpty) return const Center(child: Text('No hay otros artículos', style: TextStyle(color: Colors.black)));
                          return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.only(top: 8),
                            itemCount: others.length,
                            separatorBuilder: (_, __) => const SizedBox(width: 12),
                            itemBuilder: (context, i) {
                              final s = others[i];
                                  return SizedBox(
                                    width: 150,
                                    child: _SmallStoreCard(
                                      item: s,
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (_) => ProductoScreen(item: s, imagePath: 'assets/images/img_tienda.JPG')));
                                      },
                                    ),
                                  );
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
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

class _BottomArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(
      size.width / 2,
      size.height - 80,
      size.width,
      size.height - 20,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _SmallStoreCard extends StatelessWidget {
  final StoreItem item;
  final VoidCallback onTap;

  const _SmallStoreCard({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFFBE3CF),
                image: const DecorationImage(
                  image: AssetImage('assets/images/img_tienda.JPG'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 6,
            right: 6,
            child: GestureDetector(
              onTap: () {
                try {
                  item.isFavorite = !item.isFavorite;
                  MockData.storeNotifier.value = MockData.storeNotifier.value + 1;
                } catch (err, st) {
                  // ignore: avoid_print
                  print(err);
                  // ignore: avoid_print
                  print(st);
                }
              },
              child: Icon(
                item.isFavorite ? Icons.favorite : Icons.favorite_border,
                size: 22,
                color: item.isFavorite ? const Color(0xFFA0BC4D) : const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
          Positioned(
            left: 8,
            right: 8,
            bottom: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.92),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.border, width: 0.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                  const SizedBox(height: 2),
                  Text(
                    item.price == 0.0 ? '\$0.0' : '\$${item.price.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 12, color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
