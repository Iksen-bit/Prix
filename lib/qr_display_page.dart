// lib/qr_display_page.dart
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:provider/provider.dart'; // Necesario para limpiar el carrito
import 'package:myapp/cart_provider.dart'; // Importa CartProvider si limpias aquí
import 'package:myapp/home_page.dart';    // Importa HomePage

class QrDisplayPage extends StatelessWidget {
  final String qrData;
  final String professionalName;
  final String appointmentDetails; // Texto combinado de fecha y hora

  const QrDisplayPage({
    super.key,
    required this.qrData,
    required this.professionalName,
    required this.appointmentDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // No necesitamos AppBar aquí
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Cita Confirmada',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Muestra este QR para registrar tu cita:',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                // Contenedor blanco para el QR
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                       BoxShadow(
                        color: Color.fromARGB(51, 0, 0, 0), // Negro con 20% opacidad
                        spreadRadius: 2,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: QrImageView(
                    data: qrData,
                    version: QrVersions.auto,
                    size: 250.0, // Tamaño grande
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Profesional: $professionalName',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(appointmentDetails, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 40),
                // Botón para volver al menú principal
                ElevatedButton.icon(
                  icon: const Icon(Icons.home),
                  label: const Text('Menú Principal'),
                  onPressed: () {
                    // Opcional: Limpiar carrito aquí si aplica a citas también
                    // Provider.of<CartProvider>(context, listen: false).clearCart();

                    // Navega a HomePage y elimina todas las rutas anteriores
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const HomePage()),
                      (Route<dynamic> route) => false,
                    );
                  },
                   style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}