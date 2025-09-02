// weight_repository.dart
import 'package:gym_app/features/weight_tracker/data/models/weight.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class WeightRepository {
  final Box<Weight> _box;

  WeightRepository(this._box);

  Future<void> addWeight(Weight weight) async {
    await _box.put(weight.date.millisecondsSinceEpoch, weight);
  }

  List<Weight> getWeights() {
    return _box.values.toList();
  }
}
