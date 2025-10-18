// lib/qr_scanner_page.dart
import 'dart:typed_data'; // Necesario para Uint8List
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
  final MobileScannerController cameraController = MobileScannerController(
    // Valores iniciales (pueden ser ajustados luego)
    // facing: CameraFacing.back, // Ya no se configura aquí directamente
    // torchEnabled: false,      // Ya no se configura aquí directamente
     returnImage: false, // Por defecto es false, pon true si necesitas la imagen del frame
  );
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear QR de Máquina'),
        actions: [
          // ***** CAMBIO DEFINITIVO AQUÍ *****
          // Botón para la linterna (Flash)
          IconButton(
            // El color y el ícono dependen del estado actual del controlador
            color: cameraController.torchEnabled
                ? Theme.of(context).colorScheme.primary
                : Colors.grey,
            icon: Icon(
              cameraController.torchEnabled ? Icons.flash_on : Icons.flash_off,
            ),
            tooltip: 'Linterna',
            onPressed: () async {
              // Llama a toggleTorch y luego fuerza la reconstrucción para actualizar el icono
              await cameraController.toggleTorch();
              if (mounted) {
                setState(() {}); // Actualiza el estado del widget para reflejar el cambio de icono
              }
            },
          ),
          // Botón para cambiar cámara
          IconButton(
             // El icono depende de la cámara actual
             icon: Icon(
                cameraController.cameraFacing == CameraFacing.front
                   ? Icons.camera_front
                   : Icons.camera_rear,
                color: Theme.of(context).colorScheme.primary,
             ),
            tooltip: 'Cambiar cámara',
            onPressed: () async {
               // Llama a switchCamera y luego fuerza la reconstrucción
              await cameraController.switchCamera();
              if (mounted) {
                 setState(() {}); // Actualiza el estado del widget
              }
            },
          ),
          // ***** FIN DEL CAMBIO DEFINITIVO *****
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: (capture) {
              if (_isProcessing) return;

              final List<Barcode> barcodes = capture.barcodes;
              // final Uint8List? image = capture.image; // Descomenta si necesitas la imagen

              if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
                final String code = barcodes.first.rawValue!;
                print('Código QR detectado: $code');
                setState(() {
                  _isProcessing = true;
                });
                _handleScanResult(code);
              }
            },
            scanWindow: Rect.fromCenter(
              center: MediaQuery.of(context).size.center(Offset.zero),
              width: 250,
              height: 250,
            ),
          ),
          // Overlay visual (recuadro)
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 2),
              ),
            ),
          ),
          // Texto de ayuda
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 60),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.65),
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

  void _handleScanResult(String scannedCode) {
    Exercise? foundExercise;
    try {
      foundExercise = allExercises.firstWhere((ex) => ex.id == scannedCode);
    } catch (e) {
      foundExercise = null;
      print('Ejercicio no encontrado para el código: $scannedCode');
    }

    if (foundExercise != null) {
      // Opcional: cameraController.stop();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ExerciseDetailPage(exercise: foundExercise!),
        ),
      ).then((_) => _resetScanner());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Código QR no reconocido: $scannedCode'),
          backgroundColor: Colors.redAccent,
          duration: const Duration(seconds: 3),
        ),
      ).closed.then((_) => _resetScanner());
    }
  }

  void _resetScanner() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
        // Opcional: try { cameraController.start(); } catch(e) { print("Error restarting camera: $e");}
      }
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}

extension on MobileScannerController {
  get cameraFacing => null;
}