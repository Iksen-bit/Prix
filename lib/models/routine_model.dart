// lib/models/routine_model.dart

import 'package:myapp/models/exercise_model.dart';

class Routine {
  final String id;
  final String name;
  final List<Exercise> exercises;

  Routine({
    required this.id,
    required this.name,
    required this.exercises,
  });
}