// lib/widgets/professional_profile_card.dart
import 'package:flutter/material.dart';
import 'package:myapp/models/professional_model.dart';
import 'package:myapp/professional_detail_page.dart';

class ProfessionalProfileCard extends StatelessWidget {
  final Professional professional;

  const ProfessionalProfileCard({super.key, required this.professional});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250, // Ancho fijo para la tarjeta
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Foto y Nombre
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(professional.imageUrl),
                     onBackgroundImageError: (_, __) {}, // Manejo de error si la imagen falla
                     backgroundColor: Colors.grey[700], // Color de fondo si no hay imagen
                     child: NetworkImage(professional.imageUrl).url.isEmpty
                         ? Text(professional.name.substring(0,1), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)) // Inicial si no hay URL
                         : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded( // Para que el nombre no se desborde
                    child: Text(
                      professional.name,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis, // Evita desbordamiento
                    ),
                  ),
                ],
              ),
              const Divider(height: 20),
              // Descripción corta
              Text(
                professional.description,
                style: TextStyle(fontSize: 14, color: Colors.grey[300]),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              // Área de enfoque
              Text.rich(
                 TextSpan(
                  children: [
                     const TextSpan(text: 'Enfoque: ', style: TextStyle(fontWeight: FontWeight.bold)),
                     TextSpan(text: professional.focusArea, style: TextStyle(color: Colors.grey[300])),
                   ]
                 ),
                 style: const TextStyle(fontSize: 14),
                 maxLines: 1,
                 overflow: TextOverflow.ellipsis,
              ),
               const SizedBox(height: 8),
              // Disponibilidad
               Text.rich(
                 TextSpan(
                  children: [
                     const TextSpan(text: 'Horario: ', style: TextStyle(fontWeight: FontWeight.bold)),
                     TextSpan(text: professional.availability, style: TextStyle(color: Colors.grey[300])),
                   ]
                 ),
                 style: const TextStyle(fontSize: 14),
                  maxLines: 1,
                 overflow: TextOverflow.ellipsis,
              ),
              // ***** CAMBIO EN EL BOTÓN *****
              Center(
                child: OutlinedButton( // Cambiamos a OutlinedButton para diferenciarlo
                  // icon: const Icon(Icons.info_outline, size: 18), // Puedes quitar el ícono si prefieres
                  onPressed: () {
                    // Navega a la nueva página de detalles
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfessionalDetailPage(professional: professional),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                     foregroundColor: Theme.of(context).colorScheme.primary, // Color del texto
                     side: BorderSide(color: Theme.of(context).colorScheme.primary), // Borde del color primario
                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                     textStyle: const TextStyle(fontSize: 14),
                  ), // Cambiamos a OutlinedButton para diferenciarlo
                  // icon: const Icon(Icons.info_outline, size: 18), // Puedes quitar el ícono si prefieres
                  child: const Text('Más Información'),
                ),
              ),
              // ***** FIN DEL CAMBIO *****
            ],
          ),
        ),
      ),
    );
  }
}