class Gecko {
  final String id;
  final String name;
  final String morph;
  final String age; // ej: "1 año y 6 meses"
  final String? imageUrl;
  final String gender; // 'male' | 'female' | 'unknown'
  final double weightKg;
  final DateTime? lastFed;

  const Gecko({
    required this.id,
    required this.name,
    required this.morph,
    required this.age,
    this.imageUrl,
    this.gender = 'unknown',
    this.weightKg = 0.0,
    this.lastFed,
  });
}

class GeckoEvent {
  final String id;
  final String geckoId;
  final DateTime date;
  final String title;
  final String type; // 'vaccine' | 'checkup' | 'food' | 'other'
  final String? time;

  const GeckoEvent({
    required this.id,
    required this.geckoId,
    required this.date,
    required this.title,
    required this.type,
    this.time,
  });
}

class StoreItem {
  final String id;
  final String name;
  final String category; // 'Gecko' | 'Serpientes' | 'Aves'
  final double price;
  final String? imageUrl;
  bool isFavorite;

  StoreItem({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    this.imageUrl,
    this.isFavorite = false,
  });
}
