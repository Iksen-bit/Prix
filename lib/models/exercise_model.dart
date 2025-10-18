// lib/models/exercise_model.dart

class Exercise {
  final String id;
  final String name;
  final String description;
  final String videoUrl;
  final List<String> steps;

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.videoUrl,
    required this.steps,
  });
}