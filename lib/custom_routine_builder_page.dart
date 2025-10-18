// lib/custom_routine_builder_page.dart
import 'package:flutter/material.dart';
import 'package:myapp/data/dummy_data.dart';
import 'package:myapp/models/exercise_model.dart';
import 'package:myapp/models/routine_model.dart';
import 'package:myapp/routine_page.dart';

class CustomRoutineBuilderPage extends StatefulWidget {
  const CustomRoutineBuilderPage({super.key});

  @override
  createState() => _CustomRoutineBuilderPageState();
}

class _CustomRoutineBuilderPageState extends State<CustomRoutineBuilderPage> {
  final List<Exercise> _selectedExercises = [];

  void _toggleExercise(Exercise exercise) {
    setState(() {
      if (_selectedExercises.contains(exercise)) {
        _selectedExercises.remove(exercise);
      } else {
        _selectedExercises.add(exercise);
      }
    });
  }

  void _createRoutine() {
    if (_selectedExercises.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecciona al menos un ejercicio.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final newRoutine = Routine(
      id: 'custom_${DateTime.now().millisecondsSinceEpoch}',
      name: 'Mi Rutina Personalizada',
      exercises: List.from(_selectedExercises),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => RoutinePage(routine: newRoutine)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crea tu Rutina'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _createRoutine,
            tooltip: 'Crear Rutina',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Selecciona los ejercicios que quieres añadir a tu rutina. Llevas ${_selectedExercises.length} seleccionados.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[300]),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: allExercises.length,
              itemBuilder: (context, index) {
                final exercise = allExercises[index];
                final isSelected = _selectedExercises.contains(exercise);
                return ListTile(
                  title: Text(exercise.name),
                  leading: Icon(
                    isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                    color: isSelected ? Theme.of(context).colorScheme.primary : null,
                  ),
                  onTap: () => _toggleExercise(exercise),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createRoutine,
        label: const Text('Crear Rutina'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}