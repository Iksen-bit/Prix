// lib/widgets/cart_item_widget.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/models/cart_item_model.dart';
import 'package:myapp/cart_provider.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  final String productId; // Necesitamos el ID para interactuar con el provider

  const CartItemWidget({
    super.key,
    required this.cartItem,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Dismissible( // Permite deslizar para eliminar
      key: ValueKey(productId), // Clave única para el Dismissible
      background: Container(
        color: Theme.of(context).colorScheme.error.withAlpha((255 * 0.7).round()), // Calcula la opacidad (0-255)
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart, // Deslizar de derecha a izquierda
      confirmDismiss: (direction) { // Pide confirmación antes de eliminar
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('¿Estás seguro?'),
            content: const Text('¿Quieres eliminar este artículo del carrito?'),
            actions: <Widget>[
              TextButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.of(ctx).pop(false); // No eliminar
                },
              ),
              TextButton(
                child: const Text('Sí'),
                onPressed: () {
                  Navigator.of(ctx).pop(true); // Sí eliminar
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) { // Si se confirma, elimina el item
        cart.removeItem(productId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(cartItem.product.imageUrl),
              onBackgroundImageError: (_, __) => const Icon(Icons.image_not_supported), // Placeholder si falla la imagen
            ),
            title: Text(cartItem.product.name),
            subtitle: Text('Total: \$${cartItem.totalPrice.toStringAsFixed(2)}'),
            trailing: Row( // Botones para ajustar cantidad
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    cart.removeSingleItem(productId);
                  },
                ),
                Text('${cartItem.quantity} x'), // Muestra la cantidad
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    cart.addItem(cartItem.product); // Añade una unidad del mismo producto
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}