// lib/profile_page.dart
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // --- Datos de Ejemplo ---
  final String userName = "Alex";
  final String userLastName = "Morgan";
  final String userBirthDate = "15/07/1996"; // Formato DD/MM/YYYY
  final String userWeight = "72.5 kg";
  final String userHeight = "175 cm";
  final String userEmail = "alex.morgan@email.com";
  final String userPassword = "••••••••"; // Contraseña oculta
  final int totalVisits = 128;
  final String personalRecord = "Press de Banca: 100 kg";
  final String favoriteExercise = "Sentadillas con Barra";

  // --- Estado del Calendario ---
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  // Simula los días que el usuario asistió (ejemplo)
  final Set<DateTime> _attendedDays = {
    DateTime.utc(2025, 10, 5),
    DateTime.utc(2025, 10, 7),
    DateTime.utc(2025, 10, 10),
    DateTime.utc(2025, 10, 12),
    DateTime.utc(2025, 10, 15),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(...) // AppBar eliminado como solicitaste
      body: SafeArea( // SafeArea para evitar notch/isla dinámica
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Saludo ---
              Text(
                'Hola, $userName!',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              // --- Sección de Asistencia ---
              _buildSectionTitle('Tu Asistencia'),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.fitness_center, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Total de Visitas: $totalVisits',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const Divider(height: 24),
                      // Widget del Calendario
                      TableCalendar(
                        locale: 'es_ES', // Para español si tienes la internacionalización configurada
                        firstDay: DateTime.utc(2024, 1, 1), // Rango del calendario
                        lastDay: DateTime.utc(2030, 12, 31),
                        focusedDay: _focusedDay,
                        calendarFormat: CalendarFormat.month, // Mostrar solo el mes
                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedDay, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay; // Actualiza el día enfocado
                          });
                        },
                        // Marca los días de asistencia
                        calendarBuilders: CalendarBuilders(
                          markerBuilder: (context, day, events) {
                            // Normaliza el día para comparar con _attendedDays
                             final normalizedDay = DateTime.utc(day.year, day.month, day.day);
                            if (_attendedDays.contains(normalizedDay)) {
                              return Positioned(
                                right: 1,
                                bottom: 1,
                                child: _buildAttendanceMarker(),
                              );
                            }
                            return null;
                          },
                        ),
                        headerStyle: const HeaderStyle(
                          titleCentered: true,
                          formatButtonVisible: false, // Oculta el botón de formato (semana/mes)
                        ),
                         calendarStyle: CalendarStyle(
                          // Estilo para los días fuera del mes actual
                          outsideDaysVisible: false,
                          // Estilo para los días de fin de semana
                          weekendTextStyle: TextStyle(color: Theme.of(context).colorScheme.primary.withAlpha((255 * 0.7).round())),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // --- Sección de Récords ---
              _buildSectionTitle('Tus Logros'),
              Row( // Usamos Row para poner dos tarjetas lado a lado
                children: [
                  Expanded( // Expanded para que ocupen el espacio disponible
                    child: _buildInfoCard(
                      icon: Icons.emoji_events,
                      title: 'Récord Personal',
                      value: personalRecord,
                    ),
                  ),
                  const SizedBox(width: 16), // Espacio entre tarjetas
                  Expanded(
                    child: _buildInfoCard(
                      icon: Icons.star,
                      title: 'Ejercicio Favorito',
                      value: favoriteExercise,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // --- Sección de Datos Personales ---
              _buildSectionTitle('Información Personal'),
              _buildPersonalInfoItem('Nombre', userName),
              _buildPersonalInfoItem('Apellido', userLastName),
              _buildPersonalInfoItem('Fecha de Nacimiento', userBirthDate),
              _buildPersonalInfoItem('Peso', userWeight),
              _buildPersonalInfoItem('Altura', userHeight),
              _buildPersonalInfoItem('Correo Electrónico', userEmail),
              _buildPersonalInfoItem('Contraseña', userPassword),
              const SizedBox(height: 32),

              // --- Botón para Regresar al Menú Principal ---
              Center( // Centra el botón
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Menú Principal'),
                  onPressed: () {
                    Navigator.pop(context); // Simplemente regresa a la pantalla anterior (HomePage)
                  },
                   style: OutlinedButton.styleFrom(
                     foregroundColor: Theme.of(context).colorScheme.primary,
                     side: BorderSide(color: Theme.of(context).colorScheme.primary),
                     padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                     textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Widgets Reutilizables ---

  // Título de sección
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.amber), // Color del tema
      ),
    );
  }

   // Tarjeta de información simple (para récords)
  Widget _buildInfoCard({required IconData icon, required String title, required String value}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 24, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 8),
            Text(title, style: TextStyle(fontSize: 14, color: Colors.grey[400])),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  // Fila para mostrar datos personales
  Widget _buildPersonalInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$label:', style: TextStyle(color: Colors.grey[400])),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  // Marcador para los días de asistencia en el calendario
  Widget _buildAttendanceMarker() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.green[400], // Un color para indicar asistencia
      ),
      width: 7.0,
      height: 7.0,
      margin: const EdgeInsets.symmetric(horizontal: 1.5),
    );
  }
}