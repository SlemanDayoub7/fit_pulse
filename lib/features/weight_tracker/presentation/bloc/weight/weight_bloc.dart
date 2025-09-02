import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/features/weight_tracker/data/data_sources/weight_entry_model.dart';
import 'package:gym_app/features/weight_tracker/data/models/weight_entry_model.dart';
import 'package:gym_app/features/weight_tracker/presentation/bloc/weight/weight_event.dart';
import 'package:gym_app/features/weight_tracker/presentation/bloc/weight/weight_state.dart';

class WeightBloc extends Bloc<WeightEvent, WeightState> {
  final LocalDataSource dataSource;

  WeightBloc(this.dataSource) : super(WeightState([])) {
    on<LoadWeightEntries>((event, emit) async {
      final data = await dataSource.getEntries();
      emit(WeightState(data));
    });

    on<AddWeightEntry>((event, emit) async {
      final entry = WeightEntryModel(date: DateTime.now(), kg: event.kg);
      await dataSource.saveEntry(entry);
      add(LoadWeightEntries());
    });
  }
}
