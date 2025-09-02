// data/models/weight_entry_model.dart
import '../../domain/entities/weight_entry.dart';

class WeightEntryModel extends WeightEntry {
  WeightEntryModel({required super.date, required super.kg});

  factory WeightEntryModel.fromJson(Map<String, dynamic> json) {
    return WeightEntryModel(
      date: DateTime.parse(json['date']),
      kg: json['kg'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'kg': kg,
    };
  }
}
