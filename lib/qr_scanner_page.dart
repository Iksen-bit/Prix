// lib/qr_scanner_page.dart
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart'; // Asegúrate de que este sea el import
import 'package:myapp/data/dummy_data.dart';
import 'package:myapp/models/exercise_model.dart';
import 'package:myapp/exercise_detail_page.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  // Inicializa el controlador aquí
  final MobileScannerController cameraController = MobileScannerController(
    // Opciones opcionales:
    // facing: CameraFacing.back, // Cámara trasera por defecto
    // torchEnabled: false, // Linterna apagada por defecto
  );
  bool _isProcessing = false; // Flag para evitar procesar múltiples veces

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear QR de Máquina'),
        actions: [
          // Botón para la linterna (Flash) - CORREGIDO
          IconButton(
            color: Theme.of(context).colorScheme.primary, // Usa el color primario del tema
            // Usa ValueListenableBuilder para escuchar el estado de la linterna
            icon: ValueListenableBuilder<TorchState>(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return Icon(Icons.flash_on, color: Theme.of(context).colorScheme.primary); // Color primario cuando está encendido
                }
              },
            ),
            tooltip: 'Linterna',
            onPressed: () => cameraController.toggleTorch(), // Función para activar/desactivar
          ),
          // Botón para cambiar cámara - CORREGIDO
          IconButton(
            color: Theme.of(context).colorScheme.primary, // Usa el color primario del tema
            // Usa ValueListenableBuilder para escuchar la cámara activa
            icon: ValueListenableBuilder<CameraFacing>(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                // Devuelve un ícono diferente según la cámara activa
                return state == CameraFacing.front
                    ? const Icon(Icons.camera_front)
                    : const Icon(Icons.camera_rear);
              },
            ),
            tooltip: 'Cambiar cámara',
            onPressed: () => cameraController.switchCamera(), // Función para cambiar
          ),
        ],
      ),
      body: Stack( // Stack para superponer elementos sobre la vista de la cámara
        children: [
          MobileScanner(
            controller: cameraController, // Asigna el controlador inicializado
            onDetect: (capture) {
              // Si ya estamos procesando un código, salimos para evitar repeticiones
              if (_isProcessing) return;

              final List<Barcode> barcodes = capture.barcodes;

              // Si se detectó al menos un código y tiene valor...
              if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
                final String code = barcodes.first.rawValue!;
                 print('Código QR detectado: $code');

                // Marcamos que estamos procesando y llamamos a la función que maneja el resultado
                setState(() {
                  _isProcessing = true;
                });
                _handleScanResult(code);
              }
            },
            // Define el área visual de escaneo (opcional pero recomendado)
            scanWindow: Rect.fromCenter(
              center: MediaQuery.of(context).size.center(Offset.zero), // Centrado
              width: 250, // Ancho del recuadro de escaneo
              height: 250, // Alto del recuadro de escaneo
            ),
            // Puedes añadir un overlay visual personalizado si quieres
            // overlay: QrScannerOverlayShape(...), // Similar al paquete anterior si quieres ese estilo
          ),
          // Texto de ayuda superpuesto en la parte inferior
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 60),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.65), // Fondo semitransparente
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Apunta al código QR de la máquina',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Función que se llama cuando se detecta un código QR válido
  void _handleScanResult(String scannedCode) {
    Exercise? foundExercise;
    try {
      // Busca en tu lista de ejercicios si alguno coincide con el ID escaneado
      foundExercise = allExercises.firstWhere((ex) => ex.id == scannedCode);
    } catch (e) {
      // Si no se encuentra (firstWhere lanza excepción), foundExercise queda null
      foundExercise = null;
      print('Ejercicio no encontrado para el código: $scannedCode');
    }

    // Si se encontró un ejercicio, navega a la página de detalles
    if (foundExercise != null) {
      Navigator.pushReplacement( // Usa pushReplacement para que al volver, regrese a la home
        context,
        MaterialPageRoute(
          builder: (context) => ExerciseDetailPage(exercise: foundExercise!),
        ),
      ).then((_) => _resetScanner()); // Llama a _resetScanner cuando se regresa de la página de detalles
    } else {
      // Si no se encontró, muestra un mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Código QR no reconocido: $scannedCode'),
          backgroundColor: Colors.redAccent,
          duration: const Duration(seconds: 3), // Duración del mensaje
        ),
      ).closed.then((_) => _resetScanner()); // Llama a _resetScanner después de que el mensaje desaparece
    }
  }

  // Función para reanudar la capacidad de escanear después de un resultado
  void _resetScanner() {
     // Espera un segundo antes de permitir escanear de nuevo
     Future.delayed(const Duration(milliseconds: 1000), () {
        // Asegura que el widget todavía esté montado antes de llamar a setState
        if (mounted) {
          setState(() {
            _isProcessing = false; // Permite una nueva detección
          });
          // No es estrictamente necesario reiniciar cameraController.start() aquí
          // si no lo detuviste explícitamente en onDetect.
        }
     });
  }

  @override
  void dispose() {
    // MUY IMPORTANTE: Libera los recursos del controlador de la cámara al salir de la pantalla
    cameraController.dispose();
    super.dispose();
  }
}