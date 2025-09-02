abstract class TrainingEvent {}

class StartExerciseTimer extends TrainingEvent {}

class PauseExerciseTimer extends TrainingEvent {}

class Tick extends TrainingEvent {}

class FinishSet extends TrainingEvent {}

class SkipExercise extends TrainingEvent {}

class TickRest extends TrainingEvent {}

class IncrementReps extends TrainingEvent {}

class DecrementReps extends TrainingEvent {}

class SkipRest extends TrainingEvent {}
