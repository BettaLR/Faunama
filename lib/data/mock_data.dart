import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import '../models/gecko.dart';

class MockData {
  static const _kGeckosKey = 'mock_geckos_v1';
  static const _kEventsKey = 'mock_events_v1';
  static const _kPatientsKey = 'mock_patients_v1';
  static List<Gecko> geckos = [];
  static List<Patient> patients = [];

  static final List<GeckoEvent> events = [];
  // Notifier to let UI rebuild when events change
  static final ValueNotifier<int> eventsNotifier = ValueNotifier<int>(0);
  static final ValueNotifier<int> patientsNotifier = ValueNotifier<int>(0);

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    // load geckos
    final rawGeckos = prefs.getString(_kGeckosKey);
    if (rawGeckos != null) {
      try {
        final list = json.decode(rawGeckos) as List<dynamic>;
        geckos = list.map((e) => Gecko.fromJson(e as Map<String, dynamic>)).toList();
      } catch (_) {
        geckos = [];
      }
    } else {
      geckos = [];
    }

    // load patients
    final rawPatients = prefs.getString(_kPatientsKey);
    if (rawPatients != null) {
      try {
        final list = json.decode(rawPatients) as List<dynamic>;
        patients = list.map((e) => Patient.fromJson(e as Map<String, dynamic>)).toList();
      } catch (_) {
        patients = [];
      }
    } else {
      patients = [];
    }

    // load events
    final rawEvents = prefs.getString(_kEventsKey);
    if (rawEvents != null) {
      try {
        final list = json.decode(rawEvents) as List<dynamic>;
        events.clear();
        events.addAll(list.map((e) => GeckoEvent.fromJson(e as Map<String, dynamic>)).toList());
        eventsNotifier.value = eventsNotifier.value + 1;
      } catch (_) {
        events.clear();
      }
    } else {
      events.clear();
    }
  }

  static Future<void> save() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final rawGeckos = json.encode(geckos.map((g) => g.toJson()).toList());
      await prefs.setString(_kGeckosKey, rawGeckos);
      final rawEvents = json.encode(events.map((e) => e.toJson()).toList());
      await prefs.setString(_kEventsKey, rawEvents);
      final rawPatients = json.encode(patients.map((p) => p.toJson()).toList());
      await prefs.setString(_kPatientsKey, rawPatients);
    } catch (e, st) {
      // ignore: avoid_print
      print('MockData.save error: $e');
      // ignore: avoid_print
      print(st);
    }
  }

  static Future<void> addGecko(Gecko g) async {
    geckos.add(g);
    await save();
  }

  static Future<void> addPatient(Patient p) async {
    patients.add(p);
    try {
      await save();
      patientsNotifier.value = patientsNotifier.value + 1;
    } catch (e, st) {
      // ignore: avoid_print
      print('MockData.addPatient error: $e');
      // ignore: avoid_print
      print(st);
    }
  }

  static Future<void> updatePatient(Patient p) async {
    final idx = patients.indexWhere((x) => x.id == p.id);
    if (idx != -1) {
      patients[idx] = p;
      try {
        await save();
        patientsNotifier.value = patientsNotifier.value + 1;
      } catch (e, st) {
        // ignore: avoid_print
        print('MockData.updatePatient error: $e');
        // ignore: avoid_print
        print(st);
      }
    }
  }

  static Future<void> removePatient(String id) async {
    patients.removeWhere((x) => x.id == id);
    try {
      await save();
      patientsNotifier.value = patientsNotifier.value + 1;
    } catch (e, st) {
      // ignore: avoid_print
      print('MockData.removePatient error: $e');
      // ignore: avoid_print
      print(st);
    }
  }

  static Future<void> addEvent(GeckoEvent e) async {
    events.add(e);
    try {
      await save();
      // notify listeners (incrementing the int is enough)
      eventsNotifier.value = eventsNotifier.value + 1;
    } catch (e, st) {
      // ignore: avoid_print
      print('MockData.addEvent error: $e');
      // ignore: avoid_print
      print(st);
    }
  }

  static Future<void> toggleCompleted(GeckoEvent e) async {
    final idx = events.indexWhere((x) => x.id == e.id);
    if (idx == -1) return;
    events[idx].completed = !events[idx].completed;
    try {
      await save();
      eventsNotifier.value = eventsNotifier.value + 1;
    } catch (err, st) {
      // ignore: avoid_print
      print('MockData.toggleCompleted error: $err');
      // ignore: avoid_print
      print(st);
    }
  }

  static Future<void> removeEvent(GeckoEvent e) async {
    events.removeWhere((x) => x.id == e.id);
    try {
      await save();
      eventsNotifier.value = eventsNotifier.value + 1;
    } catch (e, st) {
      // ignore: avoid_print
      print('MockData.removeEvent error: $e');
      // ignore: avoid_print
      print(st);
    }
  }

  static final List<StoreItem> storeItems = [
    StoreItem(id: '1', name: 'Hypo Pied', category: 'Gecko', price: 0.0),
    StoreItem(id: '2', name: 'Tangerine Leo', category: 'Gecko', price: 0.0),
    StoreItem(id: '3', name: 'Tangerine Leo', category: 'Gecko', price: 0.0),
    StoreItem(id: '4', name: 'Super Gravel', category: 'Serpientes', price: 0.0),
    StoreItem(id: '5', name: 'Blackhead', category: 'Serpientes', price: 0.0),
    StoreItem(id: '6', name: 'Tangerine Leo', category: 'Gecko', price: 0.0),
  ];
  // Notifier to let UI rebuild when store items (favorites) change
  static final ValueNotifier<int> storeNotifier = ValueNotifier<int>(0);
}
