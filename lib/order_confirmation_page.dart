// lib/order_confirmation_page.dart
import 'package:flutter/material.dart';
import 'package:myapp/models/cart_item_model.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert'; // Para codificar los datos en JSON para el QR
import 'package:provider/provider.dart';
import 'package:myapp/cart_provider.dart';
import 'package:myapp/home_page.dart'; // Añade esto si no está

class OrderConfirmationPage extends StatelessWidget {
  final List<CartItem> cartItems;
  final double totalAmount;

  const OrderConfirmationPage({
    super.key,
    required this.cartItems,
    required this.totalAmount,
  });

  // Función para generar los datos que irán en el QR
  String _generateQrData() {
    // Datos básicos del usuario (ejemplo, podrías obtenerlos de un provider de autenticación)
    const String userName = "Alex Morgan";
    const String userId = "USER_ID_123456789";
    
    // Simplifica la lista de items para el QR
    final List<Map<String, dynamic>> itemsForQr = cartItems.map((item) => {
      'id': item.product.id,
      'name': item.product.name,
      'qty': item.quantity,
      'price': item.product.price,
    }).toList();

    // Estructura los datos como un objeto JSON
    final Map<String, dynamic> orderData = {
      'userId': userId,
      'userName': userName,
      'total': totalAmount,
      'items': itemsForQr,
      'timestamp': DateTime.now().toIso8601String(), // Añade fecha y hora
    };

    // Convierte el objeto a una cadena JSON
    return jsonEncode(orderData);
  }

  @override
  Widget build(BuildContext context) {
    final String qrData = _generateQrData();

    return Scaffold(
      // appBar: AppBar(
      //  title: const Text('Confirmación de Orden'),
      // ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '¡Gracias por tu compra!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Muestra este código QR en caja para completar tu pedido.',
                style: TextStyle(fontSize: 16, color: Colors.grey[400]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Contenedor blanco para el QR
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(51, 0, 0, 0), // ARGB: Alfa(51/255 ≈ 0.2), Rojo(0), Verde(0), Azul(0)
                      spreadRadius: 2,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: QrImageView(
                  data: qrData,
                  version: QrVersions.auto,
                  size: 250.0, // Tamaño más grande para el QR final
                  gapless: false,
                  // Puedes añadir un logo en el centro si quieres
                  // embeddedImage: AssetImage('assets/images/logo_small.png'),
                  // embeddedImageStyle: QrEmbeddedImageStyle(size: Size(40, 40)),
                ),
              ),
              const SizedBox(height: 24),

              // Resumen rápido del total
              Text(
                'Total: \$${totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 40),

              // Botón para volver al inicio (o a la tienda)
              ElevatedButton.icon(
                icon: const Icon(Icons.home),
                label: const Text('Volver al Inicio'),
                onPressed: () {
                  // Cierra todas las pantallas hasta llegar a la HomePage
                  // Navega a HomePage y elimina todas las rutas anteriores
                  Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const HomePage()), // Asegúrate de importar HomePage
                  (Route<dynamic> route) => false, // Esta condición elimina todas las rutas anteriores
                  );
                   // Opcional: Limpiar el carrito aquí si no lo hiciste antes
                   Provider.of<CartProvider>(context, listen: false).clearCart();
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
    );
  }
}