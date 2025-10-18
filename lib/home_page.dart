// lib/home_page.dart
import 'package:flutter/material.dart';
import 'package:myapp/asistencia_page.dart';
import 'package:myapp/entrenamiento_page.dart';
import 'package:myapp/profile_page.dart';
import 'package:myapp/shop_page.dart'; // <--- IMPORTA LA NUEVA PÁGINA

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        backgroundColor: Colors.grey[900],
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bienvenido, Usuario',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
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
                   // ***** AÑADE ESTE NUEVO MÓDULO *****
                  _buildModuleCard(
                    context: context,
                    icon: Icons.storefront, // Ícono de tienda
                    title: 'Tienda',
                    page: const ShopPage(), // Navega a ShopPage
                  ),
                  // *************************************
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

  // Widget reutilizable (sin cambios aquí)
  Widget _buildModuleCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required Widget page,
  }) {
    // ... (este código sigue igual)
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
            Icon(icon, size: 50, color: Theme.of(context).colorScheme.primary),
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