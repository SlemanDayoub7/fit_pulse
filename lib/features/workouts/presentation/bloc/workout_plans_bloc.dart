// workout_plan_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/features/workouts/domain/usecases/workout_plans_use_case.dart';
import 'package:gym_app/features/workouts/presentation/bloc/workout_plans_event.dart';
import 'package:gym_app/features/workouts/presentation/bloc/workout_plans_state.dart';

class WorkoutPlansBloc extends Bloc<WorkoutPlanEvent, WorkoutPlanState> {
  final GetWorkoutPlansUseCase getWorkoutPlansUseCase;

  WorkoutPlansBloc({
    required this.getWorkoutPlansUseCase,
  }) : super(WorkoutPlanInitial()) {
    on<LoadWorkoutPlan>((event, emit) async {
      emit(WorkoutPlanLoading());
    });

    on<LoadWorkoutPlans>((event, emit) async {
      emit(WorkoutPlanLoading());
      var response = await getWorkoutPlansUseCase.call();
      response.when(success: (workoutPlansResponse) async {
        emit(WorkoutPlansLoaded(workoutPlansResponse));
      }, failure: (e) {
        emit(WorkoutPlanError(e.apiErrorModel.message ?? 'An error occurred'));
      });
    });
  }
}
