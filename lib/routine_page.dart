// lib/routine_page.dart
import 'package:flutter/material.dart';
import 'package:myapp/models/exercise_model.dart';
import 'package:myapp/models/routine_model.dart';
// Este es el archivo que crearemos en el siguiente paso.
// El error aquí es temporal.
import 'package:myapp/exercise_detail_page.dart';

class RoutinePage extends StatefulWidget {
  final Routine routine;
  const RoutinePage({super.key, required this.routine});

  @override
  createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  // Estado para guardar el peso y las repeticiones (a futuro)
  Map<String, List<TextEditingController>> weightControllers = {};
  Map<String, List<TextEditingController>> repsControllers = {};
  final int defaultSets = 3;

  @override
  void initState() {
    super.initState();
    // Inicializa los controladores para cada ejercicio
    for (var exercise in widget.routine.exercises) {
      weightControllers[exercise.id] = List.generate(defaultSets, (_) => TextEditingController(text: '0'));
      repsControllers[exercise.id] = List.generate(defaultSets, (_) => TextEditingController(text: '8'));
    }
  }

@override
void dispose() {
  // Libera la memoria de los controladores usando bucles 'for'
  for (final controllers in weightControllers.values) {
    for (final controller in controllers) {
      controller.dispose();
    }
  }
  for (final controllers in repsControllers.values) {
    for (final controller in controllers) {
      controller.dispose();
    }
  }
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.routine.name),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: widget.routine.exercises.length,
        itemBuilder: (context, index) {
          final exercise = widget.routine.exercises[index];
          return _buildExerciseCard(exercise);
        },
      ),
    );
  }

  Widget _buildExerciseCard(Exercise exercise) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título del ejercicio y botón de información
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    exercise.name,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.info_outline, color: Theme.of(context).colorScheme.primary),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExerciseDetailPage(exercise: exercise),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Títulos de la tabla
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('SET', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                const Text('PESO (KG)', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                const Text('REPS', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                Checkbox(value: false, onChanged: (v) {}, visualDensity: VisualDensity.compact),
              ],
            ),
            const Divider(),
            // Filas de sets, peso y reps
            ...List.generate(defaultSets, (setIndex) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${setIndex + 1}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 70,
                      child: TextField(
                        controller: weightControllers[exercise.id]![setIndex],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.all(8),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 70,
                      child: TextField(
                        controller: repsControllers[exercise.id]![setIndex],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.all(8),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Checkbox(value: false, onChanged: (v) {}),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}