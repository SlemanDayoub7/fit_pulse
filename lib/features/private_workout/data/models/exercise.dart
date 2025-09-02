class Exercise {
  final String name;
  final int sets;
  final List<int> repsPerSet;
  final int restSeconds;
  final List<String> imagesPaths;
  final String? notes;
  Exercise({
    this.notes,
    required this.name,
    required this.sets,
    required this.repsPerSet,
    required this.restSeconds,
    required this.imagesPaths,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'sets': sets,
        'notes': notes,
        'repsPerSet': repsPerSet,
        'restSeconds': restSeconds,
        'imagePath': imagesPaths,
      };

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        name: json['name'],
        notes: json['notes'],
        sets: json['sets'],
        repsPerSet: List<int>.from(json['repsPerSet']),
        restSeconds: json['restSeconds'],
        imagesPaths: List<String>.from(json['imagePath']),
      );
}
