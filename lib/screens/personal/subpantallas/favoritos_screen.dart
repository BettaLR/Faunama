import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import '../../../data/mock_data.dart';

class FavoritosScreen extends StatefulWidget {
  const FavoritosScreen({super.key});

  @override
  State<FavoritosScreen> createState() => _FavoritosScreenState();
}

class _FavoritosScreenState extends State<FavoritosScreen> {
  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 24),
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
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
                        child: Text('Favoritos', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textDark)),
                      ),
                    ),
                    const SizedBox(width: 52),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // Content
              Expanded(
                child: ValueListenableBuilder<int>(
                  valueListenable: MockData.storeNotifier,
                  builder: (context, _, __) {
                    final favs = MockData.storeItems.where((i) => i.isFavorite).toList();
                    if (favs.isEmpty) {
                      return const Center(
                        child: Text('Aun no hay favoritos añadidos', style: TextStyle(fontSize: 14, color: Colors.black)),
                      );
                    }

                    return GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.78,
                      ),
                      itemCount: favs.length,
                      itemBuilder: (context, i) {
                        final item = favs[i];
                        return Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.border, width: 0.5),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: Stack(
                            children: [
                              Container(
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
                              Positioned(
                                top: 8,
                                right: 8,
                                child: GestureDetector(
                                  onTap: () {
                                    // remove favorite
                                    setState(() {
                                      item.isFavorite = false;
                                    });
                                    MockData.storeNotifier.value = MockData.storeNotifier.value + 1;
                                  },
                                  child: Icon(
                                    item.isFavorite ? Icons.favorite : Icons.favorite_border,
                                    size: 25,
                                    color: item.isFavorite ? const Color(0xFFA0BC4D) : const Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 10,
                                right: 10,
                                bottom: 10,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: AppColors.white.withOpacity(0.92),
                                    borderRadius: BorderRadius.circular(14),
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
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    } catch (err, st) {
      // If something unexpected happens, show a safe error screen instead of crashing
      // ignore: avoid_print
      print('FavoritosScreen build error: $err');
      // ignore: avoid_print
      print(st);
      return Scaffold(
        appBar: AppBar(title: const Text('Favoritos')),
        body: Center(child: Text('Error al cargar favoritos: $err')),
      );
    }
  }
}
