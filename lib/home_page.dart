// lib/home_page.dart
import 'package:flutter/material.dart';
import 'package:myapp/asistencia_page.dart';
import 'package:myapp/entrenamiento_page.dart';
import 'package:myapp/profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        backgroundColor: Colors.grey[900],
        automaticallyImplyLeading: false, // Oculta el botón de regreso
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bienvenido, Usuario', // Puedes cambiar esto por el nombre del usuario
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // 2 módulos por fila
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildModuleCard(
                    context: context,
                    icon: Icons.check_circle_outline,
                    title: 'Asistencia',
                    page: const AsistenciaPage(),
                  ),
                  _buildModuleCard(
                    context: context,
                    icon: Icons.fitness_center,
                    title: 'Entrenamiento',
                    page: const EntrenamientoPage(),
                  ),
                  _buildModuleCard(
                    context: context,
                    icon: Icons.person_outline,
                    title: 'Perfil',
                    page: const ProfilePage(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget reutilizable para crear las tarjetas de los módulos
  Widget _buildModuleCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required Widget page,
  }) {
    return Card(
      elevation: 4,
      color: Colors.grey[800],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.deepPurple.shade200),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}