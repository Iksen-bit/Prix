// lib/exercise_detail_page.dart
import 'package:flutter/material.dart';
import 'package:myapp/models/exercise_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ExerciseDetailPage extends StatefulWidget {
  final Exercise exercise;
  const ExerciseDetailPage({super.key, required this.exercise});

  @override
  State<ExerciseDetailPage> createState() => _ExerciseDetailPageState();
}

class _ExerciseDetailPageState extends State<ExerciseDetailPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    final videoId = widget.exercise.videoUrl;

    // Construimos una página HTML simple para incrustar el video.
    // Esto nos da control total y es muy estable.
    final htmlContent = """
      <!DOCTYPE html>
      <html>
        <head>
          <style>
            body, html {
              margin: 0;
              padding: 0;
              height: 100%;
              overflow: hidden;
              background-color: black;
            }
          </style>
        </head>
        <body>
          <iframe
            width="100%"
            height="100%"
            src="https://www.youtube.com/embed/$videoId?autoplay=1&loop=1&playlist=$videoId"
            frameborder="0"
            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
            allowfullscreen>
          </iframe>
        </body>
      </html>
    """;

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(htmlContent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exercise.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Contenedor del WebView para el video
            AspectRatio(
              aspectRatio: 16 / 9,
              child: WebViewWidget(controller: _controller),
            ),
            
            // Contenido de la descripción y pasos
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Descripción
                  Text(
                    widget.exercise.description,
                    style: TextStyle(fontSize: 16, color: Colors.grey[300]),
                  ),
                  const SizedBox(height: 24),
                  
                  // Título de los Pasos
                  const Text(
                    'Paso a Paso',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const Divider(thickness: 1, height: 16),
                  
                  // Lista de Pasos
                  ...widget.exercise.steps.asMap().entries.map((entry) {
                    int idx = entry.key;
                    String step = entry.value;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 14,
                            child: Text('${idx + 1}'),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              step,
                              style: const TextStyle(fontSize: 16, height: 1.4),
                            ),
                          ),
                        ],
                      ),
                    );
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}