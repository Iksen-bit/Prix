// lib/asistencia_page.dart
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AsistenciaPage extends StatelessWidget {
  const AsistenciaPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Datos de ejemplo del usuario
    const String userName = "Alex Morgan";
    const String userQrData = "USER_ID_123456789"; // El dato que contendrá el QR
    const int userAge = 28;
    const double userWeight = 72.5;
    const double userHeight = 175.0;

    return Scaffold(
      // Barra superior con un estilo limpio
      appBar: AppBar(
        title: const Text('Acceso al Gimnasio'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        // Botón de regreso que ya viene por defecto
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Foto de perfil del usuario
              const CircleAvatar(
                radius: 60,
                // Asegúrate de tener una imagen de placeholder en tus assets
                // Por ahora, usaremos un ícono
                backgroundColor: Colors.white12,
                child: Icon(
                  Icons.person,
                  size: 70,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),

              // Nombre del usuario
              const Text(
                userName,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),

              // Mensaje de bienvenida
              Text(
                'Usa este código para acceder',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(height: 32),

              // Tarjeta principal con el QR y los datos
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: const Color.fromARGB(230, 33, 33, 33),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      // Widget del Código QR
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: QrImageView(
                          data: userQrData,
                          version: QrVersions.auto,
                          size: 180.0,
                          gapless: false,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Divider(),
                      const SizedBox(height: 16),
                      
                      // Fila con los datos del usuario
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildUserInfo('Edad', '$userAge años'),
                          _buildUserInfo('Peso', '$userWeight kg'),
                          _buildUserInfo('Altura', '$userHeight cm'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Botón para regresar al menú principal
              ElevatedButton.icon(
                icon: const Icon(Icons.arrow_back),
                label: const Text('Menú Principal'),
                onPressed: () {
                  // Esta función te regresa a la pantalla anterior
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget reutilizable para mostrar la información del usuario
  Widget _buildUserInfo(String label, String value) {
    return Column(
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}