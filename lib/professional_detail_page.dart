// lib/professional_detail_page.dart
import 'package:flutter/material.dart';
import 'package:myapp/models/professional_model.dart';
import 'package:table_calendar/table_calendar.dart'; // Importa TableCalendar
import 'package:intl/intl.dart'; // Para formatear fechas/horas
import 'dart:convert'; // Para JSON
import 'package:myapp/qr_display_page.dart'; // Importa la página del QR

class ProfessionalDetailPage extends StatefulWidget {
  final Professional professional;

  const ProfessionalDetailPage({super.key, required this.professional});

  @override
  State<ProfessionalDetailPage> createState() => _ProfessionalDetailPageState();
}

class _ProfessionalDetailPageState extends State<ProfessionalDetailPage> {
  // --- Estado para el Calendario y Hora ---
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String? _selectedTimeSlot;

  // Obtiene las horas disponibles para un día específico (misma función que antes)
  List<String> _getAvailableSlotsForDay(DateTime day) {
    return widget.professional.availableSlots[day.weekday] ?? [];
  }

  // Genera los datos del QR y navega a la página QrDisplayPage
  void _generateAndNavigateToQrPage() {
    if (_selectedDay == null || _selectedTimeSlot == null) {
       // Muestra un mensaje si no se ha completado la selección
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, selecciona un día y una hora.'),
          backgroundColor: Colors.orange,
         ),
      );
      return;
    }

    // Datos del usuario (ejemplo)
    const String userName = "Alex Morgan";
    const String userId = "USER_ID_123456789";

    final appointmentData = {
      'userId': userId,
      'userName': userName,
      'professionalId': widget.professional.id,
      'professionalName': widget.professional.name,
      'date': DateFormat('yyyy-MM-dd').format(_selectedDay!),
      'time': _selectedTimeSlot!,
      'timestamp': DateTime.now().toIso8601String(),
    };

    final qrDataString = jsonEncode(appointmentData);
    final appointmentDetailsString = 'Fecha: ${DateFormat('dd/MM/yyyy', 'es_ES').format(_selectedDay!)} Hora: $_selectedTimeSlot';

    // Navega a la página del QR
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => QrDisplayPage(
          qrData: qrDataString,
          professionalName: widget.professional.name,
          appointmentDetails: appointmentDetailsString,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final availableSlots = _selectedDay != null ? _getAvailableSlotsForDay(_selectedDay!) : <String>[];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.professional.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 80.0), // Padding extra abajo para el botón flotante
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Encabezado con Foto y Nombre ---
            Row(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundImage: NetworkImage(widget.professional.imageUrl),
                  onBackgroundImageError: (_, __) {},
                  backgroundColor: Colors.grey[700],
                  child: NetworkImage(widget.professional.imageUrl).url.isEmpty
                         ? Text(widget.professional.name.substring(0,1), style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold))
                         : null,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.professional.name,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _getCategoryName(widget.professional.category),
                        style: TextStyle(fontSize: 16, color: Colors.grey[400]),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 24),
            const Divider(),

            // --- Descripción Detallada ---
            _buildDetailSectionTitle('Acerca de mí'),
            Text(
              widget.professional.description,
              style: TextStyle(fontSize: 16, color: Colors.grey[300], height: 1.4),
            ),
            const SizedBox(height: 20),

            // --- Área de Enfoque ---
            _buildDetailSectionTitle('Área de Enfoque'),
            Text(
              widget.professional.focusArea,
              style: TextStyle(fontSize: 16, color: Colors.grey[300]),
            ),
            const SizedBox(height: 20),

            // --- Horarios de Atención ---
            _buildDetailSectionTitle('Horarios Generales'),
            Text(
              widget.professional.availability,
              style: TextStyle(fontSize: 16, color: Colors.grey[300]),
            ),
            const SizedBox(height: 30),
            const Divider(),

            // --- Sección de Agendar Cita ---
            _buildDetailSectionTitle('Agendar Cita'),
            const Text('1. Selecciona el día:', style: TextStyle(fontSize: 16)),
             // --- Calendario ---
             Card( // Envuelve el calendario en una Card para mejor estética
               clipBehavior: Clip.antiAlias, // Evita que el calendario se salga
               margin: const EdgeInsets.symmetric(vertical: 10.0),
               elevation: 2,
               child: TableCalendar(
                locale: 'es_ES',
                firstDay: DateTime.now().subtract(const Duration(days: 1)),
                lastDay: DateTime.now().add(const Duration(days: 60)),
                focusedDay: _focusedDay,
                calendarFormat: CalendarFormat.month,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                enabledDayPredicate: (day) {
                    return (day.isAfter(DateTime.now().subtract(const Duration(days: 1))) || isSameDay(day, DateTime.now())) &&
                           _getAvailableSlotsForDay(day).isNotEmpty;
                  },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    if (isSameDay(_selectedDay, selectedDay)) {
                       _selectedDay = null;
                       _selectedTimeSlot = null;
                    } else {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      _selectedTimeSlot = null;
                    }
                  });
                },
                headerStyle: const HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                ),
                calendarStyle: CalendarStyle(
                  outsideDaysVisible: false,
                  disabledTextStyle: TextStyle(color: Colors.grey.withAlpha((255 * 0.5).round())),
                  selectedDecoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withAlpha((255 * 0.5).round()),
                    shape: BoxShape.circle,
                  ),
                ),
               ),
             ),
             const SizedBox(height: 20),

             // --- Selector de Hora ---
            if (_selectedDay != null) ...[
              const Text('2. Selecciona la hora:', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              if (availableSlots.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'No hay horarios disponibles para este día.',
                    style: TextStyle(color: Colors.grey)
                  ),
                ),
              if (availableSlots.isNotEmpty)
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: availableSlots.map((time) {
                    final isSelected = _selectedTimeSlot == time;
                    return ChoiceChip(
                      label: Text(time),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedTimeSlot = selected ? time : null;
                        });
                      },
                      selectedColor: Theme.of(context).colorScheme.primary.withAlpha((255 * 0.7).round()),
                      labelStyle: TextStyle(
                        color: isSelected ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                      backgroundColor: isSelected ? null : Theme.of(context).chipTheme.backgroundColor,
                      shape: StadiumBorder(side: BorderSide(color: isSelected ? Colors.transparent : Colors.grey)),
                    );
                  }).toList(),
                ),
            ],
            const SizedBox(height: 40), // Espacio extra antes del botón flotante
          ],
        ),
      ),
      // --- Botón Flotante para Confirmar Cita ---
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // Posición
      floatingActionButton: FloatingActionButton.extended(
          onPressed: _generateAndNavigateToQrPage, // Llama a la función para generar QR y navegar
          label: const Text('Confirmar Cita'),
          icon: const Icon(Icons.check),
          // Puedes deshabilitar visualmente si no hay selección, aunque la función ya valida
          backgroundColor: (_selectedDay != null && _selectedTimeSlot != null)
                           ? Theme.of(context).colorScheme.primary
                           : Colors.grey,
       ),
    );
  }

  // Widget auxiliar para títulos de sección (sin cambios)
  Widget _buildDetailSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.amber,
        ),
      ),
    );
  }

   // Función auxiliar para obtener el nombre legible de la categoría (sin cambios)
  String _getCategoryName(ServiceCategory category) {
    switch (category) {
      case ServiceCategory.coach: return 'Coach Personal';
      case ServiceCategory.nutriologo: return 'Nutriólogo';
      case ServiceCategory.masaje: return 'Masaje Deportivo';
    }
  }
}