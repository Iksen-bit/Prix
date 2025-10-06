import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      // Desactiva la cinta de "Debug" en la esquina superior derecha
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Usamos un tema oscuro para un look moderno
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey,
        // Define un color de resalte
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        // Estilo global para los campos de texto
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
      // La pantalla de inicio de nuestra app ahora es LoginPage
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // SafeArea asegura que la UI no se superponga con los elementos del sistema (notch, barra de estado)
      body: SafeArea(
        child: Center(
          // Padding añade espacio alrededor del contenido para que no toque los bordes de la pantalla
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            // Column organiza los widgets de forma vertical
            child: Column(
              // Centra los hijos verticalmente en la columna
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 1. Logo 🎨
                const FlutterLogo(
                  size: 100,
                  style: FlutterLogoStyle.horizontal,
                  textColor: Colors.white,
                ),
                // Espacio vertical
                const SizedBox(height: 48.0),

                // 2. Texto de bienvenida 👋
                const Text(
                  '¡Bienvenido de vuelta!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Inicia sesión para continuar',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[400],
                  ),
                ),
                const SizedBox(height: 32.0),

                // 3. TextField para el correo o usuario 📧
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Correo Electrónico',
                    prefixIcon: Icon(Icons.email_outlined),
                    filled: true,
                    fillColor: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 16.0),

                // Puedes añadir otro TextField para la contraseña si lo necesitas
                // TextField(
                //   obscureText: true, // Oculta el texto para contraseñas
                //   decoration: InputDecoration(
                //     labelText: 'Contraseña',
                //     prefixIcon: Icon(Icons.lock_outline),
                //     filled: true,
                //     fillColor: Colors.grey[800],
                //   ),
                // ),
                // const SizedBox(height: 32.0),

                // 4. Botón de Login 🚀
                // Usamos SizedBox para hacer que el botón ocupe todo el ancho disponible
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Aquí irá la lógica para iniciar sesión
                      print('Botón de login presionado!');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      backgroundColor: Colors.deepPurple, // Color del botón
                      foregroundColor: Colors.white, // Color del texto del botón
                    ),
                    child: const Text(
                      'Iniciar Sesión',
                      style: TextStyle(fontSize: 18),
                    ),
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