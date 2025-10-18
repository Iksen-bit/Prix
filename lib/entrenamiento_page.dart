// lib/entrenamiento_page.dart
import 'package:flutter/material.dart';
import 'package:myapp/data/dummy_data.dart';
import 'package:myapp/models/routine_model.dart';
// ¡Importante! Crearemos estas páginas en los siguientes pasos.
// Por ahora, tu editor mostrará un error aquí, es normal.
import 'package:myapp/routine_page.dart';
import 'package:myapp/custom_routine_builder_page.dart';


class EntrenamientoPage extends StatelessWidget {
  const EntrenamientoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rutinas de Entrenamiento'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Selecciona tu rutina',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Elige una rutina predeterminada o crea la tuya.',
              style: TextStyle(fontSize: 16, color: Colors.grey[400]),
            ),
            const SizedBox(height: 32),

            // Botones de Rutinas Predeterminadas
            _buildRoutineButton(
              context: context,
              routine: chestRoutine,
              icon: Icons.line_weight,
            ),
            const SizedBox(height: 16),
            _buildRoutineButton(
              context: context,
              routine: legRoutine,
              icon: Icons.airline_stops_sharp,
            ),
            const SizedBox(height: 16),
            _buildRoutineButton(
              context: context,
              routine: backRoutine,
              icon: Icons.accessibility_new,
            ),
            const Divider(height: 48, thickness: 1),

            // Botón de Rutina Personalizada
            ElevatedButton.icon(
              icon: const Icon(Icons.add, size: 28),
              label: const Text('Crear Rutina Personalizada'),
              onPressed: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CustomRoutineBuilderPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget reutilizable para los botones de rutina
  Widget _buildRoutineButton({
    required BuildContext context,
    required Routine routine,
    required IconData icon,
  }) {
    return OutlinedButton.icon(
      icon: Icon(icon, size: 28),
      label: Text(routine.name),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RoutinePage(routine: routine)),
        );
      },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        foregroundColor: Theme.of(context).colorScheme.primary,
        side: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}