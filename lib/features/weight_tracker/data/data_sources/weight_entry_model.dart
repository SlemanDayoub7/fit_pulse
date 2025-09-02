// data/datasources/local_data_source.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/weight_entry_model.dart';

class LocalDataSource {
  final SharedPreferences prefs;

  LocalDataSource(this.prefs);

  static const _key = 'weight_entries';

  Future<void> saveEntry(WeightEntryModel entry) async {
    final list = await getEntries();
    list.removeWhere((e) =>
        e.date.day == entry.date.day &&
        e.date.month == entry.date.month &&
        e.date.year == entry.date.year);
    list.add(entry);
    final jsonList = list.map((e) => e.toJson()).toList();
    await prefs.setString(_key, jsonEncode(jsonList));
  }

  Future<List<WeightEntryModel>> getEntries() async {
    final jsonString = prefs.getString(_key);
    if (jsonString == null) return [];
    final List decoded = jsonDecode(jsonString);
    return decoded.map((e) => WeightEntryModel.fromJson(e)).toList();
  }
}
