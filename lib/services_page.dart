// lib/services_page.dart
import 'package:flutter/material.dart';
import 'package:myapp/data/dummy_data.dart';
import 'package:myapp/models/professional_model.dart';
// Crearemos este widget después
import 'package:myapp/widgets/professional_profile_card.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  // Función auxiliar para obtener el título de la categoría
  String _getCategoryTitle(ServiceCategory category) {
    switch (category) {
      case ServiceCategory.coach: return 'Coaches Personales';
      case ServiceCategory.nutriologo: return 'Nutriólogos';
      case ServiceCategory.masaje: return 'Masaje Deportivo';
    }
  }

  // Función auxiliar para obtener el ícono de la categoría
  IconData _getCategoryIcon(ServiceCategory category) {
     switch (category) {
      case ServiceCategory.coach: return Icons.fitness_center;
      case ServiceCategory.nutriologo: return Icons.restaurant_menu; // O Icons.food_bank
      case ServiceCategory.masaje: return Icons.spa; // O Icons.healing
    }
  }

  @override
  Widget build(BuildContext context) {
    // Agrupa a los profesionales por categoría
    final Map<ServiceCategory, List<Professional>> groupedProfessionals = {};
    for (var prof in allProfessionals) {
      (groupedProfessionals[prof.category] ??= []).add(prof);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuestros Servicios'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: groupedProfessionals.length, // Número de categorías
        itemBuilder: (context, index) {
          final category = groupedProfessionals.keys.elementAt(index);
          final professionalsInCategory = groupedProfessionals[category]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título de la sección de categoría
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                child: Row(
                   children: [
                     Icon(_getCategoryIcon(category), color: Theme.of(context).colorScheme.primary),
                     const SizedBox(width: 8),
                     Text(
                      _getCategoryTitle(category),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber, // Color del tema
                       ),
                     ),
                   ],
                ),
              ),
              // Lista horizontal de perfiles para esta categoría
              SizedBox(
                height: 280, // Altura fija para las tarjetas de perfil
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: professionalsInCategory.length,
                  itemBuilder: (ctx, profIndex) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16.0, bottom: 8.0), // Espacio entre tarjetas
                      child: ProfessionalProfileCard(
                        professional: professionalsInCategory[profIndex],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}