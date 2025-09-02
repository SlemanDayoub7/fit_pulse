abstract class WeightEvent {}

class AddWeightEntry extends WeightEvent {
  final double kg;

  AddWeightEntry(this.kg);
}

class LoadWeightEntries extends WeightEvent {}
