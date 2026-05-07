class Gecko {
  final String id;
  final String name;
  final String morph;
  final String age; // ej: "1 año y 6 meses"
  final String? imageUrl;
  final String gender; // 'male' | 'female' | 'unknown'
  final double weightKg;
  final DateTime? lastFed;
  final String? behaviorNotes;
  final String? symptoms;

  const Gecko({
    required this.id,
    required this.name,
    required this.morph,
    required this.age,
    this.imageUrl,
    this.gender = 'unknown',
    this.weightKg = 0.0,
    this.lastFed,
    this.behaviorNotes,
    this.symptoms,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'morph': morph,
        'age': age,
        'imageUrl': imageUrl,
        'gender': gender,
        'weightKg': weightKg,
        'lastFed': lastFed?.toIso8601String(),
        'behaviorNotes': behaviorNotes,
        'symptoms': symptoms,
      };

  factory Gecko.fromJson(Map<String, dynamic> j) => Gecko(
        id: j['id'] as String,
        name: j['name'] as String,
        morph: j['morph'] as String,
        age: j['age'] as String,
        imageUrl: j['imageUrl'] as String?,
        gender: j['gender'] as String? ?? 'unknown',
        weightKg: (j['weightKg'] is num) ? (j['weightKg'] as num).toDouble() : 0.0,
        lastFed: j['lastFed'] != null ? DateTime.parse(j['lastFed'] as String) : null,
        behaviorNotes: j['behaviorNotes'] as String?,
        symptoms: j['symptoms'] as String?,
      );
}

class Patient {
  final String id;
  final String ownerName;
  final String petName;
  final String species;
  final String gender; // 'male' | 'female' | 'mixed' | 'unknown'
  final String maturity;
  final String morph; // 'fase'
  final String condition; // 'mild' | 'severe' | 'chronic' | 'acute'
  final String symptoms;
  final String? imageUrl;
  final String? notes;
  final DateTime? nextAppointment;

  const Patient({
    required this.id,
    required this.ownerName,
    required this.petName,
    required this.species,
    required this.gender,
    required this.maturity,
    required this.morph,
    required this.condition,
    required this.symptoms,
    this.imageUrl,
    this.notes,
    this.nextAppointment,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'ownerName': ownerName,
        'petName': petName,
        'species': species,
        'gender': gender,
        'maturity': maturity,
        'morph': morph,
        'condition': condition,
        'symptoms': symptoms,
        'imageUrl': imageUrl,
        'notes': notes,
        'nextAppointment': nextAppointment?.toIso8601String(),
      };

  factory Patient.fromJson(Map<String, dynamic> j) => Patient(
        id: j['id'] as String,
        ownerName: j['ownerName'] as String,
        petName: j['petName'] as String,
        species: j['species'] as String,
        gender: j['gender'] as String,
        maturity: j['maturity'] as String,
        morph: j['morph'] as String,
        condition: j['condition'] as String,
        symptoms: j['symptoms'] as String,
        imageUrl: j['imageUrl'] as String?,
        notes: j['notes'] as String?,
        nextAppointment: j['nextAppointment'] != null ? DateTime.parse(j['nextAppointment'] as String) : null,
      );
}

class GeckoEvent {
  final String id;
  final String geckoId;
  final DateTime date;
  final String title;
  final String type; // 'vaccine' | 'checkup' | 'food' | 'other'
  String? time;
  bool completed;

  GeckoEvent({
    required this.id,
    required this.geckoId,
    required this.date,
    required this.title,
    required this.type,
    this.time,
    this.completed = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'geckoId': geckoId,
        'date': date.toIso8601String(),
        'title': title,
        'type': type,
        'time': time,
        'completed': completed,
      };

  factory GeckoEvent.fromJson(Map<String, dynamic> j) => GeckoEvent(
        id: j['id'] as String,
        geckoId: j['geckoId'] as String,
        date: DateTime.parse(j['date'] as String),
        title: j['title'] as String,
        type: j['type'] as String,
        time: j['time'] as String?,
        completed: j['completed'] as bool? ?? false,
      );
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
