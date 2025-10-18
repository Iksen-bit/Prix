// lib/find_exercise_page.dart
import 'package:flutter/material.dart';
// Crearemos esta página en el siguiente paso
import 'package:myapp/qr_scanner_page.dart';

class FindExercisePage extends StatelessWidget {
  const FindExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Encuentra tu Ejercicio'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.qr_code_scanner, size: 100, color: Colors.amber),
            const SizedBox(height: 30),
            const Text(
              'Escanea el código QR en la máquina\npara ver cómo usarla.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              icon: const Icon(Icons.qr_code_scanner_rounded),
              label: const Text('Escanear Máquina (QR)'),
              onPressed: () {
                // Navega a la pantalla del escáner
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QRScannerPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}