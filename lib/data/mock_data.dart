import '../models/gecko.dart';

class MockData {
  static final List<Gecko> geckos = [
    Gecko(
      id: '1',
      name: 'Mondo',
      morph: 'Albino',
      age: '1 año y 6 meses',
      gender: 'male',
      weightKg: 0.065,
      imageUrl: null,
    ),
    Gecko(
      id: '2',
      name: 'Robert',
      morph: 'Tangerine Leo',
      age: '6 meses',
      gender: 'male',
      weightKg: 0.032,
      imageUrl: null,
    ),
  ];

  static final List<GeckoEvent> events = [
    GeckoEvent(
      id: '1',
      geckoId: '1',
      date: DateTime(2026, 10, 6),
      title: 'Vacuna',
      type: 'vaccine',
      time: '17:00 pm',
    ),
    GeckoEvent(
      id: '2',
      geckoId: '1',
      date: DateTime(2026, 10, 15),
      title: 'Revisión rutinaria',
      type: 'checkup',
      time: '17:00 pm',
    ),
    GeckoEvent(
      id: '3',
      geckoId: '2',
      date: DateTime(2026, 10, 23),
      title: 'Cambio de alimento',
      type: 'food',
      time: '17:00 pm',
    ),
  ];

  static final List<StoreItem> storeItems = [
    StoreItem(id: '1', name: 'Hypo Pied', category: 'Gecko', price: 0.0),
    StoreItem(id: '2', name: 'Tangerine Leo', category: 'Gecko', price: 0.0),
    StoreItem(id: '3', name: 'Tangerine Leo', category: 'Gecko', price: 0.0),
    StoreItem(id: '4', name: 'Super Gravel', category: 'Serpientes', price: 0.0),
    StoreItem(id: '5', name: 'Blackhead', category: 'Serpientes', price: 0.0),
    StoreItem(id: '6', name: 'Tangerine Leo', category: 'Gecko', price: 0.0),
  ];
}
