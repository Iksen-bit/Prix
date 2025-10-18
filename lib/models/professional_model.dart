// lib/models/professional_model.dart

enum ServiceCategory { coach, nutriologo, masaje }

class Professional {
  final String id;
  final String name;
  final ServiceCategory category;
  final String description;
  final String focusArea; // Área de enfoque
  final String availability; // Horarios
  final String imageUrl; // Foto de perfil (usaremos placeholders)
  // Simulación simple de horarios disponibles (ej. Lunes de 9 a 5)
  final Map<int, List<String>> availableSlots; // Día de la semana (1=Lunes): Lista de horas ("09:00", "10:00")

  Professional({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.focusArea,
    required this.availability,
    required this.imageUrl,
    required this.availableSlots,
  });
}