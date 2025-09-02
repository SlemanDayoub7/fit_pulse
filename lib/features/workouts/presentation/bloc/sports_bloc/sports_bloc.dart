import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/features/workouts/domain/usecases/sports_use_case.dart';
import 'package:gym_app/features/workouts/presentation/bloc/sports_bloc/sports_event.dart';
import 'package:gym_app/features/workouts/presentation/bloc/sports_bloc/sports_state.dart';

class SportsBloc extends Bloc<SportEvent, SportState> {
  final GetSportsUseCase getSportsUseCase;

  SportsBloc({required this.getSportsUseCase}) : super(SportInitial()) {
    on<LoadSports>((event, emit) async {
      emit(SportLoading());
      final result = await getSportsUseCase.call();

      result.when(
        success: (sportsList) => emit(SportsLoaded(sportsList)),
        failure: (e) => emit(
            SportError(e.apiErrorModel.message ?? 'Failed to load sports')),
      );
    });
  }
}
