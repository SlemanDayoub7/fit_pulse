class ExerciseSetProgress {
  final int setIndex;
  double? weight; // الوزن المستخدم
  Duration? duration; // الوقت المستغرق للجولة
  bool completed;

  ExerciseSetProgress({
    required this.setIndex,
    this.weight,
    this.duration,
    this.completed = false,
  });
}
