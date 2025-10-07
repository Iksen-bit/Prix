import 'package:flutter/material.dart';

class AsistenciaPage extends StatelessWidget {
  const AsistenciaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Asistencia')),
      body: const Center(
        child: Text('Página de Asistencia'),
      ),
    );
  }
}