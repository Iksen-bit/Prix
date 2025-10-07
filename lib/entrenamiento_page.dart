import 'package:flutter/material.dart';

class EntrenamientoPage extends StatelessWidget {
  const EntrenamientoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Entrenamiento')),
      body: const Center(
        child: Text('Página de Entrenamiento'),
      ),
    );
  }
}