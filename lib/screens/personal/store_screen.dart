import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../data/mock_data.dart';
import '../../models/gecko.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  String _selectedCategory = 'Todo';
  final List<String> _categories = ['Todo', 'Gecko', 'Serpientes', 'Aves'];

  List<StoreItem> get _filtered {
    if (_selectedCategory == 'Todo') return MockData.storeItems;
    return MockData.storeItems
        .where((i) => i.category == _selectedCategory)
        .toList();
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
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
              child: Row(
                children: [
                  // Corazón
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFA0BC4D),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(Icons.favorite_border,
                          color: Color.fromARGB(255, 0, 0, 0), size: 20),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Carrito
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFA0BC4D),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(Icons.shopping_bag_outlined,
                          color: Color.fromARGB(255, 0, 0, 0), size: 20),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text('Tienda',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textDark)),
                    ),
                  ),
                  // Búsqueda
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
                  const SizedBox(width: 12),
                  // Avatar
                  Container(
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
                  ),
                ],
              ),
            ),
            // Filtros
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 12),
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
            // Grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.78,
                ),
                itemCount: _filtered.length,
                itemBuilder: (context, i) {
                  final item = _filtered[i];
                  return _StoreCard(
                    item: item,
                    onFavTap: () => setState(() {
                      item.isFavorite = !item.isFavorite;
                    }),
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

class _StoreCard extends StatelessWidget {
  final StoreItem item;
  final VoidCallback onFavTap;

  const _StoreCard({required this.item, required this.onFavTap});

  @override
  Widget build(BuildContext context) {
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
            color: const Color(0xFFFBE3CF),
            child: const Center(
              child: Icon(Icons.image,
                  size: 48, color: Color(0xFFFBF4EA)),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: onFavTap,
              child: Icon(
                item.isFavorite ? Icons.favorite : Icons.favorite_border,
                size: 25,
                color: item.isFavorite
                    ? const Color(0xFFA0BC4D)
                    : const Color.fromARGB(255, 0, 0, 0),
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
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark)),
                  const SizedBox(height: 2),
                  Text(
                    item.price == 0.0
                        ? '\$0.0'
                        : '\$${item.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w500),
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
