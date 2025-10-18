// lib/cart_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/cart_provider.dart';
import 'package:myapp/widgets/cart_item_widget.dart';
// Importaremos OrderConfirmationPage más adelante
import 'package:myapp/order_confirmation_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Escucha los cambios en el CartProvider
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tu Carrito'),
      ),
      body: Column(
        children: <Widget>[
          // Tarjeta con el resumen del total
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(), // Empuja los elementos a los extremos
                  Chip( // Un 'Chip' para resaltar el total
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.titleLarge?.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  // Botón para proceder al pago
                  TextButton(
                    onPressed: (cart.items.isEmpty) ? null : () { // Deshabilitado si el carrito está vacío
                       // Navegar a la página de confirmación con el QR
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => OrderConfirmationPage(
                             // Pasamos los datos necesarios para el QR
                            cartItems: cart.items.values.toList(),
                            totalAmount: cart.totalAmount,
                          ),
                        ),
                      ).then((_){
                          // Opcional: Limpiar carrito después de ver el QR
                          // cart.clearCart();
                      });
                    },
                    child: const Text('COMPRAR AHORA'),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Lista de los items en el carrito
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) {
                final itemEntry = cart.items.entries.elementAt(i);
                return CartItemWidget(
                  cartItem: itemEntry.value,
                  productId: itemEntry.key, // Pasamos el ID del producto
                );
              },
            ),
          )
        ],
      ),
    );
  }
}