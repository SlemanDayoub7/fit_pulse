// // weight_bloc.dart
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gym_app/features/weight_tracker/data/models/weight.dart';
// import 'package:gym_app/features/weight_tracker/data/repositories/weight_repository.dart';

// class WeightBloc extends Bloc<WeightEvent, WeightState> {
//   final WeightRepository _repository;

//   WeightBloc(this._repository) : super(WeightInitial()) {
//     on<AddWeight>((event, emit) async {
//       await _repository.addWeight(event.weight);
//       emit(WeightUpdated(_repository.getWeights()));
//     });

//     on<GetWeights>((_, emit) {
//       emit(WeightUpdated(_repository.getWeights()));
//     });
//   }
// }

// abstract class WeightEvent {}

// class AddWeight extends WeightEvent {
//   final Weight weight;

//   AddWeight(this.weight);
// }

// class GetWeights extends WeightEvent {}

// abstract class WeightState {}

// class WeightInitial extends WeightState {}

// class WeightUpdated extends WeightState {
//   final List<Weight> weights;

//   WeightUpdated(this.weights);
// }
