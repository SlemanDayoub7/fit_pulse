class ExerciseEntity {
  final String id;
  final String name;
  final String description;
  final int sets;
  final List<int> reps;
  final String? videoUrl;
  final String coverImage;

  const ExerciseEntity({
    this.videoUrl,
    required this.id,
    required this.name,
    required this.description,
    required this.sets,
    required this.reps,
    required this.coverImage,
  });
}
