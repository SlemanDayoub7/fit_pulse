import 'package:equatable/equatable.dart';
import 'package:gym_app/features/workouts/data/models/response_models/sport.dart';

abstract class SportState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SportInitial extends SportState {}

class SportLoading extends SportState {}

class SportsLoaded extends SportState {
  final List<Sport> sports;

  SportsLoaded(this.sports);

  @override
  List<Object?> get props => [sports];
}

class SportError extends SportState {
  final String message;

  SportError(this.message);

  @override
  List<Object?> get props => [message];
}
